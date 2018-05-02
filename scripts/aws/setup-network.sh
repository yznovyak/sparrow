nodes=(
ec2-54-145-49-12.compute-1.amazonaws.com
ec2-54-91-21-47.compute-1.amazonaws.com
ec2-54-172-162-139.compute-1.amazonaws.com
ec2-34-201-217-224.compute-1.amazonaws.com
ec2-54-84-91-228.compute-1.amazonaws.com
ec2-52-91-139-75.compute-1.amazonaws.com
ec2-54-152-238-186.compute-1.amazonaws.com
ec2-54-234-106-123.compute-1.amazonaws.com
ec2-54-84-254-69.compute-1.amazonaws.com
ec2-204-236-252-111.compute-1.amazonaws.com
ec2-54-173-173-8.compute-1.amazonaws.com
ec2-34-235-163-2.compute-1.amazonaws.com
ec2-18-232-62-108.compute-1.amazonaws.com
ec2-52-90-71-139.compute-1.amazonaws.com
ec2-54-89-44-26.compute-1.amazonaws.com
ec2-34-230-68-167.compute-1.amazonaws.com
ec2-34-238-168-230.compute-1.amazonaws.com
ec2-54-86-52-193.compute-1.amazonaws.com
ec2-54-173-162-25.compute-1.amazonaws.com
ec2-54-89-134-139.compute-1.amazonaws.com
ec2-52-23-180-58.compute-1.amazonaws.com
ec2-54-175-161-189.compute-1.amazonaws.com
ec2-52-87-189-74.compute-1.amazonaws.com
ec2-34-203-195-64.compute-1.amazonaws.com
ec2-54-173-171-137.compute-1.amazonaws.com
ec2-54-174-40-143.compute-1.amazonaws.com
ec2-54-90-227-212.compute-1.amazonaws.com
ec2-54-152-183-97.compute-1.amazonaws.com
ec2-54-147-192-136.compute-1.amazonaws.com
ec2-54-91-103-96.compute-1.amazonaws.com
ec2-54-90-180-128.compute-1.amazonaws.com
ec2-54-204-201-52.compute-1.amazonaws.com
ec2-52-90-216-234.compute-1.amazonaws.com
ec2-107-23-219-195.compute-1.amazonaws.com
ec2-54-84-117-103.compute-1.amazonaws.com
ec2-54-208-30-58.compute-1.amazonaws.com
ec2-35-170-50-186.compute-1.amazonaws.com
ec2-54-146-42-45.compute-1.amazonaws.com
ec2-35-153-158-177.compute-1.amazonaws.com
ec2-54-91-66-106.compute-1.amazonaws.com
ec2-54-88-17-17.compute-1.amazonaws.com
ec2-34-204-72-21.compute-1.amazonaws.com
ec2-34-229-112-152.compute-1.amazonaws.com
ec2-54-80-175-232.compute-1.amazonaws.com
ec2-54-208-193-171.compute-1.amazonaws.com
ec2-54-236-247-207.compute-1.amazonaws.com
ec2-54-88-152-254.compute-1.amazonaws.com
ec2-54-160-179-3.compute-1.amazonaws.com
ec2-35-153-205-215.compute-1.amazonaws.com
ec2-54-173-174-36.compute-1.amazonaws.com
ec2-54-87-138-124.compute-1.amazonaws.com
ec2-34-226-203-45.compute-1.amazonaws.com
ec2-52-87-199-119.compute-1.amazonaws.com
ec2-52-207-229-103.compute-1.amazonaws.com
ec2-54-242-190-42.compute-1.amazonaws.com
ec2-35-173-223-47.compute-1.amazonaws.com
ec2-54-173-229-43.compute-1.amazonaws.com
ec2-34-235-123-90.compute-1.amazonaws.com
ec2-35-153-162-74.compute-1.amazonaws.com
ec2-52-90-49-86.compute-1.amazonaws.com
ec2-35-153-203-88.compute-1.amazonaws.com
ec2-34-207-240-225.compute-1.amazonaws.com
ec2-54-88-99-169.compute-1.amazonaws.com
ec2-52-87-198-0.compute-1.amazonaws.com
ec2-34-227-67-17.compute-1.amazonaws.com
ec2-54-196-220-119.compute-1.amazonaws.com
ec2-54-175-73-188.compute-1.amazonaws.com
ec2-52-91-251-28.compute-1.amazonaws.com
ec2-54-197-6-159.compute-1.amazonaws.com
ec2-52-55-251-97.compute-1.amazonaws.com
ec2-34-229-102-78.compute-1.amazonaws.com
ec2-52-23-180-7.compute-1.amazonaws.com
ec2-54-237-217-182.compute-1.amazonaws.com
ec2-54-90-163-247.compute-1.amazonaws.com
ec2-34-201-125-109.compute-1.amazonaws.com
ec2-54-209-31-98.compute-1.amazonaws.com
ec2-52-91-142-51.compute-1.amazonaws.com
ec2-34-230-16-237.compute-1.amazonaws.com
ec2-52-201-252-69.compute-1.amazonaws.com
ec2-54-91-82-61.compute-1.amazonaws.com
ec2-34-229-245-159.compute-1.amazonaws.com
ec2-52-207-223-144.compute-1.amazonaws.com
ec2-35-168-10-78.compute-1.amazonaws.com
ec2-54-83-169-63.compute-1.amazonaws.com
ec2-107-23-242-70.compute-1.amazonaws.com
ec2-54-164-236-78.compute-1.amazonaws.com
ec2-54-173-25-194.compute-1.amazonaws.com
ec2-18-232-130-53.compute-1.amazonaws.com
ec2-54-157-31-211.compute-1.amazonaws.com
ec2-54-196-93-155.compute-1.amazonaws.com
ec2-52-204-40-49.compute-1.amazonaws.com
ec2-54-164-20-246.compute-1.amazonaws.com
ec2-54-226-34-153.compute-1.amazonaws.com
ec2-34-228-228-161.compute-1.amazonaws.com
ec2-35-173-204-19.compute-1.amazonaws.com
ec2-34-239-142-15.compute-1.amazonaws.com
ec2-54-83-174-69.compute-1.amazonaws.com
ec2-35-168-11-245.compute-1.amazonaws.com
ec2-54-82-155-27.compute-1.amazonaws.com
ec2-54-174-13-95.compute-1.amazonaws.com
)

