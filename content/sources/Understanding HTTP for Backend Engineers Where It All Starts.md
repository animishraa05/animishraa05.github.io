---
title: "Understanding HTTP for Backend Engineers: Where It All Starts"
created: 2026-04-12
description: "Understanding HTTP for Backend Engineers: Where It All Starts This week, I decided to go back to fundamentals and truly understand HTTP from the ground up. As a backend engineer, I work with HTTP …"
tags:
  - "backend"
---
[Sitemap](https://medium.com/sitemap/sitemap.xml)

## [JavaGuides](https://medium.com/javaguides?source=post_page---publication_nav-9cf31c9fda1a-56c633b9bb0e---------------------------------------)

[![JavaGuides](https://miro.medium.com/v2/resize:fill:38:38/1*9h3m7W2RvZi5zkydCxCgpg.png)](https://medium.com/javaguides?source=post_page---post_publication_sidebar-9cf31c9fda1a-56c633b9bb0e---------------------------------------)

Guides on Java, Spring Boot, REST APIs, Full-Stack Web development, Microservices, Cloud, Databases, and tools with hands-on tutorials and best practices.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/0*GQ6obto2NLXd55f2)

This week, I decided to go back to fundamentals and truly understand HTTP from the ground up. As a backend engineer, I work with HTTP every single day, building REST APIs, handling requests, setting headers, and dealing with CORS errors. But I realized I had been treating HTTP as a black box, knowing just enough to get by. This week was about changing that. I wanted to understand not just how HTTP works, but why it was designed the way it was, what problems it solves, and how each piece fits together.

What follows is my journey through HTTP’s core concepts, from statelessness to status codes, explained from first principles with the step-by-step reasoning I used to truly internalize these ideas.

## Why HTTP Exists

Before diving into how HTTP works, I needed to understand why it exists at all. At its core, HTTP (Hypertext Transfer Protocol) is the primary medium through which browsers communicate with servers to send or receive data. But that raises a question: why do we need a protocol for this communication?

The answer lies in the need for a standard language. Imagine if every server and every client had their own way of requesting and sending data. The internet would be chaos.

> **HTTP provides a standardized way for any client (a browser, a mobile app, Postman, or even a command-line tool) to communicate with any server, regardless of what technology stack either side uses.**

This standardization is built on two fundamental ideas that shape everything else about HTTP: ***statelessness*** and the ***client-server model***.

## The Foundation: Statelessness

Statelessness is perhaps the most important concept to understand about HTTP. HTTP has no memory of past interactions. Each request carries all necessary information, like headers, URLs, and HTTP methods, for the server to process it. After the server responds, it forgets about the request entirely. The next request is treated as a completely new, unrelated event.

Let me illustrate this with a concrete example:

When you access a user profile on a website, the request must include authentication credentials every single time. The server doesn’t remember that you authenticated five seconds ago. Each request stands alone.

```c
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(
        @PathVariable Long id,
        @RequestHeader("Authorization") String authToken) {
        
        // Every request must include the authorization token
        // Server has no memory of previous requests
        if (!authService.isValidToken(authToken)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        
        User user = userService.findById(id);
        return ResponseEntity.ok(user);
    }
}
```

This might seem inefficient at first, but statelessness brings three critical benefits.

1. ***Simplicity***. Server architecture becomes dramatically simpler because no session information needs to be stored. This reduces both complexity and resource usage. The server doesn’t need to maintain a state store, clean up expired sessions, or synchronize session data across instances.
2. ***Scalability.*** It becomes trivially easy to distribute requests across multiple servers. Since no single server tracks a session, any server can handle any request. This is essential for modern load-balanced architectures.
3. ***Resilience***. If a server crashes, it doesn’t affect the client’s interaction state because there’s no session to restore. The client can simply retry the request against another server.

> Now, you might be thinking: but websites do remember me when I log in.  
> How does that work if HTTP is stateless?

The answer is that we implement state management on top of stateless HTTP using techniques like cookies, sessions, or tokens. These mechanisms add state while HTTP itself remains stateless. The state lives in the token or cookie that the client sends with each request, not in the HTTP protocol itself.

## The Client-Server Model

The second foundational concept is the client-server model. This defines the roles and responsibilities in HTTP communication.

**The client is typically a web browser or application that initiates communication by sending a request to the server.** The client is responsible for providing all necessary information like the URL, headers, and any data in the request body.

**The server hosts resources like websites, APIs, or content, and waits for incoming requests.** When a request arrives, it processes the request and sends back an appropriate response, which could be a web page, JSON data, an error message, or a text file.

The critical rule here is that **communication is always initiated by the client** to get a response from the server. The server cannot spontaneously send data to the client without first receiving a request. This asymmetry is fundamental to how HTTP works.

## HTTP and TCP: The Transport Layer

To send requests and receive responses, clients and servers need a connection. ***HTTP uses TCP (Transmission Control Protocol)*** as its underlying transport protocol because HTTP requires the transport to be reliable and not lose messages. *TCP provides this reliability, making it more suitable than UDP for HTTP’s needs.*

As a backend engineer, we typically work at the Application Layer (Layer 7) of the OSI model, where HTTP lives. TCP operates at the Transport Layer (Layer 4) below it. Understanding this layering helps clarify that HTTP is concerned with the structure and meaning of messages, while TCP handles the actual reliable delivery of those messages across the network.

## The Evolution of HTTP

HTTP hasn’t stayed static since its creation. Different versions have refined how clients and servers communicate.

**HTTP 1.0** was the early version where each request opened a new connection, leading to significant inefficiencies. Every request meant a new TCP handshake, which added latency.

**HTTP 1.1** introduced persistent connections, allowing multiple requests and responses over the same TCP connection. This single change dramatically improved performance. HTTP 1.1 also added chunk transfer encoding and better caching mechanisms.

**HTTP 2.0** brought multiplexing, enabling multiple requests and responses over a single connection simultaneously. It switched from text-based to binary framing, which is more efficient to parse. It also introduced header compression using HPACK and server push, where servers can send resources before the client explicitly requests them.

**HTTP 3.0** represents a fundamental shift, built on the QUIC protocol, which runs over UDP instead of TCP. This might seem counterintuitive given that UDP is less reliable than TCP, but QUIC reimplements reliability at a higher level while providing faster connection establishment, reduced latency, and better packet loss handling. HTTP 3.0 continues the multiplexing benefits without the head-of-line blocking that could occur in HTTP 2.0 over TCP.

## HTTP Messages: Structure and Components

HTTP communication involves two types of messages:

1. ***request messages sent by the client and;***
2. ***response messages sent by the server.***

A request message has several components. It starts with the request method (like GET), followed by the resource URL, the HTTP version (like HTTP 1.1), and the host (domain). Then come headers, which are key-value pairs of parameters. A blank line separates the headers from the request body, which contains information the client wants to send.

```c
@RestController
@RequestMapping("/api/notes")
public class NoteController {
    
    @PostMapping
    public ResponseEntity<Note> createNote(
        @RequestBody NoteRequest request,
        @RequestHeader("Content-Type") String contentType,
        @RequestHeader("Authorization") String authToken) {
        
        // Request structure:
        // Method: POST
        // URL: /api/notes
        // Headers: Content-Type, Authorization
        // Body: NoteRequest JSON
        
        Note note = noteService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(note);
    }
}
```

A response message includes the HTTP version, a status code (like 200) and its textual value (like OK), response headers, a blank line, and finally the response body containing the actual data.

## Understanding HTTP Headers

Headers are key-value pairs of parameters that provide metadata about the request or response. To understand why headers exist, think of them like the address written on top of a parcel. They allow intermediaries like routers or proxies to process information quickly without needing to inspect the body of the message.

Headers fall into several categories, each serving a distinct purpose.

## Request Headers

Request headers are sent by the client to provide information about the request, the client environment, preferences, and capabilities. For example, the User-Agent header identifies whether the client is a browser, Postman, or a mobile app. The Authorization header sends credentials like a bearer token to authenticate the user. The Accept header specifies what content types the client expects, such as JSON, text, or HTML.

```c
@GetMapping("/profile")
public ResponseEntity<UserProfile> getProfile(
    @RequestHeader("Authorization") String authToken,
    @RequestHeader("Accept") String acceptType,
    @RequestHeader("User-Agent") String userAgent) {
    
    // Request headers provide context about the client
    UserProfile profile = userService.getProfile(authToken);
    
    // Server can use Accept header to format response appropriately
    if (acceptType.contains("application/json")) {
        return ResponseEntity.ok(profile);
    }
    
    return ResponseEntity.ok(profile);
}
```

## General Headers

General headers can be used in both requests and responses, providing metadata about the message itself. The Date header provides a timestamp. Cache-Control specifies caching mechanisms like no-cache or max-age. Connection indicates whether to keep the connection alive or close it after the response.

## Representation Headers

Representation headers deal with the representation of the resource being transmitted, whether in a request or response body. ***Content-Type*** describes the media type like JSON or HTML. Content-Length specifies the size of the resource in bytes. Content-Encoding indicates compression algorithms like ***GZIP or deflate***. ETag provides a unique identifier primarily used for caching.

## Security Headers

Security headers enhance request and response security by controlling content loading, cookies, and encryption. ***Strict-Transport-Security (HSTS)*** ensures communication only happens over HTTPS. ***Content-Security-Policy (CSP)*** restricts content sources to prevent XSS attacks. ***X-Frame-Options*** prevents embedding in iframes to mitigate clickjacking. ***X-Content-Type-Options*** prevents MIME type sniffing. ***Set-Cookie*** with *HttpOnly* or *Secure* flags secures cookies by making them inaccessible via JavaScript and ensuring HTTPS transmission.

## Extensibility Through Headers

One powerful aspect of headers is their extensibility. Headers can be easily added or customized without altering the underlying HTTP protocol, making HTTP adaptable to new technologies and use cases. Security enhancements like Strict-Transport-Security were added through headers. Custom headers like ***X-Custom-Header*** can be created for specific application needs. Content negotiation through ***Accept*** and ***Accept-Language*** headers allows clients and servers to agree on formats without changing HTTP itself.

## Remote Control via Headers

Headers allow the client to send instructions or preferences to the server, influencing how the server responds or processes requests. Content type negotiation lets the client request a specific format via the Accept header. Caching and expiration control enable the server to use ***Cache-Control*** or ***Expires*** headers. Authentication happens through the ***Authorization*** header, giving the client control over access.

## HTTP Methods: Defining Intent

HTTP methods represent different actions a client can request on a server, defining the intent of the interaction.

1. ***GET*** fetches data from the server and should not modify server data.
2. ***POST*** creates data on the server and usually includes a request body.
3. ***PATCH*** partially updates data with selective replacement.
4. ***PUT*** completely replaces an existing resource with the data in the request body.
5. ***DELETE*** removes a resource from the server.
```c
@RestController
@RequestMapping("/api/notes")
public class NoteController {
    
    // GET - Fetch data, no modification
    @GetMapping("/{id}")
    public ResponseEntity<Note> getNote(@PathVariable Long id) {
        Note note = noteService.findById(id);
        return ResponseEntity.ok(note);
    }
    
    // POST - Create new resource
    @PostMapping
    public ResponseEntity<Note> createNote(@RequestBody NoteRequest request) {
        Note note = noteService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(note);
    }
    
    // PATCH - Partial update
    @PatchMapping("/{id}")
    public ResponseEntity<Note> updateNote(
        @PathVariable Long id, 
        @RequestBody Map<String, Object> updates) {
        Note note = noteService.partialUpdate(id, updates);
        return ResponseEntity.ok(note);
    }
    
    // PUT - Complete replacement
    @PutMapping("/{id}")
    public ResponseEntity<Note> replaceNote(
        @PathVariable Long id,
        @RequestBody NoteRequest request) {
        Note note = noteService.replace(id, request);
        return ResponseEntity.ok(note);
    }
    
    // DELETE - Remove resource
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteNote(@PathVariable Long id) {
        noteService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
```

> A useful rule of thumb: **use PATCH unless you have a specific use case for PUT**. Most updates are partial, not complete replacements.

## Idempotent vs Non-idempotent Methods

An important distinction exists between idempotent and non-idempotent methods.

**Idempotent methods** **can be called multiple times with the expectation of the same result.**

1. GET is idempotent because fetching data multiple times yields the same data.
2. PUT is idempotent because completely replacing data multiple times results in the same final state.
3. DELETE is idempotent because deleting a resource once results in it being deleted, and subsequent delete attempts have no further effect on the resource’s existence.
4. HEAD, OPTIONS, and TRACE are also idempotent.

**Non-idempotent methods** **produce different results when called multiple times with the same request.**

1. POST is non-idempotent because submitting a POST request to create a new note twice will typically create two separate notes, producing different results.
2. PATCH and CONNECT are also non-idempotent.

## CORS and the OPTIONS Method

Understanding ***CORS (Cross-Origin Resource Sharing)*** requires first understanding the **Same-Origin Policy**. This security mechanism is enforced by browsers to control how web applications interact with resources hosted on different domains. By default, browsers restrict requests to a domain different from the one serving the webpage.

## Get Aadarsh Pandey’s stories in your inbox

Join Medium for free to get updates from this writer.

CORS allows servers to specify who can access their resources and how. The OPTIONS method plays a crucial role here, used to fetch the capabilities of a server for a cross-origin request. Developers usually don’t use OPTIONS directly, but it appears in browser network tabs as part of pre-flight requests.

## Simple Request Flow

A simple request occurs when certain conditions are met: the method is GET, POST, or HEAD, and the request doesn’t include certain forbidden headers or ***Content-Type*** headers other than ***application/x-www-form-urlencoded***, ***multipart/form-data***, or ***text/plain***.

The flow works like this.

1. The client sends a request, and the browser automatically adds an Origin header.
2. The server receives the request and checks the Origin header against its CORS policy.
3. If allowed, the server includes an ***Access-Control-Allow-Origin*** header in the response along with the resource. The value can be the client’s exact origin or an asterisk for allowing all origins.
4. The browser parses the response and checks for the ***Access-Control-Allow-Origin*** header.
5. If present and valid, it allows the response to reach the client.
6. If the server doesn’t include this header or disallows the origin, the browser blocks the response, resulting in a CORS error in the console.
```c
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("http://localhost:5173")
            .allowedMethods("GET", "POST", "PUT", "DELETE")
            .allowedHeaders("*")
            .allowCredentials(true);
    }
}
```

## Pre-flighted Request Flow

The browser triggers a pre-flight request when any of these conditions are met: the method is not GET, POST, or HEAD (like PUT, DELETE, or PATCH), the request includes headers other than simple headers (like **Authorization or Content-Type: application/json**), or the **Content-Type** is not one of the three simple types.

The pre-flight process involves several steps.

1. **First, the client initiates a request.**
2. The browser, detecting conditions for pre-flight, sends an **OPTIONS** request first. This **OPTIONS** request includes the Origin header with the client’s domain, an **Access-Control-Request-Method** header asking if the intended method is supported, and an **Access-Control-Request-**
3. **Headers** header asking if specific non-simple headers are supported.
4. The server receives the OPTIONS request. If it handles CORS properly, it responds with a **204 No Content** status code and specific CORS headers.
5. These include:  
	***a. Access-Control-Allow-Origin:*** specifying allowed origins;  
	***b. Access-Control-Allow-Methods:*** listing allowed methods for the resource;  
	***c. Access-Control-Allow-Headers:*** listing allowed non-simple headers, and;  
	***d. Access-Control-Max-Age:*** telling the browser how long to cache the pre-flight response so it doesn’t need to send another OPTIONS request for subsequent requests to the same resource.
6. The browser receives the **OPTIONS** response.
7. If all checks pass, it then sends the original request.
8. The server processes this request and sends the final response.
```c
@RestController
@RequestMapping("/api/notes")
public class NoteController {
    
    // This PUT request will trigger a pre-flight OPTIONS request
    // because PUT is not a simple method
    @PutMapping("/{id}")
    public ResponseEntity<Note> updateNote(
        @PathVariable Long id,
        @RequestBody NoteRequest request,
        @RequestHeader("Authorization") String authToken) {
        
        // Browser first sends OPTIONS to check:
        // - Is PUT allowed? (Access-Control-Allow-Methods)
        // - Is Authorization header allowed? (Access-Control-Allow-Headers)
        // - Is application/json content type allowed?
        
        Note note = noteService.update(id, request);
        return ResponseEntity.ok(note);
    }
}
```

## HTTP Response Status Codes

> ***Response status codes are three-digit numbers*** *that standardize how servers communicate the result of a request.*

They quickly inform the client whether the request was successful, resulted in an error, or requires further action. They also help clients handle specific errors programmatically and ensure consistency across web services regardless of platform or language.

## 1xx: Informational

These codes indicate the server received headers and the client can proceed.

1. **Code 100** *Continue:* is used in large uploads, telling the client the server is ready for the rest of the body.
2. **Code 101** *Switching Protocols:* indicates the server is switching protocols as requested, like from HTTP to WebSocket.

## 2xx: Success

These indicate the request was successful.

1. **Code 200** *OK:* is the most common, meaning the request succeeded and the server is returning the requested resource or has performed the action.
2. **Code 201** *Created:* means the request was fulfilled and a new resource was created, typically used after POST requests.
3. **Code 204** *No Content:* indicates the request was successful but there’s no content to return, often seen with OPTIONS requests or sometimes DELETE requests.
```c
@PostMapping
public ResponseEntity<Note> createNote(@RequestBody NoteRequest request) {
    Note note = noteService.create(request);
    // 201 Created indicates successful resource creation
    return ResponseEntity.status(HttpStatus.CREATED).body(note);
}

@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteNote(@PathVariable Long id) {
    noteService.delete(id);
    // 204 No Content indicates successful deletion with no response body
    return ResponseEntity.noContent().build();
}
```

## 3xx: Redirection

These codes indicate further action is needed.

1. **Code 301** *Moved Permanently:* means the resource has permanently moved to a new URL and future requests should use the new URL.
2. **Code 302** *Found:* is a temporary redirect, where the resource is temporarily at a different URL but the client should use the original URL for future requests.
3. **Code 304** *Not Modified:* tells the client the resource hasn’t changed since the last request, so the client should use its cached version. This is used with conditional GET requests for efficient caching.

## 4xx: Client Errors

These errors are triggered by client behavior.

1. **Code 400** *Bad Request:* means the client sent invalid or illogical data, like expecting a number but receiving a string.
2. **Code 401** *Unauthorized:* indicates the request requires authentication but the client failed to provide valid credentials or isn’t authenticated, such as an expired JWT or missing token.
3. **Code 403** *Forbidden:* means the server understood the request but refuses authorization, even if the user is authenticated, like trying to access a resource without proper permissions.
4. **Code 404** *Not Found:* indicates the client requested an unavailable resource due to an incorrect URL or deleted resource.
5. **Code 405** *Method Not Allowed:* means an invalid HTTP method was used for a resource.
6. **Code 409** *Conflict* occurs: when there’s a conflict in the request, like trying to create a folder with an existing name.
7. **Code 429** *Too Many Requests:* indicates the client sent too many requests in a given time interval, used for rate limiting.
```c
@GetMapping("/{id}")
public ResponseEntity<Note> getNote(@PathVariable Long id) {
    Optional<Note> note = noteService.findById(id);
    
    if (note.isEmpty()) {
        // 404 Not Found when resource doesn't exist
        return ResponseEntity.notFound().build();
    }
    
    return ResponseEntity.ok(note.get());
}

@PostMapping
public ResponseEntity<Note> createNote(
    @RequestBody NoteRequest request,
    @RequestHeader("Authorization") String authToken) {
    
    if (!authService.isValid(authToken)) {
        // 401 Unauthorized when authentication fails
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
    
    if (!authService.hasPermission(authToken, "CREATE_NOTE")) {
        // 403 Forbidden when user lacks permissions
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }
    
    Note note = noteService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(note);
}
```

Understanding the distinction between **401** and **403** is crucial.

> Use 401 when the user isn’t authenticated at all.  
> Use 403 when the user is authenticated but doesn’t have permission for the specific action.

## Beyond the Basics

Several other HTTP concepts are worth mentioning briefly, as they build on the foundational ideas.

HTTP caching is a mechanism to store copies of resources and serve them from cache if conditions are met, reducing server load and improving performance.

HTTP content negotiation allows the client and server to agree on the most appropriate representation of a resource when multiple options are available, like different languages, encodings, or media types.

HTTP compression reduces the size of data transferred between server and client using algorithms like GZIP to improve loading times.

Persistent connections and keep-alive allow a single TCP connection to remain open for multiple HTTP requests and responses rather than establishing a new connection each time, reducing overhead.

Multipart data is used to send multiple types of data in a single HTTP message, like file uploads with form data. Chunked transfer encoding allows a server to send data in a series of chunks, especially useful when the total size of the response isn’t known beforehand.

## HTTPS: Security Through Encryption

**HTTPS** is essentially HTTP with added security features. It incorporates encryption and security certificates using ***SSL (Secure Sockets Layer) and its successor TLS (Transport Layer Security) to secure the communication*** channel.

While these topics border on network engineering, understanding that HTTPS is just HTTP running over a secure, encrypted connection helps clarify why we see both protocols and when to use each.

## Reflection: From Black Box to First Principles

This week transformed how I think about HTTP. Before, I saw it as a mysterious mechanism that sometimes worked and sometimes threw CORS errors I didn’t understand. Now, I see HTTP as a beautifully designed protocol built on clear principles.

Statelessness isn’t a limitation but a design choice that enables the massive scale of the modern web. Headers aren’t arbitrary metadata but a flexible extension mechanism that lets HTTP evolve without breaking. Status codes aren’t random numbers but a carefully designed taxonomy for communicating outcomes. CORS isn’t an annoyance but a critical security mechanism protecting users from malicious cross-origin requests.

Understanding these concepts from first principles has already changed how I write backend code. I think more carefully about which status codes to return, how to structure my CORS policies, whether operations should be idempotent, and what information to include in headers versus request bodies.

The most valuable realization was that HTTP’s simplicity is deceptive. Its power comes not from complexity but from a small set of well-designed, composable concepts that work together elegantly. Every feature exists for a reason, solving a real problem in client-server communication.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/0*N0vCa101ZwLW_NPm)

## Let’s Keep Learning Together

Next week, I’ll be diving into another fundamental topic in my backend engineering journey, and I’ll share those insights in the next article. If you found value in this deep dive into HTTP, I’d love for you to follow me for more weekly learning articles. Each Monday, I share what I learned the previous week, always explained from first principles with the goal of true understanding.

> If this article helped clarify **HTTP** for you, ***please give it a clap and share it with other engineers who might benefit***. If you’re reading this on **Substack**, a restack would mean a lot. Your support helps me dedicate more time to learning deeply and writing articles that benefit all of us in this community. The more engagement these articles get, the more I can justify spending time on this type of in-depth technical writing that helps everyone level up together.

[![JavaGuides](https://miro.medium.com/v2/resize:fill:48:48/1*9h3m7W2RvZi5zkydCxCgpg.png)](https://medium.com/javaguides?source=post_page---post_publication_info--56c633b9bb0e---------------------------------------)

[![JavaGuides](https://miro.medium.com/v2/resize:fill:64:64/1*9h3m7W2RvZi5zkydCxCgpg.png)](https://medium.com/javaguides?source=post_page---post_publication_info--56c633b9bb0e---------------------------------------)

[Last published Feb 18, 2026](https://medium.com/javaguides/why-90-of-spring-boot-apps-fail-in-production-and-how-to-fix-it-3f596778e4a2?source=post_page---post_publication_info--56c633b9bb0e---------------------------------------)

Guides on Java, Spring Boot, REST APIs, Full-Stack Web development, Microservices, Cloud, Databases, and tools with hands-on tutorials and best practices.

[![Aadarsh Pandey](https://miro.medium.com/v2/resize:fill:48:48/1*YpDnjf5W1DImDgs1qLBLAw.jpeg)](https://medium.com/@beingadish?source=post_page---post_author_info--56c633b9bb0e---------------------------------------)

[![Aadarsh Pandey](https://miro.medium.com/v2/resize:fill:64:64/1*YpDnjf5W1DImDgs1qLBLAw.jpeg)](https://medium.com/@beingadish?source=post_page---post_author_info--56c633b9bb0e---------------------------------------)

[25 following](https://medium.com/@beingadish/following?source=post_page---post_author_info--56c633b9bb0e---------------------------------------)

A software engineer who loves solving problems, building applications, keen interest in system design. Thinking, exploring the tech world in my own way.