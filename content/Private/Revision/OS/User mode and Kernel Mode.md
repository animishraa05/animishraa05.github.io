 *user mode is the execution mode in which user application run with limited privileges ( Cannot really access the hardware and critical system resources.)*
 *Kernel mode is privileged mode in which all the operating system kernel runs without any limitations of access to hardware or critical system resources.*
# First Understand the Problem: Why Do We Need Different Modes?

Let us think from first principles.

Suppose there were **no restrictions** in a computer.

Imagine every application had complete access to:

- RAM
- CPU instructions
- Disk
- Keyboard
- Camera
- System files

Now suppose you install a random calculator app.

That calculator app could:

- delete Windows/Linux system files
- read passwords from memory
- access browser cookies
- shut down the system
- corrupt RAM

Computer would become extremely unsafe.

So operating systems introduce a very important idea:

> **Not every program should have equal power.**

This is one of the biggest principles in OS design:

> **Controlled Privilege**

Meaning:

Different programs get different levels of authority.

This is where:

### User Mode

and

### Kernel Mode

come into existence.