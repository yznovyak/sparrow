sudo umount /mnt
yes | sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=2 /dev/xvdca /dev/xvdcb
sudo mkfs.ext4 -L MY_RAID /dev/md0
sudo mount LABEL=MY_RAID /mnt

git config --global user.name "Julaiti Alafate"
git config --global user.email "Julaiti Alafate"
cd /mnt
git clone https://github.com/arapat/rust-boost.git

sudo apt-get update
sudo apt-get install cargo
cd rust-boost
cargo build --release

sudo chown -R ubuntu /mnt

