<img src'[[kubernetes-arch.png]]'>![[DevOps_kubernetes-arch.png]]<img>

*prerequisite - [[Docker]]
#### Kubernetes (often abbreviated as **K8s**) is an open-source platform that automates deploying, scaling, and managing containerized applications.
-> Kubernetes is a Cloud Native Computing Foundation (CNCF) graduates project which is responsible for orchestrating containers.

> [!Note]
> Monolithic architecture is a single, unified unit where all components are tightly coupled, making it easier to develop initially but harder to scale. Microservices break applications into independent, loosely coupled services, allowing for independent deployment and better scalability, but with higher complexity

---
### 1. Kubernetes Architecture

Master Node = Headquater       Worker Node = Branch(runs docker                                                             containers)
- etcd - Consistent and highly-available key value store for all API server data.
- Controller Manager - Runs controllers to implement Kubernetes API behavior. [Project Manager] Supervises that everything is working fine of not. Works at cluster level
- Api server - The core component server that exposes the Kubernetes HTTP API. (communication gateway between the components within the cluster) [Manager]
- kube-Scheduler - Looks for Pods not yet bound to a node, and assigns each Pod to a suitable node. [HR]
- Kubectl - Cli tool for kubernetes. [Director]
- Kubelet - Ensures that Pods are running, including their containers.(works at worker level) [Branch Manager].
- Kube-proxy/Service-proxy - Maintains network rules on nodes to implement Services. (helps user to access the pods).
- Container runtime - Software responsible for running containers. (Docker). 
- Container Network Interface (CNI Network): Provides network connectivity, ensuring that pods can communicate with each other across different nodes and that network policies are enforced. Eg- Wavenet, Calico, etc.

---
### 2. Kubernetes works in cluster

*Types of Kubernetes clusters*
- Kubeadm - Multiple systems are connnected in a cluster by installing kubeadm on them.
- Minikube (local or single ec2)
- Kind cluster - kubernetes in docker
- EKS/AKS/GKE

-> Kind cluster installation for linux
```
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```


> [!NOTE] 
> Before starting to write kubernetes configs, you must know how to write yml/yaml.

---
### 3. How to Write Yet Another Markup Language(yml/yaml)

```
# key value
key: value
name: xyz
-----------
#list
courses:
  - list1
  - list2
  - list3
-----------
#objects
info:
  name: xyz
  age: 46
  course: CSE
```


## Heading towards practical part...

### Creating a kind cluster
- We will be using yml/yaml file for creating a cluster.
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  image: kindest/node:v1.31.2
- role: worker
  image: kindest/node:v1.31.2
- role: worker
  image: kindest/node:v1.31.2
- role: worker
  image: kindest/node:v1.31.2
- role: worker
  image: kindest/node:v1.31.2
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
```


### - Kubernetes Namespaces

|Docker container->Pod->Deployment->service    |
--------------------------------------------------------------------
                 All this inside a namespace for isolation

A Kubernetes namespace is a mechanism for dividing and logically isolating a single physical Kubernetes cluster into multiple virtual sub-clusters.


```
mradul@mradul-HP-Laptop-15:~/Desktop/GIT/Fast-Translit-Deployment/Nginx$ kubectl get ns
NAME                 STATUS   AGE
default              Active   20m
kube-node-lease      Active   20m
kube-public          Active   20m
kube-system          Active   20m
local-path-storage   Active   20m
nginx                Active   4m49s
mradul@mradul-HP-Laptop-15:~/Desktop/GIT/Fast-Translit-Deployment/Nginx$ 

```

- default - When no namespace is created the resources are assigned the default namespace.
- kube-node-lease - Stores the information of kubernetes clusters.
- kube-public - Runs the services that are  publicly accessible resources.
- kube-system - Runs system level services.
- local-path-storage - For storage use.


### - Kubernetes Pods
_Pods_ are the smallest deployable units of computing that you can create and manage in Kubernetes.
A Pod is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers.
- A pod may container one or more application containers which are tightly coupled and run together.
- The shared context of a Pod is a set of Linux namespaces, cgroups, and potentially other facets of isolation - the same things that isolate a container.
- Pods can simply be understood by the set of containers running on same machine but still completely isolated.
- Pods can even run a single container and when needed pods can also run multiple containers which are needed to run together.

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80

```
                              pods.yml

- To apply the yml manifest files we use kubectl apply -f {filename}
Usually we do not create pods directly using the yml file, we instead create them using the workload resources like Deployments, job, ReplicaSet, DaemonSet and StatefulSet(when we need to track the state of the pod running).
- Each pod runs the single instance of the application, you must always run multiple pods for any appliation.
- The replication of pods is the responsibility of the workloads and the Controllers.

- Types of Multi-container pods
  -  **Sidecar Containers**: Enhance or extend the main application         container, such as a separate log exporter or metrics collector.
  -  **Init Containers**: Specialized containers that execute sequentially  and run to completion _before_ any app containers start. They        typically handle setup scripts, database migrations, or security   credentials.
  - **Ephemeral Containers**: Temporary troubleshooting containers that you run interactively inside an existing Pod to diagnose bugs. They cannot be added at Pod creation and lack resource guarantees.

### - Kubernetes workloads
1. Deployment: Makes the pod scalable.