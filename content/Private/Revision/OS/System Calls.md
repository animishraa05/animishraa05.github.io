*A system call is a service in operating system through which user program requests service from operating system kernel.*
OR
*System calls provide interface between process and operating system *

> process is just a program in execution.

#### why do System calls exist.

'''
python
file = open("data.txt", "r")
'''

what will happen is that *python* cant directly access the hardware itself, **why** - because normal procedure work in user mode and user programs do not have direct access to the hardware. SO it needs to switch to kernel mode first and then execute that following procedure.

1. its very important also because if applications could access the hardware then the apps would be able to write the passwords in RAM, normal malware could access hardware. 

this is why **Applications cant directly access the hardware. They need to request Service from kernel.** 
this request is known as SYSTEM CALL.

“System calls act as an interface between user processes and the operating system kernel, allowing programs to request services such as file handling, process management, device control, and communication.”


Basically the application programs are not allowed to access the kernel directly as they can produce complications, so they switch to the kernel mode and make system calls so that they access  the hardware 