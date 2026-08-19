## How to write Nginx config file

- Nginx has one master process and several worker processes. The main purpose of the master process is to read and evaluate configuration, and maintain worker processes. Worker processes do actual processing of requests.
- The number of worker processes is defined in the configuration file and may be fixed for a given configuration or automatically adjusted to the number of available CPU cores.
- The nginx.conf file can be found in /etc/nginx or usr/local/nginx/conf or /usr/local/etc/nginx.

## Config file structure

- Nginx consists of modules which are controlled by directives specified in the configuration file.

> [!NOTE] 
> Modules provide the actual features and backend functionality, while directives are the configuration instructions you write in your configuration file to control how those modules behave.

- Directives are divided into simple directives and block directives. A simple directive consists of the name and parameters separated by spaces and ends with a semicolon.
- A block directive has the same structure as a simple directive, but instead of the semicolon it ends with a set of additional instructions surrounded by curly braces.
- If a block directive can have other directives inside braces, it is called a context.
- Directives placed in the configuration file outside of any contexts are considered to be in the main context.

### Serving static content
- An important web server task is serving out files.
- Depending on the request, files will be served from different local directories.
```
http {
    server {
    }
}
```
                          Default config

```
location /www/ {
  root /data
}
```

- This location block specifies the “/www” prefix compared with the URI from the request. For matching requests, the URI will be added to the path specified in the root directive, that is, to /data, to form the path to the requested file on the local file system. If there are several matching location blocks nginx selects the one with the longest prefix. The location block above provides the shortest prefix, of length one, and so only if all other location blocks fail to provide a match, this block will be used.

```
http{
    server{
        location /html/ { ;
        root /usr/share/nginx/;
        index index.html;
    }
}
```
- This is already a working configuration of a server that listens on the standard port 80 and is accessible on the local machine at http://localhost/
- Do not forget to do `sudo systemctl daemon-reload` after changing the config.


# Nginx Reverse Proxy for an Application Running on localhost:8000


> [!NOTE] 
> -> Proxy - Machine or a set of machines which sit between two systems(user and a backend system or two backend systems, anything).
> Proxies are used to abstract the complexities or un-trusted environment.
> -> Forward Proxy - Abstracts out the client by acting as a middleware, protects the identity of the client. Whenever the client makes a call the call goes via this proxy to the internet or to some service or machine. The service will only know the IP address of the proxy not of the client. It can be used to restrict the access of websites, at forward proxy caching can be performed as everything is going through it. 
> -> Reverse Proxy - The reverse proxy abstracts outs the complexities of the down stream systems. Example "load balancer", Router (an api gaateway), caching, Abstraction of the infra
 -> Firewall - A firewall is a network security device that separates a trusted internal network from an external network deemed untrustworthy, such as the internet. It regulates incoming and outgoing network traffic based on preset security rules. Firewalls are paramount in shielding networks from unauthorized access, harmful activities, and potential threats, and can exist as hardware, software, software-as-a-service (SaaS), or public or private (virtual) cloud. 



## Objective

Expose an application running on `localhost:8000` through Nginx, allowing clients to access it via port `80`.

---

## Architecture

```text
Client
   │
   ▼
Nginx (Port 80)
   │
   ▼
Application (localhost:8000)
```

Nginx acts as a **reverse proxy**:

- Receives requests from clients.
    
- Forwards requests to the backend application.
    
- Returns the backend's response to the client.
    

---

## Nginx Configuration

```nginx
events {}

http {
    server {
        listen 80;
        server_name _;

        location / {
            proxy_pass http://127.0.0.1:8000;

            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

---

## Explanation

### 1. Listen on Port 80

```nginx
listen 80;
```

Tells Nginx to accept incoming HTTP requests on port 80.

---

### 2. Forward Requests to Backend

```nginx
proxy_pass http://127.0.0.1:8000;
```

Forwards all requests received by Nginx to the application running on port 8000.

Example:

```text
http://server-ip/
        │
        ▼
http://127.0.0.1:8000/
```

---

### 3. Preserve Original Request Information

#### Host Header

```nginx
proxy_set_header Host $host;
```

Passes the original hostname requested by the client.

Example:

```text
Host: example.com
```

---

#### Real Client IP

```nginx
proxy_set_header X-Real-IP $remote_addr;
```

Provides the backend with the actual client IP address.

---

#### Forwarded Client Chain

```nginx
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

Maintains a list of proxy hops for logging and auditing.

---

#### Original Protocol

```nginx
proxy_set_header X-Forwarded-Proto $scheme;
```

Indicates whether the client used:

```text
http
```

or

```text
https
```

---

## Validate Configuration

Before reloading Nginx, verify the configuration syntax:

```bash
sudo nginx -t
```

Expected output:

```text
nginx: configuration file syntax is ok
nginx: configuration file test is successful
```

---

## Reload Nginx

Apply configuration changes:

```bash
sudo systemctl restart nginx
```

or

```bash
sudo nginx -s reload
```

---

## Verify Backend Service

Check whether the application is listening on port 8000:

```bash
ss -tulnp | grep 8000
```

Example output:

```text
LISTEN 0 128 127.0.0.1:8000
```

---

## Test the Reverse Proxy

Open:

```text
http://localhost
```

or

```text
http://<server-ip>
```

If configured correctly:

```text
Client → Nginx → Application → Nginx → Client
```

---

## Troubleshooting

### Check Nginx Error Logs

```bash
sudo tail -f /var/log/nginx/error.log
```

Useful for:

- Backend connection failures
    
- Invalid configurations
    
- Permission issues
    

---

### Check Access Logs

```bash
sudo tail -f /var/log/nginx/access.log
```

Useful for:

- Verifying incoming requests
    
- Monitoring traffic
    
- Debugging routing issues
    

---

## Key Concept

A reverse proxy hides the backend service from clients.

Clients interact with:

```text
Nginx (Port 80)
```

while Nginx internally communicates with:

```text
localhost:8000
```

This provides:

- Centralized request handling
    
- SSL/TLS termination
    
- Load balancing capabilities
    
- Security and access control
    
- Logging and monitoring
    
- Backend abstraction
    

The core directive that makes Nginx a reverse proxy is:

```nginx
proxy_pass http://127.0.0.1:8000;
```

Everything else supports correct request forwarding and backend awareness.

