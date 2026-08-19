<img src='Pasted image 20260608203909.png'>![[System Design_Pasted image 20260608203909.png]]<img>

# Introduction 

## What is System Design?
System design is the blue print of any software system, it is a the strategic process of defining the architecture, components, modules, interfaces, and data flow for a software system to satisfy specified business and technical requirements.


---

### 1. Scalability
Often you hear in a discussion “but that doesn’t scale” as the magical word to end an argument. This is often an indication that developers are running into situations where the architecture of their system limits their ability to grow their service.
*What is it that we really mean by scalability?*
- **A service is said to be scalable if when we increase the resources in a system, it results in increased performance in a manner proportional to resources added. Increasing performance in general means serving more units of work, but it can also be to handle larger units of work, such as when datasets grow.**
- When it comes to distributes systems adding resources can have many more reasons like to improve the reliability of the offered service and many more.

-> BUT WHY IS SCALABILITY HARD !?
   Because....
- It requires applications and platforms to be designed with scaling in mind, such that adding resources actually results in improving the performance or that if redundancy is introduced the system performance is not adversely affected.
- Many algorithms that perform reasonably well under low load and small datasets can explode in cost if either requests rates increase, the dataset grows or the number of nodes in the distributed system increases.

#### 1.1 Types of Scaling

<img src='Pasted image 20260609015523.png'>![[System Design_Pasted image 20260609015523.png]]<img>
                   Horizontal and vertical scaling
                   
**Horizontal scaling** and **Vertical scaling** both involve adding resources to your computing infrastructure, you must decide which is right for your application. Scaling horizontally and scaling vertically are similar in that they both involve **adding computing resources** to your infrastructure. There are distinct differences between the two in terms of implementation and performance.

- **Horizontal** scaling means scaling by **adding more machines** to your pool of resources (also described as “**scaling out**”), whereas **Vertical** scaling refers to scaling by **adding more power** (e.g. CPU, RAM) to an existing machine (also described as “**scaling up**”)
- One of the fundamental differences between the two is that horizontal scaling requires **breaking** a **sequential piece** of logic into **smaller pieces** so that they can be executed in parallel across multiple machines.
- In many respects, vertical scaling is easier because the logic really doesn’t need to change. Rather, you’re **just running the same** code on higher-spec machines.
##### However, there are many other factors to consider when determining the appropriate approach. So lets explain one by one.

#### 1.1.1 Vertical Scaling
- Vertical Scaling basically makes one node stronger, if you have 1 server, make the server stronger with **adding more hardware**.
- **Vertical scaling** keeps your existing infrastructure but **adding more computing power.** Your existing code doesn’t need to change — you simply need to run the same code on machines with better specs. Vertical scaling means adding more resources to a single node and adding additional **CPU, RAM, and DISK** to cope with an increasing workload.
- It’s important to keep in mind that you can only increase it to the limits of your server. By scaling up, you increase the capacity of a single machine.
- Vertical scaling allows data to live on a **single node,** and scaling spreads the load through **CPU** and **RAM resources** for your machines. But the system has hardware limitations that you can increate CPU and RAM. Also this will highly expensive when you reach the maximum capacity.
- If you have get **millions of request**, in that case having one server **won’t be enough**, because even the hardware has maximum capacity limitations.

#### 1.1.2 Horizontal Scaling
- Horizontal scaling means **adding more machines** to the resource pool,  
rather than simply adding resources by scaling vertically. Vertical scaling gives you the ability to zoom into add **more servers to your network**, but it also requires you to zoom out by adding a bit more power, CPU, and RAM to the existing infrastructure.
- Scaling horizontally gives you scalability but also reliability because you will have more **redundancy** and mostly its the **preferred way** to scale in **distributed architectures**.
- If your services are **stateless**, then its easy and the best practice to **Scaling horizontally**.
- We can just put the different services and have a **load balancer** that will split the load traffic to different servers.


---

### 2. Caching
*Caching, in the world of computer systems, is a ==technique to store a copy of data or computational results that can be retrieved quickly==. The cache memory is like a tiny treasure box that keeps the most frequently accessed data ready for you.*

- Caching adds speed and reduces latency, and lightens the load on the Backend by providing the prep-rocessed data.

