##### Ansible is an open source, command-line IT automation software application written in Python. It can configure systems, deploy software, and orchestrate advanced workflows to support application deployment, system updates, and more. Ansible provides open-source automation that reduces complexity and runs everywhere. Using Ansible lets you automate virtually any task. Here are some common use cases for Ansible:
- Eliminate repetition and simplify workflows
    
- Manage and maintain system configuration
    
- Continuously deploy complex software
    
- Perform zero-downtime rolling updates

### Control node
A system on which Ansible is installed. You run Ansible commands such as `ansible` or `ansible-inventory` on a control node.

### Inventory
A list of managed nodes that are logically organized. You create an inventory on the control node to describe host deployments to Ansible.

### Managed node
A remote system, or host, that Ansible controls.

---

#### Ansible uses playbooks to automate tasks, you describe the desired state of the system in the playbook and ansible makes sure that the system remains in that state.

-> As automation technology, Ansible is designed around the following principles:

### 1. Agent-less architecture
Low maintenance overhead by avoiding the installation of additional software across IT infrastructure.

### 2. Simplicity
Automation playbooks use straightforward YAML syntax for code that reads like documentation. Ansible is also decentralized, using SSH with existing OS credentials to access remote machines.

### 3. Scalability and flexibility
Easily and quickly scale the systems you automate through a modular design that supports a large range of operating systems, cloud platforms, and network devices.

### 4. Idempotence and predictability
When the system is in the state your playbook describes, Ansible does not change anything, even if the playbook runs multiple times.

