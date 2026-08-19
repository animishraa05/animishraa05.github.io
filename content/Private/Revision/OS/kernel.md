
*kernel* - Is a component of operating system
- That manages the system operations
- Acts as an interface between hardware and software.
- controls CPU, memory, devices and System operations.


WHY DO WE NEED IT
- imagine having multiple tabs, firefox, spotify, minecraft and 20 more.
- All these programs want CPU access, ram access, Internet, GPU and other accesses too.

SO computer has to have some manager to allocate resources properly to these programs. We use **kernel** for that.
it'll decide who gets how much cpu time, and memory allocation


#### How do programs Interact with kernel

*Application cannot directly access hardware. Instead they use something called[[ SYSTEM CALLS*]]

-- APPLICATION --> SYSTEM CALL --> KERNEL -->HARDWARE