#### 2.1 Caching: Mechanisms, Tools, and Techniques
- Browser Caching - Browser caching stores webpage resources on a local computer when a user visits a webpage. On the next visit, the browser loads the page from local resources, reducing server load and improving page load speed.Browser caching is powerful but comes with limitations it’s only effective for repeat visits and is entirely client-dependent.
- CDN Caching (Content Delivery Network) - CDN caching replicates your data across various geographical locations, reducing the data travel time (latency) by serving it from the nearest server to the user. Big players like Cloudflare and AWS CloudFront provide CDN services. CDN caching shines when you have a global user base. The more distributed the users, the more beneficial a CDN becomes.
- Database Query Caching - Database query caching saves the result set of a query in the cache. When the same query is executed, the DBMS first checks the cache. If found, the results are returned from the cache, skipping the actual database hit.
- In-Memory Caching (e.g., Redis, Memcached) - In-memory caches store data in RAM, which is much faster than typical disk storage. They are often used for frequently read data, session information, and full-page caching.
- Application Caching - Custom build application cache.
- Distributed Caching - Application cache, but in microservice architecture.

#### 2.2 Cache Strategies: Types and When to Use What
A well implemented cache can improve the performance of a system but the only deal to make it work efficiently is to choose the correct caching strategy.
- Cache-Aside(Lazy Loading) - In the Cache-Aside strategy, the application looks for data in the cache first. If it doesn’t find the data (a cache miss), it loads data from the source, stores it in the cache, and then returns it. This strategy ensures that only requested data is cached, thus preventing the caching of unnecessary data.
  This strategy is best when reads are much more frequent than writes, and data doesn’t get updated often.
- Read-Through (Eager Loading) - In the Read-Through strategy, cache is completely abstracted from the application. When a cache miss occurs, the cache itself is responsible for reading data from the data source, storing it, and then returning it. This approach maintains data consistency and saves the application from interacting with the data source.
  This strategy works best when the cost of a cache miss is high and when you want to keep your application logic simple.
- Write-Through - In the Write-Through strategy, every write operation to the database is simultaneously written to the cache. This ensures the cache always holds the latest data, reducing the chance of serving stale data.
  This strategy is suitable when write operations are less frequent and you need up-to-date data in cache at all times.
- Write-Back (Write-Behind) - In the Write-Back strategy, write operations are first written to the cache, and the cache then writes the data back to the database after a certain delay. This strategy significantly reduces database load.
  This strategy is ideal when write performance is more critical than data consistency, and the risk of data loss is acceptable.
- Refresh-Ahead - In the Refresh-Ahead strategy, cache proactively refreshes data before it gets stale or expires. This strategy ensures that data is always ready in the cache, reducing cache miss latency.
  This strategy is great when you have predictable data access patterns and can afford the overhead of pre-fetching data.
  
  
#### Choosing the Right Caching Strategy

Now that we know the options, how do we choose the right caching strategy? Several factors come into play:

1. **Scale of the Application**: Larger applications with heavy traffic need more robust caching solutions like CDN or distributed caching.
2. **Type of Data**: Highly dynamic data might not be the best candidate for caching. On the other hand, data that is expensive to compute or doesn’t change often should be prioritized.
3. **User Distribution**: If your users are globally distributed, consider CDN caching. If most of your user base is local, in-memory caching may be more effective.
4. **Infrastructure**: Cloud-based applications can take advantage of the built-in caching mechanisms provided by cloud vendors.

---
### 3. Load Balancing

<img src='Pasted image 20260609121514.png'>![[System Design_Pasted image 20260609121514.png]] <img>

In the world of computers and the internet, when a website or online service becomes super popular, it starts receiving a flood of requests from users all over the place. Instead of relying on a single server to handle all these requests, load balancing spreads the workload across multiple servers.
- No single server gets overwhelmed with too much traffic.
- Every server gets to share the load.
- Prevents crashes, slowdowns, and annoying error messages, making sure that users have a smooth experience while browsing websites or using online applications.
- Load balancing algorithms decide which server should handle each request, making sure they’re divvied up fairly.

#### 3.1 Types of Load Balancers based on the OSI Model

<img src='Pasted image 20260609122543.png'>![[System Design_Pasted image 20260609122543.png]]<img>

- Network Load Balancer (Load Balancer 4): 
  - Operates at the Transport Layer (layer 4) of the OSI model.
  - It makes decisions based on information such as the source and destination IP addresses, as well as the port numbers of incoming requests.
  - The main focus of Layer 4 load balancers is to distribute network traffic efficiently across multiple servers.
  - When a user sends a request to access a website or application, the Layer 4 Load Balancer receives the request. It then looks at the transport layer data (IP addresses and ports) to determine which server should handle the request. The load balancer uses various algorithms (e.g., round-robin, least connections) to decide the best server to forward the request to. This ensures that traffic is evenly spread among the servers, improving performance and avoiding overloading any single server.
  - Cannot make application specific desicions