export INIT_SCRIPT="/mnt/rust-boost/scripts/aws/init-two_ssd.sh"
export IDENT_FILE="~/jalafate-dropbox.pem"
export GIT_REPO="https://github.com/arapat/rust-boost.git"
export GIT_BRANCH="aws-scale"

if [ $1 = "init" ]; then
    echo "Initialize all computers. Are you sure? (y/N)"
    read yesno
    if [[ "$yesno" != "y" ]] ; then
        echo "Aborted."
        exit 1
    fi

    for i in "${!nodes[@]}";
    do
        url=${nodes[$i]}
        echo
        echo "===== Initializing $url ====="
        echo

        if ssh -o StrictHostKeyChecking=no -i $IDENT_FILE $url test -f /mnt/init-done.txt \> /dev/null 2\>\&1
        then
            echo "The node has been initialized. Skipped."
        else
            # Copy init script
            scp -o StrictHostKeyChecking=no -i $IDENT_FILE $INIT_SCRIPT ubuntu@$url:~/init.sh

            # Execute init script
            ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url sudo bash ~/init.sh

            # Clone repository
            ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url git clone $GIT_REPO /mnt/rust-boost

            # Install cargo
            ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url sudo apt-get update
            ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url sudo apt-get install -y cargo

            ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url touch /mnt/init-done.txt
            echo "Initialization is completed."
        fi
    done

    echo
    echo "Now waiting for training/testing files to be transmitted to all other computers..."
    echo
    wait
fi

# Build package
if [ $1 = "build" ]; then
    for i in "${!nodes[@]}";
    do
        url=${nodes[$i]}
        echo "Building $url"

        ssh -o StrictHostKeyChecking=no -i $IDENT_FILE ubuntu@$url "
            cd /mnt/rust-boost && git checkout -- . && git fetch --all &&
            git checkout $GIT_BRANCH && git pull &&
            cargo build --release" && \
        scp -o StrictHostKeyChecking=no -i $IDENT_FILE /mnt/rust-boost/config.json ubuntu@$url:/mnt/rust-boost/config.json &
    done

    wait

    echo "Package build was executed."
fi
