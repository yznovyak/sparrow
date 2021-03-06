
use std::sync::Arc;
use std::sync::RwLock;
use rand::Rng;

use std::thread::spawn;
use rand::thread_rng;

use commons::channel::Receiver;
use commons::ExampleWithScore;
use commons::performance_monitor::PerformanceMonitor;


pub struct Gatherer {
    gather_new_sample: Receiver<(ExampleWithScore, u32)>,
    new_sample_buffer: Arc<RwLock<Option<Vec<ExampleWithScore>>>>,
    new_sample_capacity: usize,
}


impl Gatherer {
    /// * `new_sample_buffer`: the reference to the alternate memory buffer of the buffer loader
    /// * `new_sample_capacity`: the size of the memory buffer of the buffer loader
    pub fn new(
        gather_new_sample: Receiver<(ExampleWithScore, u32)>,
        new_sample_buffer: Arc<RwLock<Option<Vec<ExampleWithScore>>>>,
        new_sample_capacity: usize,
    ) -> Gatherer {
        Gatherer {
            gather_new_sample: gather_new_sample,
            new_sample_buffer: new_sample_buffer,
            new_sample_capacity: new_sample_capacity,
        }
    }

    /// Start the gatherer.
    ///
    /// Fill the alternate memory buffer of the buffer loader
    pub fn run(&self, blocking: bool) {
        let new_sample_capacity = self.new_sample_capacity;
        let new_sample_buffer = self.new_sample_buffer.clone();
        let gather_new_sample = self.gather_new_sample.clone();
        if blocking {
            info!("Starting blocking gatherer");
            fill_buffer(new_sample_capacity, new_sample_buffer, gather_new_sample);
        } else {
            info!("Starting non-blocking gatherer");
            spawn(move || {
                loop {
                    fill_buffer(
                        new_sample_capacity.clone(),
                        new_sample_buffer.clone(),
                        gather_new_sample.clone(),
                    );
                }
            });
        }
    }
}


fn fill_buffer(
    new_sample_capacity: usize,
    new_sample_buffer: Arc<RwLock<Option<Vec<ExampleWithScore>>>>,
    gather_new_sample: Receiver<(ExampleWithScore, u32)>,
) {
    debug!("start filling the alternate buffer");
    let mut pm = PerformanceMonitor::new();
    pm.start();

    let mut new_sample = Vec::with_capacity(new_sample_capacity);
    while new_sample.len() < new_sample_capacity {
        if let Some((example, mut c)) = gather_new_sample.recv() {
            // `c` is the number of times this example should be put into the sample set
            while new_sample.len() < new_sample_capacity && c > 0 {
                new_sample.push(example.clone());
                c -= 1;
            }
        }
    }
    thread_rng().shuffle(&mut new_sample);
    {
        let new_sample_lock = new_sample_buffer.write();
        *(new_sample_lock.unwrap()) = Some(new_sample);
    }
    debug!("new-sample, {}", new_sample_capacity as f32 / pm.get_duration());
}


#[cfg(test)]
mod tests {
    use std::thread::sleep;

    use std::sync::Arc;
    use std::sync::RwLock;
    use std::time::Duration;

    use commons::channel;
    use commons::ExampleWithScore;
    use labeled_data::LabeledData;
    use super::Gatherer;
    use ::TFeature;

    #[test]
    fn test_sampler_nonblocking() {
        let (gather_sender, gather_receiver) = channel::bounded(10, "gather-samples");
        let mem_buffer = Arc::new(RwLock::new(None));
        let gatherer = Gatherer::new(gather_receiver, mem_buffer.clone(), 100);
        gatherer.run(false);

        let mut examples: Vec<ExampleWithScore> = vec![];
        for i in 0..100 {
            let t = get_example(vec![i as TFeature, 1, 2], 0.0);
            gather_sender.send((t.clone(), 1));
            examples.push(t);
        }
        sleep(Duration::from_millis(1000));  // wait for the gatherer releasing the new sample
        let mut all_sampled = {
            let mut mem_buffer = mem_buffer.write().unwrap();
            assert!(mem_buffer.is_some());  // will poison the lock if this fails
            mem_buffer.take().unwrap()
        };
        all_sampled.sort_by(|t1, t2| (t1.0).feature[0].partial_cmp(&(t2.0).feature[0]).unwrap());
        for (input, output) in examples.iter().zip(all_sampled.iter()) {
            assert_eq!(*input, *output);
        }
    }

    #[test]
    fn test_sampler_blocking() {
        let (gather_sender, gather_receiver) = channel::bounded(200, "gather-samples");
        let mem_buffer = Arc::new(RwLock::new(None));
        let gatherer = Gatherer::new(gather_receiver, mem_buffer.clone(), 100);

        let mut examples: Vec<ExampleWithScore> = vec![];
        for i in 0..100 {
            let t = get_example(vec![i as TFeature, 1, 2], 0.0);
            gather_sender.send((t.clone(), 1));
            examples.push(t);
        }
        gatherer.run(true);
        let mut all_sampled = {
            let mut mem_buffer = mem_buffer.write().unwrap();
            assert!(mem_buffer.is_some());  // will poison the lock if this fails
            mem_buffer.take().unwrap()
        };
        all_sampled.sort_by(|t1, t2| (t1.0).feature[0].partial_cmp(&(t2.0).feature[0]).unwrap());
        for (input, output) in examples.iter().zip(all_sampled.iter()) {
            assert_eq!(*input, *output);
        }
    }

    fn get_example(features: Vec<TFeature>, score: f32) -> ExampleWithScore {
        let label: i8 = -1;
        let example = LabeledData::new(features, label);
        (example, (score, 0))
    }
}