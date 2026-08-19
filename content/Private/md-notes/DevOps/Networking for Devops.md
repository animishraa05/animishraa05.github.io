## 1. How DNS actually works?
Computer and devices communicate using the IP addresses which are not easy to be remembered by a human, so they use words. Domain Name system brings these two together and gives us our destination site.
Lets see how the DNS resolution takes place

- We hit a request on our browser for a particular website for example xyz.com .
- The browser checks its cache to find the IP address for the website xyz.com .
- If the browser does not find the IP of the requested domain name, it requests the Operating System to check its cache for the IP address.
- If the Operating system is also not able to find the IP address of the requested website then the, it calls the resolver.
- The resolver server is usually your ISP (Internet Service Provider). All resolvers must know one thing: where to locate the root server.
- The resolver checks its cache to find the address if it is already there.
- If the resolver fails to find it, then the request goes to the root server.
- The root server knows where to locate the .COM TLD server. TLD stands for Top-Level Domain.
- The root server gives the address of the Top Level Domain server for the requested website.
- There are 13 root name servers that exist today,root servers sit at the top of the DNS hierarchy. They are scattered around the globe and operated by 12 independent organisations. They are named [letter].root-servers.net where [letter] ranges from A to M. 
- This doesn't mean that we have only 13 physical servers to support the whole internet, each organisation provides multiple physical servers distributed around the globe.
- The Resolver now goes to the .com Top Level Domain server to find the address of the requested site.
- The Top Level Domain server also does not know the IP address of the xyz.com but it will tell the name servers for that domain name, like ns1.xyz.com 
  ns2.xyz.com 
  ns3.xyz.com 
  ns4.xyz.com
- A nameserver is a specialized server in the Domain Name System (DNS) that acts as the internet's phonebook. It is responsible for storing DNS records (such as IP addresses) for a domain name and answering requests to translate those human-readable names into machine-readable numerical IP addresses.
  Here a question arises that how did the TDL of .com domain pointed the resolver to the authoritative name servers and how could it make the connection? There are so many .COM domains!?
  -> The answer to all these questions is *Domain Registrar*, when a domain is purchased the domain registrar reserves the name and communicates to the TDL registry the authoritative name servers.
- Now the resolver reached the name server ns1.xyz.com there are more than one server running for a domain as they have to globally manage the load on the website.
-> If you want to know who are the authoritative name servers for your domain, run a WHOIS query. There are a few websites that provide this information.
- The resolver get the IP of the requested domain and saves the IP address and gives it to OS.
- The Operating System gives this address to the browser and then the user sees the website.

-> *A STRANGE QUESTION ARISES*
   *How could the resolver find 'ns1.xyz.com' before 'xyz.com'?*
   Since 'ns1.xyz.com' is a subdomain of 'xyz.com', how could we resolve 'ns1.xyz.com' without resolving 'xyz.com' first?
   Isn't the search going backwards?
   HOW CAN WE GET A SUB-DOMAIN WITHOUT GETTING A DOMAIN!?!?!?
   - The answer is GLUE RECORDS !
   - When the resolver asked the .COM TLD about xyz.com, extra information was attached to that response.
   - The resolver got at least one IP address for each name server, these are called glue records.
   - So the resolver not only got the name of the authoritative name server, it also got the IP address which breaks the circular dependency.


### 1.1 DNS Records
A Domain Name System (DNS) record is a set of instructions used to connect domain names with internet protocol (IP) addresses within DNS servers.
DNS records exist as text-based files known as “zone files” written in DNS syntax. They serve as a record and set of commands on how to handle DNS queries. When a user searches a domain name or URL or takes action related to a domain name in a web browser, this is the beginning of a DNS query. A series of DNS servers then communicate with each other to resolve this query. DNS servers rely on DNS records to connect that user with the corresponding IP address and resolve all other issues. DNS records are stored on authoritative DNS servers also known as authoritative nameservers. They contain information on how frequently a server will refresh the DNS record, known as time-to-live (TTL).

Common types of DNS records:
1. A records: A records stands for Address records, they are the most commonly used DNS record. They directly connect the IPv4 addresses to the domain name.
2. AAAA records: They connect the IPv6 addresses to the domain name.
3. CNAME records: Canonical Name records, direct an alias domain to a canonical domain. This means that this type of record is used to link subdomains to domain A or AAAA records.
4. DNAME records: Delegation name records, or DNAME records, are used to redirect multiple subdomains with one record and point them to another domain.
    For example, a DNAME record linking domain.com to example.com will link product.domain.com, trial.domain.com, and blog.domain.com to example.com. These records are helpful in managing largescale domains and in managing domain name changes by ensuring subdomains are properly linked.
5. CAA records: Certification authority authorization records, or CAA records, allow domain owners to specify which certificate authorities (CAs) can issue certificates for their domain. A CA is an organization that validates the identity of websites and connects them to cryptographic keys by issuing digital certificates
6. CERT records: Certificate, or CERT records, store certificates that verify the authenticity of all parties involved. This type of record is particularly valuable when securing and encrypting sensitive information.
7. MX records: Mail exchange, or MX records, direct emails to your domain mail server. These records, along with an email server, allow for the creation of individual email accounts, such as user@example.com, that are linked to the domain (example.com)
8. NS records: Nameserver, or NS records, show which DNS server is acting as the authoritative nameserver for your domain. Authoritative nameservers contain the final information about a specific domain and its corresponding IP address. An NS record points to all of the different records your domain holds. Without NS records, users will not be able to access your website
9. SOA records: Start of authority, or SOA records, store important administrative information about a domain. This information can include the domain administrator’s email address, information on domain updates and when a server should refresh its information.
10. PTR records: Pointer records, or PTR records, work in the opposite direction of A records. They are used to connect an IP address with a domain name, instead of a domain name with an IP address. When a DNS lookup begins with an IP address, it then finds the corresponding hostname. These records are used to detect spam by checking if the IP addresses and associated email addresses are used by legitimate email servers. PTR records must be set up by the server host.
11. SPF records: Sender policy framework, or SPF records, are used to identify the mail servers that can send emails through your domain. This helps prevent your domain from being used by spammers or for malicious purposes by letting email receivers know that what they are receiving has been authorized.
12. SRV records: Service, or SRV records, identify a host and port for specific services, such as messaging, for a domain. Ports are virtual connection points that allow digital devices to separate different types of traffic.
13. ALIAS records: ALIAS records are used to direct your domain name to a host name and not an IP address. For instance, if your domain name is example.com, you can point it to product.differentexample.com using an ALIAS record.
14. NSEC records: Next secure records, or NSEC records, allow for proof of non-existence. This means that these records exist to confirm that other records do not exist. Being able to confirm the non-existance of a record saves time when searching for specific records.
15. URLFWD records: URL forwarding (or URL redirecting) is a technique used to make a single web page available via multiple URLs. (NS1 Connect) users can easily set up URL forwarding (HTTP redirects or masking) between zones. There are three types of URL redirects: Permanent (301), temporary (302), or masking.
16. TXT records: Text, or TXT records, store textual information related to domains and subdomains. Text records allow for the storage of SPF records and email verification records.
 ---

## 2. How HTTP works?
