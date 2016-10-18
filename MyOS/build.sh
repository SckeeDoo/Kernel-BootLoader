#!/bin/sh

build=build

echo "Building..."
echo "==========="

# Build C files

gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -nostdinc -fno-builtin -I./kernel/include -c -o $build/main.o ./kernel/main.c -fno-strict-aliasing -fno-common -fno-stack-protector

# Build ASM files
nasm -f elf ./kernel/loader.asm -o $build/loader.o

# Link 
ld -T linker.ld $build/*.o

# Put on floppy image
cp Boot/myos.img myos.img
mkdir /media/floppy1
mount -o loop myos.img /media/floppy1
cp kernel.bin /media/floppy1/
umount /media/floppy1
rm -r /media/floppy1
