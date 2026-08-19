Essential services run in kernel space and remaining process which are not as important are out of this space.

stuff that is in the kernel
- process mgmt
- interrupt handling
- interprocess communication
- memory management

How does communication occur in microkernel

*THEY USE INTERPROCESS COMMUNICATION*

1. one of the reasons it is slower is due to this that here communication requires message passing instead of direct function calls.

##### Advantages and Disadvantages

ADV-
1. More secure as services are not given full privilege
2. Better stability
3. Easier maintenance as the kernel is smaller and has less components.
4. better modularity
DISADV-
	1. Slower performance due to IPC overhead.
	2. the communication between services is very complex.
	3. frequent switching between user and kernel mode (Switches increase the cost).

**Examples are - MACH, MINIX3, and other embedded and safety system use this only.