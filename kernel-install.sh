echo " " &&
echo "This script will attempt to install Linux Kernel 5.6 on this machine." &&
echo "Typically, your current version will be kept, and you will be able to ustilise it again later if Kernel 5.6 does not work." &&
echo " " &&
read -p "Press Enter to continue, or abort by pressing CTRL+C" nothing &&
echo " " &&
echo "Downloading Kernel 5.6 Packages" &&
echo "4 Files, ~71 MB to Download" &&
echo " " &&
echo "Creating Kernel Directory in Home folder" &&
echo " " &&
mkdir -p $HOME/howtoubuntu-kernel-5-6 &&
cd $HOME/howtoubuntu-kernel-5-6 &&
echo " " &&
echo "Downloading File 1 of 4, 11 MB" &&
echo " " &&
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.6.6/linux-headers-5.6.6-050606_5.6.6-050606.202004210831_all.deb &&
echo " " &&
echo "64bit Detected" &&
echo " " &&
echo "Downloading File 2 of 4, 1 MB" &&
echo " " &&
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.6.6/linux-headers-5.6.6-050606-generic_5.6.6-050606.202004210831_amd64.deb &&
echo " " &&
echo "Downloading File 3 of 4, 9 MB" &&
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.6.6/linux-image-unsigned-5.6.6-050606-generic_5.6.6-050606.202004210831_amd64.deb &&
echo " " &&
echo "Downloading File 4 of 4, 50 MB" &&
wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.6.6/linux-modules-5.6.6-050606-generic_5.6.6-050606.202004210831_amd64.deb &&
echo " " &&
echo "Installing Kernel" &&
echo "This step will require you password." &&
echo "This is the last step you can safely cancel at." &&
echo "Use Ctrl+C to cancel." &&
echo " " &&
sudo dpkg -i *.deb &&
echo " " &&
echo "Installation Complete" &&
echo " " &&
read -p "Press Enter to Delete the Downloads, or CTRL+C to keep them." nothing &&
echo " " &&
sudo rm -rf $HOME/howtoubuntu-kernel-5-6