- Application Load Balancer (Load Balancer 7):
  - Operates at the application layer.
  - It can make more intelligent decisions based on application-specific data, such as HTTP headers, cookies, and URLs.
  - Load Balancers at this level understand application protocols, enabling them to optimize traffic distribution for specific applications or services.
  - When a user sends a request, the Layer 7 Load Balancer analyzes the content of the request to gain insights into the application being accessed. For example, it can identify the type of service (e.g., HTTP, HTTPS, FTP) or the specific URL being requested. Using this information, the load balancer can make intelligent decisions about which server is best suited to handle the request. This allows for more advanced load balancing strategies, such as sending certain requests to specialized servers that can handle specific application tasks.
  - Higher processing overhead compared to Layer 4 Load Balancer due to content analysis.

#### 3.2 Load Balancing Algorithms

3.2.1 Round Robin:
- Transport Layer algorithm.
- It maintains a pool of servers for handling incoming requests.
- When the request comes the load balancer starts with the first server and sends it the request and then continues sending the requests in the linear or the circular manner.
- In a long run each server receives the equal number of requests.
- Simple, no sessions required, no external dependency.
- No health monitoring, unequal server capability, no geo-location awareness.

3.2.2 Weighted Round Robin:
- Expansion of basic round robin algorithm.
- It fixes the issue of unequal server capacities by assigning different weights to each server in the pool, the weights represent the relative compute and performance capability of the servers.
- When a new request comes in, the load balancer uses the weights to determine which server should handle the request. It cycles through the servers in a circular manner, as in the basic Round Robin algorithm, but with a slight modification. Instead of equal distribution, it takes into account the weights of the servers.
- Fine tuned balance, capacity base distribution of requests.
- Complex, static config.

3.2.3 IP Hash
- Application layer algorithm.
- Distribute incoming network traffic across multiple servers based on the source IP address of the client.
- From the incoming request the load balancer extracts the ip address of the request.
- The IP address is then hashed, meaning it is converted into a unique numerical value using a hash function. The hash function ensures that the same IP address will always produce the same hash value.
- The load balancer uses the hashed value to map the client’s IP address to a specific server in the pool. This mapping is typically done by dividing the hash value by the total number of servers and selecting the corresponding server.

3.2.4 Least Connection Algorithm
- Based on number of active connection of a server.
- The load balancer continuously monitors the number of active connections of each server in the server pool.
- When a new request comes in, the load balancer evaluates the current connection count for each server and selects the server with the fewest active connections.

3.2.5 Least Response Time Algorithm
- Based on the response time of the server on the previous requests.
- The load balancer continuously measures the response times of each server in the pool to previous requests.
- When a new request comes in, the load balancer evaluates the response times of each server and selects the server with the shortest response time.

Time to First Byte (TTFB) is the time taken by a server to send the first byte of data in response to a client’s request. It includes the time spent on processing the request, database queries, and any other backend operations before the server starts sending the response data.
The Least Response Time load balancing algorithm implicitly takes into account the Time to First Byte as it evaluates the overall response time of each server. The response time includes the TTFB along with the time taken to transmit the complete response data.

---

### 3. Database Replication and Partitioning
#### 3.1 Database Replication
Before getting started you must know some keywords for better understanding.
- Latency - It is the total time a system takes to process a request and return a response.
- Availability - It is a measure of percentage of time a system is operational and accessible to users.
- Fault tolerance - It is a system's ability to continue operating properly without interruption when a hardware, software, or network component fails.
- Data Throughput - It is the total volume of data or number of operations a system can process, transfer, or handle successfully within a specific time unit.
- Data Consistency - Ensures that all nodes in a distributed system see the same data at the same time, preventing conflicts during concurrent access.
- Durability - Ensures that once data is committed, it remains intact, permanent, and recoverable, even during system crashes, power failures, or hardware outages.

***What is Database Replication?***
Database replication in simple language means to store data at one or more places or simply copying the data from one database or from one server to another.

BUT WHY DO WE NEED IT????
Let us take an example situation to understand the need in a better way.
I am running an E-comm company and my company is a huge success in India but now i am targeting multi national costumers, so if a person from Australia comes to visit my website he or she will be able to see the products after a large amount of time which is a problem as my servers are hosted in the Indian region.
Increasing the resources on my server is not the solution of this problem. The issue of because of network latency.So by replication, we can keep data close to the user’s geographic area to **reduce latency**. Similar things are done by **Netflix and Amazon prime video** etc that’s why you people can watch HD movies without any buffering delays.
- Replication also solves the problems like Availability & Fault toleration issues and Data throughput issues.
So as a CEO of an e-commerce startup, if my application goes down (Unavailable) then my whole business could get impacted and I could have lost thousands of bucks and can lose the trust of our customers which is very bad these days. Hence we need better Fault tolerance in our system.

#### 3.2 Algorithms to implement Database replication
- **Single Leader Replication**(Active-Passive or Master-Slave Replication)
  - 
- **Multi-Leader Replication**
- **Leaderless Replication**
