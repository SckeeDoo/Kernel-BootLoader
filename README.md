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

So lets finish with theory and write some code.

##2. Lets write some code in assembly.

~~~
mov ax, 9ch
mov ss, ax
mov sp, 4096d
mov ax, 7c0h
mov ds, ax

mov  dx, msg
mov al, 37h
int 10h
jmp $

times 510-($-$$) db 0
dw 0xAA55
~~~

3. Lets move deeper.
After compile this code in the same directory where you saved you .asm file, automatically will be created a .bin file. One important thing is to convert this .bin file into Image so we can boot it to our machine. To do this write this command in cmd:
~~~
copy bootLoader.bin /b bootLoader.img
~~~
After this in the same directory will be created a image file.

##3. Creating Virtual Machine and boot the image.


![imag](http://i.imgur.com/wkTv1cy.png)
![imag](http://i.imgur.com/3tbFF1z.png)
![imag](http://i.imgur.com/EfKPiwr.png)


It's done! Run your virtual machine and see the `goodest` OS eveeeeeeer!


