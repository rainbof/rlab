## Recovery lab
Series of small script to manipulate with images. Written on debian 11, tested on humans, no floppies killed. Must be runned under 
root or have acces to losetup, mount.
Helpful is blood of unicorns.

# dependecies
bash 5
gddrescue
losetup

# backup scripts
ddrescue /dev/sdb xdisk_`date +"%Y%m%d%H%M%S"`.img

# install (if some fails)
this is early version, in root of this project must be these direcories:
diskety/
outdir/
mntdir/

# Magic function and "helpme" section
this function is not implementd, will be implemented later.
maybe

## mount: /home/rainbof/dev/rlab/mntdir: wrong fs type, bad option, bad superblock on /dev/loop59, missing codepage or helper program, or other error.
System (mount) not recognize FS type. Maybe is good idea add option to fix this.

## umount: /home/rainbof/dev/rlab/mntdir: target is busy.
This is litle problematic situation, from unknown reason is not possible unmount. is good idea looks if mountpoint not hangs. Try to repair:
umount -f `pwd`/mntdir
and then manually close loopdevice:
* list all hanged devices `losetup | grep $(pwd)` 
* destroy them `losetup -D /dev/loop666`

im trust, somewhere in Unicornland somewho starts write autofix for this :)
## File diskety/xdisk_20230404150732.img is zero-size. sorry bro
internal check, zero-sized files are not processed
## cp: error reading 'mntdir/ELEKTRIK.TIM': Input/output error
This is problem when floppy is somewhre damaged or some problem with losetup, you can try extract only one image
