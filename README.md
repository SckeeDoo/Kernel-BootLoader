# Laboratoy Work 2 at Operation Systems

###This is a short tutotial for creating very first Kernel bootloader.

##1. Getting some stuff installed.

First we need to install some tools:
- Flat Assembly. This one helps us to compile and run .asm files.
- Oracle Virtual Box. Using Virtual Box we can create on our computer a virtual machine that eventually will run our operation system.
- Also I used Windows 10 operation system.

So in this tutorial we will learn some theory about kernel and will  create our first Kernel program. When we talk about Kernel there is
a think called security Rings. This Rings are levels of protection in an operation system. There are basically 4 rings: 

1. First Ring also called supervisor mode has more previlegies, this where Kernel stands, so Kernele is allowed to do pretty everything it wants
2. Next two rings are more restricted in its action. This is where drivers are located
3. Ring three also known as User Mode. This is the most restricted level. If you want to do an action you first  must to have permision from Kernel.

This is made with a system call. this means that Kernel  still has ontrol other applications. Thats why Kernel are so important.

There are two general types of Kernel:
1. In computer science, a microkernel (also known as μ-kernel) is the near-minimum amount of software that can provide the mechanisms needed to implement an operating system (OS). These mechanisms include low-level address space management, thread management, and inter-process communication (IPC).

2. A Monolithic kernel is an OS architecture where the entire operating system (which includes the device drivers, file system, and the application IPC) is working in kernel space. Monolithic kernels are able to dynamically load (and unload) executable modules at runtime.

So lets finish with theory and write some code. We will continuie to work with files we did in previous laboratory work. So create a new folder in the directory you are working called Kernel. Its alway a good idea to be organizet from beggining or you will suffer later. Inside it lets create a new file called loader.asm this  will be the entry point for our Kernel in another words this is like the main function in a C program. So the code will look something like this

##2. Lets write some code in assembly.

~~~
bits 32   ;we will work in 32 bits mode

global loader
extern kmain    ;declare an external function

; Multiboot header
MODULEALIGN equ   1<<0
MEMINFO     equ   1<<1
FLAGS       equ   MODULEALIGN | MEMINFO
MAGIC       equ   0x1BADB002
CHECKSUM    equ   -(MAGIC + FLAGS)

MultibootHeader:
      dd MAGIC
      dd FLAGS
      dd CHECKSUM
      
STACKSIZE   equ 0x4000        ; 16 KB

loader:
      cmp eax, 0x2BADB002     ; verify booted with grub
      jne .bad
      
      mov esp, STACKSIZE + stack
      mov ax, 0x10
      mov ds, ax
      mov es, ax
      mov fs, ax
      mov gs, ax
      
      push ebx
      call kmain
      
.bad:
      cli
      hlt
      
align 4
stack:
      TIMES STACKSIZE db 0
    
~~~

3. Lets move deeper.

Next we will create a .c file . For now lets create a dummy main function which will have one parameter , a pointer to the multiboot information
~~~
void kmain (void* MultibootStructure)
{

}
~~~

##3.Create a script for ld linker.
Next we will create as script for ld linker, called linker.ld . this will tell the linker how to run all this files in a final executably
~~~
ENTRY (loader)
OUTPUT ("kernel.bin")

addr = 0x100000;

SECTIONS
{
      .text addr :
      ALIGN(0x1000)
      {
            *(.text*);
            *(.rodata*);
      }
      
      .data :
      ALIGN(0x1000)
      {
            *(.data*);
      }
      
      .bss :
      ALIGN(0x1000)
      {
            *(.bss*);
      }

}
~~~

###4. Sheel script

The last file we need to create is shell script this will make our life easier, because all the compiler will be done when we will run this script. Lets called the file build.sh
~~~
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
~~~
Also one importat thing is to create an empty build foled in our directory.

###5. Finish Him!!!!

Now we go in the cmd (or terminal for linux) and go to our directory and run the build.sh file like this
~~~
./build.sh
~~~

As in previous laboratory we have to load the kernel in virtual machine. It doesnt do anythin on the screen, we havent did it yet. but this is what you should see.

![imag](https://postimg.org/image/x9986h4n7/)



It's done! Run your virtual machine and see the `goodest` OS eveeeeeeer!


