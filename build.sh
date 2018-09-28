set -e 
nasm boot.asm -f bin -o boot.bin
qemu-system-i386 -fda boot.bin
# Don't recommend doing this next part automatically
# If you're on a mac, insert a usb and run 
# diskutil list 
# From there you'll be able to tell what goes at the end of the next line: (say a directory to a 4gig usb)
# sudo dd if=boot.bin of=/dev/disk1
