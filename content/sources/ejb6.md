---
title: "You said I don’t know anything about this subject ..."
created: 2026-04-29
description: "Gemini conversation with 88 messages"
tags:
  - "clippings"
---
nter JNDI

JNDI is a system for Java-based clients to interact with naming and directory

systems. JNDI is a bridge over naming and directory services, a beast that pro-

vides one common interface to disparate directories. Users who need to access

an LDAP directory use the same API as users who want to access an NIS direc-

tory or a Novell directory. All directory operations are done through the JNDI

interface, providing a common framework.

Benefits of JNDI

The following surveys the advantages that JNDI has to offer:

■■ You need to learn only a single API to access all sorts of directory ser-

vice information, such as security credentials, phone numbers, elec-

tronic and postal mail addresses, application preferences, network

addresses, machine configurations, and more.

■■ JNDI insulates the application from protocol and implementation

details.

670 Appendix A

■■ You can use JNDI to read and write whole Java objects from directories.

■■ You can link different types of directories, such as an LDAP directory

with an NDS directory, and have the combination appear to be one

large, federated directory. The federated directory appears to the client

to be one contiguous directory.

In J2EE, you can use JNDI for many purposes. These include:

■■ Using JNDI to acquire a reference to the Java Transaction API (JTA)

UserTransaction interface

■■ Using JNDI to connect to resource factories, such as JDBC drivers or

Java Message Service (JMS) drivers

■■ Using JNDI for beans to look up other beans

See Chapters 10 and 11 for examples of achieving these operations.

The JNDI Architecture

JNDI is made up of two halves: the client API and the Service Provider Interface

(SPI). The client API allows your Java code to perform directory operations.

This API is uniform for all types of directories. You will spend the most time

using the client API.

The JNDI SPI is a framework for JNDI implementors: an interface to which

naming and directory service vendors can plug in. The SPI is the converse of

the API: While the API allows clients to code to a single, unified interface, the

SPI allows naming and directory service vendors to fit their particular propri-

etary protocols into the system, as shown in Figure A.8. This allows for client

code to leverage proprietary naming and directory services in Java while

maintaining a high level of code portability.

The JNDI architecture is somewhat like the Java Database Connectivity

(JDBC) package:

■■ In JDBC, one uniform client API performs database operations. In JNDI,

naming and directory service clients invoke a unified API for perform-

ing naming and directory operations.

■■ In JDBC, relational database vendors provide JDBC drivers to access

their particular databases. In JNDI, directory vendors provide service

providers to access their specific directories. These providers are aware

of specific directory protocols, and they plug in to the JNDI SPI.

For example, Sun Microsystems gives away an LDAP service provider for

free. The LDAP service provider knows how to map a JNDI client API opera-

tion into an LDAP operation. It then executes the LDAP operation on an LDAP

directory, using the specific LDAP protocol.

RMI-IIOP and JNDI Tutorial 671

Figure A.8 The JNDI architecture.

A number of JNDI service providers are available today, including LDAP,

NIS, Novell NDS, SLP, CORBA Naming Service, File System, RMI-IIOP, and

many more. The JNDI homepage (http://java.sun.com/products/jndi) has a

list of service providers.

J2EE servers bundle a JNDI implementation with their product. Typically

this is a custom implementation provided by the J2EE server vendor. JNDI

then just becomes another service provided by the server, along with RMI-

IIOP, JMS, and so on. Many servers ship JNDI implementations that are fault

tolerant, providing a high level of availability. These JNDI implementations

are intended to integrate with the other J2EE services, such as RMI-IIOP, JDBC,

EJB, and JMS.

JNDI Concepts

We begin our JNDI exploration with naming concepts. There are several kinds

of names in JNDI:

■■ An atomic name is a simple, basic, indivisible name. For example, in the

string /etc/fstab, etc and fstab are atomic names.

■■ A compound name is zero or more atomic names put together using a

specific syntax. In the previous example, the entire string /etc/fstab is a

compound name formed by combining two atomic names with a slash.

A binding is an association of a name with an object. For example, the file

name autoexec.bat in the Windows file system has a binding to the file data on

your hard disk. Your c:\\windows folder is a name that is bound to a folder on

Client Code

Service Provider Interface

LDAP Service

Provider

NIS Service

Provider

File System

Service Provider

JNDI Client API

672 Appendix A

your hard drive. Note that a compound name such as /usr/people/ed/.cshrc con-

sists of multiple bindings, one to usr, one to people, one to ed, and one to .cshrc.

A context is a set of zero or more bindings. Each binding has a distinct atomic

name. So for example, in the UNIX file system, let’s consider a folder named

/etc that contains files named mtab and exports. In JNDI, the /etc folder is a con-

text containing bindings with atomic names mtab and exports. Each of the mtab

and exports atomic names is bound to a file on the hard disk.

To expand this further, consider a folder named /usr with subfolders

/usr/people, /usr/bin, and /usr/local. Here, the /usr folder is a context that contains

the people, bin, and local atomic names. Each of these atomic names is bound to

a subfolder. In JNDI terms, these subfolders are called subcontexts. Each sub-

context is a full-fledged context in its own right, and it can contain more name-

object bindings, such as other files or other folders. Figure A.9 depicts the

concepts we have learned so far.

Figure A.9 JNDI naming concepts.

## Gemini said

Bhai, ye section JNDI (Java Naming and Directory Interface) ka foundation hai. Jaise database se baat karne ke liye **JDBC** hota hai, waise hi network par kisi bhi object, printer, ya EJB ko dhoondne ke liye **JNDI** hota hai.

Tumhe JDBC aur SQL ka idea hai, isliye JNDI ka architecture samajhna tumhare liye ekdum halwa hoga. Chalo in dono diagrams (Figure A.8 aur A.9) ko ekdum depth mein todte hain.

---

### **1\. Figure A.8: The JNDI Architecture (API vs. SPI)**

Ye diagram JNDI ki sabse badi taqat dikhata hai: **Abstraction**. Isko do hisson mein baanta gaya hai:

- **Top Layer: The JNDI Client API (For You)**
	- Ye wo code hai jo tum likhte ho (jaise `Context.lookup("MyBean")`).
		- **Fayda:** Tumhe bas ek API seekhni hai. Piche LDAP chal raha hai, NIS chal raha hai, ya file system hai—tumhe farq nahi padta. Tumhara code same rahega.
- **Bottom Layer: The JNDI SPI (Service Provider Interface)**
	- Ye hissa "Vendors" (jaise Microsoft, Sun, Novell) ke liye hota hai.
		- Jaise MySQL aur PostgreSQL apne alag-alag **JDBC Drivers** dete hain, waise hi LDAP ya Active Directory apne **JNDI Service Providers (Drivers)** dete hain. Ye providers SPI ke through JNDI se plug-in ho jate hain aur tumhari API request ko apne private protocol mein convert kar lete hain.

**In Short:** API tumhare liye hai, SPI hardware/software vendors ke liye hai. JNDI in dono ke beech ka universal translator hai.

---

### **2\. Figure A.9: JNDI Naming Concepts (The Folder Analogy)**

JNDI ek tree structure (hierarchy) maintain karta hai, bilkul tumhare computer ke File System ki tarah. Book ne yahan 5 terms bataye hain jo exam ke liye bahut zaroori hain:

1. **Binding:** Kisi "Naam" ko kisi "Asli Object" ke saath jodna. (Jaise naam `autoexec.bat` hard drive par padi asli file se juda hai).
2. **Context:** Ek "Folder". Iske andar bahut saari bindings hoti hain.
3. **Subcontext:** Folder ke andar ka folder (Sub-folder). Ek subcontext apne aap mein ek poora context hota hai.
4. **Atomic Name:** Naam ka ek akela, chota hissa. (e.g., `usr`, `bin`, ya `fstab`).
5. **Compound Name:** Bahut saare Atomic names ko mila kar banaya gaya poora rasta (Path). (e.g., `/usr/bin` ya `java:comp/env/jdbc`).

Niche maine ek interactive widget banaya hai taaki tum is JNDI Directory Tree ko khud explore kar sako. Isme click karke dekho ki Contexts aur Bindings milkar Compound Names kaise banate hain!

Is tree structure ko samajhna isliye zaruri hai kyunki EJB mein jab hum database connection (DataSource) ya doosri beans dhoondhte hain, toh hum hamesha inhi Compound Names (jaise `java:comp/env/jdbc/myDB`) ka use karke JNDI Context mein lookup karte hain.

Kya JNDI API vs SPI ka funda aur ye directory terms ekdum lock ho gaye hain dimaag mein?

You said

By now you should have a decent list of things you’d have to worry about when

building large business systems. Here’s a short list of the big things we came

up with. Don’t worry if you don’t understand all of them yet — you will.

◆ Remote method invocations. We need logic that connects a client and

server via a network connection. This includes dispatching method re-

quests, brokering parameters, and more.

◆ Load balancing. Clients must be directed to the server with the lightest

load. If a server is overloaded, a different server should be chosen.

◆ Transparent fail-over. If a server crashes, or if the network crashes, can

clients be rerouted to other servers without interruption of service? If so,

how fast does fail-over happen? Seconds? Minutes? What is acceptable

for your business problem?

◆ Back-end integration. Code needs to be written to persist business data

into databases as well as integrate with legacy systems that may already

exist.

◆ Transactions. What if two clients access the same row of the database si-

multaneously? Or what if the database crashes? Transactions protect you

from these issues.

◆ Clustering. What if the server contains state when it crashes? Is that state

replicated across all servers, so that clients can use a different server?

◆ Dynamic redeployment. How do you perform software upgrades while

the site is running? Do you need to take a machine down, or can you

keep it running?

(continued)

6 Chapter 1

THINGS TO CONSIDER WHEN BUILDING LARGE

BUSINESS SYSTEMS (continued)

◆ Clean shutdown. If you need to shut down a server, can you do it in a

smooth, clean manner so that you don’t interrupt service to clients who

are currently using the server?

◆ Logging and auditing. If something goes wrong, is there a log that you

can consult to determine the cause of the problem? A log would help you

debug the problem so it doesn’t happen again.

◆ Systems management. In the event of a catastrophic failure, who is mon-

itoring your system? You want monitoring software that paged a system

administrator if a catastrophe occurred.

◆ Threading. Now that you have many clients connecting to a server, that

server is going to need the capability of processing multiple client re-

quests simultaneously. This means the server must be coded to be multi-

threaded.

◆ Message-oriented middleware. Certain types of requests should be

message-based where the clients and servers are very loosely coupled.

You need infrastructure to accommodate messaging.

◆ Object life cycle. The objects that live within the server need to be cre-

ated or destroyed when client traffic increases or decreases, respectively.

◆ Resource pooling. If a client is not currently using a server, that server’s

precious resources can be returned to a pool to be reused when other

clients connect. This includes sockets (such as database connections) as

well as objects that live within the server.

◆ Security. The servers and databases need to be shielded from saboteurs.

Known users must be allowed to perform only operations that they have

rights to perform.

◆ Caching. Let’s assume there is some database data that all clients share

and make use of, such as a common product catalog. Why should your

servers retrieve that same catalog data from the database over and over

again? You could keep that data around in the servers’ memory and

avoid costly network roundtrips and database hits.

◆ And much, much, much more.

Each of these issues is a separate service that needs to be addressed for

serious server-side computing. These services are needed in any business

problem and in any vertical industry. And each of these services requires a lot

of thought and a lot of plumbing to resolve. Together, these services are called

middleware.

Component

## Gemini said

Bhai, lagta hai tum ekdum basics, yaani **Chapter 1** par wapas aa gaye ho! Ye chapter kaafi crucial hai kyunki ye batata hai ki EJB (ya aaj kal ke time mein Spring Boot) jaisi badi technologies ki zaroorat hi kyun padti hai.

Jab tum ek simple college project banate ho, toh ye sab tension nahi hoti. Par jab tum kisi enterprise (jaise SEBI, Banks, ya Amazon) ke liye production-level system banate ho, toh code fatne ke hazar tareeke hote hain.

Book ne yahan 16 problems ki list di hai. Exam mein isko "Features of Middleware" ya "Need for EJB Container" ke naam se pucha jata hai. Inko ratne ki jagah, main inko **4 logical buckets** mein daal deta hoon taaki tumhare DBMS aur Architecture concepts ke sath link ho jaye:

---

### **Bucket 1: The Network & Traffic Police (Scalability)**

Jab hazaron users ek sath aate hain, toh server traffic kaise handle karega?

1. **Remote Method Invocations (RMI):** Ek computer ka program doosre computer ke program ko kaise call karega (Humne Appendix A mein Stubs aur Skeletons wala part padha tha).
2. **Load Balancing:** Agar Server A par 1000 users hain aur Server B par 10, toh naye user ko Server B par bhejna taaki load divide ho sake.
3. **Clustering & Transparent Fail-over:** Agar chalte-chalte Server A achanak jal jaye (crash ho jaye), toh user ko bina error dikhaye uska session chup-chaap Server B par shift kar dena (Fail-over).

### **Bucket 2: Database & Consistency (Data Layer)**

Tumhara strong zone. Data safe aur fast kaise rahega? 4. **Transactions:** Agar do log ek sath same bank account se paise nikalenge, toh DB corrupt na ho. (Humne Unit 5 mein Flat/Nested aur CMT/BMT padha tha). 5. **Caching:** Jo data baar-baar change nahi hota (jaise product catalog), use baar-baar DB se fetch karne ki jagah RAM mein save kar lena taaki speed fast ho. 6. **Back-end Integration:** Naye Java system ko company ke 20 saal purane (legacy) database ya mainframe se jodna.

### **Bucket 3: CPU & Memory Management (Performance)**

Server ki RAM aur CPU ka best use kaise hoga? 7. **Threading:** Ek hi time par 500 requests aayin toh unhe parallel mein process karna (Multi-threading). 8. **Resource Pooling:** Database connection open karna bahut heavy operation hota hai. Isliye connections ka ek "Pool" bana kar rakhna aur unhe reuse karna. 9. **Object Life Cycle:** Memory bachane ke liye objects ko RAM mein banana aur kaam khatam hone par destroy karna (Entity Beans ka Pooled 
$$
↔
$$
 Ready state yaad hai?).

### **Bucket 4: DevOps, Security & Async Communication**

System chalta rahe aur secure rahe, iski guarantee. 10. **Message-Oriented Middleware (MOM):** Jab immediate reply nahi chahiye (Fire-and-forget). Ye humne Unit 4 ke Message-Driven Beans (MDB) mein deeply cover kiya tha. 11. **Security:** Kaun sa user admin hai, kaun sa normal user, aur kisko kaun sa method call karne ki permission hai. 12. **Dynamic Redeployment & Clean Shutdown:** System (Amazon.com) ko band kiye bina naya code ya update live push karna. 13. **Logging, Auditing & Systems Management:** Agar kuch fata, toh log files mein check karna ki exactly kis line par exception aayi thi taaki debug kar sakein.

---

### **The Grand Conclusion: Middleware kya hai?**

Agar tum ek normal Java class likhte ho, toh upar ki ye 16 cheezein tumhe **khud code karni padengi**. Tumhara 80% time is "Plumbing" (infrastructure) mein nikal jayega aur sirf 20% time asli Business Logic (jaise loan calculate karna) mein lagega.

**Middleware (EJB Container / Application Server)** ek aisa ready-made software hai jo ye saari 16 cheezein tumhe **free mein** handle karke deta hai. Tumhe bas apna Business Logic (Bean class) likhna hai aur EJB Container ko de dena hai.

Bas yahi core logic hai EJB architecture ka. Ab batao, kya ab poori EJB series (Unit 3, 4, 5) ke dots ek dusre se perfectly connect ho rahe hain? Exam ke liye architecture ka ye big picture clear hai?

You said

e J2EE Technologies

J2EE is a robust suite of middleware services that make life very easy for

server-side application developers. J2EE builds on the existing technologies in

the J2SE. J2SE includes support for core Java language semantics as well as

various libraries (.awt, .net, .io, and so on). Because J2EE builds on J2SE, a

J2EE-compliant product must not only implement all of J2EE, but must also

implement all of J2SE. This means that building a J2EE product is an

absolutely huge undertaking. This barrier to entry has resulted in significant

industry consolidation in the Enterprise Java space, with a few players emerg-

ing from the pack as leaders.

In this book, we will discuss EJB 2.1, an integral part of J2EE 1.4. Some of the

major J2EE technologies are shown working together in Figure 1.6.

To understand more about the real value of J2EE, here are some of the

important technologies and APIs that a J2EE 1.4-compliant implementation

will support for you.

■■ Enterprise JavaBeans (EJB). EJB defines how server-side components

are written and provides a standard contract between components and

the application servers that manage them. EJB is the cornerstone for

J2EE and uses several other J2EE technologies.

22 Chapter 1

Figure 1.6 A J2EE deployment.

■■ Java API for XML RPC (JAX-RPC). JAX-RPC is the main technology

that provides support for developing Web Services on the J2EE plat-

form. It defines two Web Service endpoint models—one based on

servlet technology and another based on EJB. It also specifies a lot of

runtime requirements regarding the way Web Services should be sup-

ported in a J2EE runtime. Another specification called Web Services for

J2EE defines deployment requirements for Web Services and uses the

JAX-RPC programming model. Chapter 5 discusses support of Web

Services provided by both these specifications for EJB applications.

■■ Java Remote Method Invocation (RMI) and RMI-IIOP. RMI is the Java

language’s native way to communicate between distributed objects,

such as two different objects running on different machines. RMI-IIOP

Firewall

EJBs

Existing System

Legacy System

ERP System

IIOP

Client Tier

J2EE Server

Back-End

Systems

Business

Partner

or Other System

Servlets

Business Partner

or Other System

Applets,

Applications,

CORBA Clients

IIOP

Web services technologies

(SOAP, UDDI, WSDL, ebXML) HTTP

Databases

Proprietary Protocol Web Services Technologies

(SOAP, UDDI, WSDL, ebXML)

Connectors

SQL

JSPs

Web Browser Wireless Device

HTTP

JMS

Overview 23

is an extension of RMI that can be used for CORBA integration. RMI-

IIOP is the official API that we use in J2EE (not RMI). We cover RMI-

IIOP in Appendix A.

■■ Java Naming and Directory Interface (JNDI). JNDI is used to access

naming and directory systems. You use JNDI from your application

code for a variety of purposes, such as connecting to EJB components or

other resources across the network, or accessing user data stored in a

naming service such as Microsoft Exchange or Lotus Notes. JNDI is

covered in Appendix A.

■■ Java Database Connectivity (JDBC). JDBC is an API for accessing rela-

tional databases. The value of JDBC is that you can access any relational

database using the same API. JDBC is used in Chapter 7.

■■ Java Transaction API (JTA) and Java Transaction Service (JTS). The

JTA and JTS specifications allow for components to be bolstered with

reliable transaction support. JTA and JTS are explained in Chapter 12.

■■ Java Messaging Service (JMS). JMS allows for your J2EE deployment

to communicate using messaging. You can use messaging to communi-

cate within your J2EE system as well as outside your J2EE system. For

example, you can connect to existing message-oriented middleware

(MOM) systems such as IBM MQSeries or Microsoft Message Queue

(MSMQ). Messaging is an alternative paradigm to RMI-IIOP, and has

its advantages and disadvantages. We explain JMS in Chapter 9.

■■ Java servlets. Servlets are networked components that you can use to

extend the functionality of a Web server. Servlets are request/response

oriented in that they take requests from some client host (such as a Web

browser) and issue a response back to that host. This makes servlets

ideal for performing Web tasks, such as rendering an HTML interface.

Servlets differ from EJB components in that the breadth of server-side

component features that EJB offers, such as declarative transactions, is

not readily available to servlets. Servlets are much better suited to han-

dling simple request/response needs, and they do not require sophisti-

cated management by an application server. We illustrate using servlets

with EJB in Chapter 22.

■■ JavaServer Pages (JSP). JSP technology is very similar to servlets. In

fact, JSP scripts are compiled into servlets. The largest difference

between JSP scripts and servlets is that JSP scripts are not pure Java

code; they are much more centered on look-and-feel issues. You would

use JSP when you want the look and feel of your deployment to be

physically separate and easily maintainable from the rest of your

deployment. JSP technology is perfect for this, and it can be easily writ-

ten and maintained by non–Java-savvy staff members (JSP technology

24 Chapter 1

does not require a Java compiler). We illustrate using JSP with EJB in

Chapter 22.

■■ Java IDL. Java IDL is the Sun Microsystems Java-based implementation

of CORBA. Java IDL allows for integration with other languages. Java

IDL also allows for distributed objects to leverage the full range of

CORBA services. J2EE is thus fully compatible with CORBA, complet-

ing the Java 2 Platform, Enterprise Edition. We discuss CORBA interop-

erability in Appendix B.

■■ JavaMail. The JavaMail service enables you to send e-mail messages in

a platform-independent, protocol-independent manner from your Java

programs. For example, in a server-side J2EE deployment, you can use

JavaMail to confirm a purchase made on your Internet e-commerce site

by sending an e-mail to the customer. Note that JavaMail depends on

the JavaBeans Activation Framework (JAF), which makes JAF part of J2EE

as well. We do not cover JavaMail in this book.

■■ J2EE Connector Architecture (JCA). Connectors enable you to access

existing enterprise information systems from a J2EE application. This

could include any existing system, such as a mainframe system running

high-end transactions (such as those deployed with IBM CICS, or BEA

TUXEDO), Enterprise Resource Planning (ERP) systems, or your own

proprietary systems. Connectors are useful because they automatically

manage the details of middleware integration to existing systems, such

as handling transactions and security concerns, life-cycle management,

thread management, and so on. Another value of this architecture is

that you can write a connector to access an existing system once, and

then deploy it into any J2EE-compliant server. This is important

because you only need to learn how to access an existing system once.

Furthermore, the connector needs to be developed only once and can be

reused in any J2EE server. This is extremely useful for independent soft-

ware vendors (ISVs) such as SAP, Siebel, Peoplesoft and others who

want their software to be accessible from within J2EE application

servers. Rather than write a custom connector for each application

server, these ISVs can write a standard J2EE connector. We discuss

legacy integration in more details in Chapter 17.

■■ The Java API for XML Parsing (JAXP). There are many applications of

XML in a J2EE deployment. For example, you might need to parse XML

if you are performing B2B interactions (such as through Web Services),

if you are accessing legacy systems and mapping data to and from

XML, or if you are persisting XML documents to a database. JAXP is the

de facto API for parsing XML documents in a J2EE application and is an

implementation-neutral interface to XML parsing technologies such as

DOM and SAX. You typically use the JAXP API from within servlets,

JSP, or EJB components.

Overview 25

■■ The Java Authentication and Authorization Service (JAAS). JAAS is a

standard API for performing security-related operations in J2EE. Con-

ceptually, JAAS also enables you to plug in an authentication mecha-

nism into a J2EE application server. See Chapter 13 for more details on

security pertaining to EJB applications.

## Gemini said

Bhai, ye Chapter 1 ka wo hissa hai jo **J2EE (Java 2 Enterprise Edition) ke poore "Ecosystem"** ko explain karta hai.

Jab tum Spring Boot ya modern Java backend use karte ho, toh tum indirectly inhi J2EE standards ka modern version use kar rahe hote ho. J2EE koi ek software ya language nahi hai, ye ek **"Collection of APIs"** (yaani rules ka set) hai. Agar kisi server (jaise Tomcat, WebLogic, GlassFish) ko "J2EE-compliant" banna hai, toh use in sabhi technologies ko support karna padega.

Exam aur interview (especially SEBI Grade A ya banking IT roles) ke liye is lambi list ko ratne ki jagah, main isko **5 Logical Layers (Tiers)** mein baant deta hoon taaki yaad rakhna aasan ho:

---

### **1\. The Web/Presentation Layer (Client se baat karne wale)**

Ye wo log hain jo direct web browser (HTTP) se deal karte hain.

- **Servlets:** Ye pure Java classes hain jo HTTP requests (GET/POST) leti hain aur response (HTML) bhejti hain. (EJB itna heavy hai ki direct web request handle nahi karta, Servlet uske liye gatekeeper ka kaam karta hai).
- **JSP (JavaServer Pages):** Ye dikhne mein HTML jaisa hota hai jisme Java code embedded hota hai. Design (UI) banane ke liye best hai. (Pichhe se JSP compile hoke Servlet hi banta hai).

### **2\. The Business Logic Layer (The Brains)**

- **EJB (Enterprise JavaBeans):** Ye tumhara core syllabus hai. System ka saara main dimaag (logic), calculations, aur database synchronization EJB (Session, Entity, MDB) ke andar hota hai.

### **3\. The Communication & Integration Layer (Wires & Pipes)**

EJB aur doosre systems aapas mein baat kaise karenge?

- **RMI-IIOP:** Do Java objects jo alag-alag computers par hain, unko aapas mein direct, synchronous (wait karne wali) baat karwane ke liye.
- **JMS (Java Messaging Service):** Asynchronous baatcheet ke liye. (Jaise Message-Driven Beans mein dekha tha: Fire-and-forget).
- **JCA (J2EE Connector Architecture):** Agar tumhari company ka naya J2EE app kisi 30 saal purane IBM Mainframe ya SAP (ERP) system se baat karna chahta hai, toh uske liye "Connectors" (JCA) use hote hain.
- **JAX-RPC & Java IDL:** Alag languages (C++, .NET) se baat karne ke liye Web Services (SOAP) aur CORBA (IDL) ka use.

### **4\. The Data & Persistence Layer (Storage)**

- **JDBC:** Relational database (MySQL, Oracle) mein raw SQL queries chalane ka standard API.
- **JAXP:** XML files ko read/write (parse) karne ke liye. (Kyunki configuration aur data exchange aksar XML mein hota hai).

### **5\. The Foundation Services (The Middleware Superpowers)**

Ye wo services hain jo EJB container "free" mein provide karta hai:

- **JNDI:** Naming directory. Network pe EJB ya Database connection ka pata (lookup) dhoondne ke liye "Phonebook".
- **JTA/JTS:** Transactions handle karne ke liye (Commit/Rollback, jo humne Unit 5 mein dekha).
- **JAAS:** Security ke liye (Kaun login kar raha hai aur uske paas kya permissions hain).
- **JavaMail:** System se automatic emails bhejne ke liye (e.g., Order Confirmation).

---

### **The Big Picture for your Career:**

Tumhara goal placements aur SEBI exam hai, sath mein tum Spring Boot par bhi kaam kar rahe ho. Ek baat hamesha yaad rakhna: **J2EE thoda purana aur heavy standard hai.** Aaj kal industry mein inhi cheezon ko asaan banane ke liye **Spring Framework** use hota hai. (Jaise EJB ki jagah Spring Beans, JDBC ki jagah Spring Data JPA, aur JAX-RPC ki jagah Spring REST). Lekin under the hood, Spring bhi inhi core J2EE APIs (Servlet, JPA, JMS, JTA) par depend karta hai.

Is list mein kisi specific API (jaise JCA ya JAX-RPC) ka kaam samajhne mein koi doubt hai? Ya hum EJB architecture ke kisi aur section pe chalein?

You said

JB is only a portion of a larger offering from the Java Community Process

(a.k.a. JCP—a Java industry standards body) called the Java 2 Platform, Enter-

prise Edition (J2EE). The mission of J2EE is to provide a platform-indepen-

dent, portable, multiuser, secure, and standard enterprise-class platform for

server-side deployments written in the Java language.

J2EE is a specification, not a product. J2EE specifies the rules of engagement

that people must agree on when writing enterprise software. Vendors then

implement the J2EE specifications with their J2EE-compliant products.

Because J2EE is a specification (meant to address the needs of many compa-

nies), it is inherently not tied to one vendor; it also supports cross-platform

development. This encourages vendors to compete, yielding best-of-breed

products. It also has its downside, which is that incompatibilities between ven-

dor products will arise—some problems due to ambiguities with specifica-

tions, other problems due to the human nature of competition.

J2EE is one of three different Java platforms. Each platform is a conceptual

superset of the next smaller platform.

■■ The Java 2 Platform, Micro Edition (J2ME) is a development platform

for applications running on mobile Java-enabled devices, such as

Phones, Palm Pilots, Pagers, set-top TV boxes, and so on. This is a

restricted form of the Java language due to the inherent performance

and capacity limitations of small-form-factor wireless devices.

■■ The Java 2 Platform, Standard Edition (J2SE) defines a standard for

core libraries that can be used by applets, applications, J2EE applica-

tions, mobile applications, and such. These core libraries span a much

wider spectrum including input/output, graphical user interface facili-

ties, networking, and so on. This platform contains what most people

use in standard Java programming.

■■ The Java 2 Platform, Enterprise Edition (J2EE) is an umbrella standard

for Java’s enterprise computing facilities. It basically bundles together

technologies for a complete enterprise-class server-side development

and deployment platform in Java.

J2EE is significant because it creates a unified platform for server-side Java

development. The J2EE stack consists of the following:

■■ Specifications. Each enterprise API within J2EE has its own specifica-

tion, which is a PDF file downloadable from www.jcp.org. Each time

there is a new version of J2EE, the J2EE Expert Group at JCP locks

down the versions of each Enterprise API specification and bundles

them together as the de facto versions to use when developing with

J2EE. This increases code portability across vendors’ products, because

Overview 21

each vendor supports exactly the same API revision. This is analogous

to a company such as Microsoft releasing a new version of Windows

every few years: Every time a new version of Windows comes out,

Microsoft locks down the versions of the technologies bundled with

Windows and releases them together.

■■ Test suite. Sun provides a test suite (a.k.a. Test Compatibility Kit or

TCK) for J2EE server vendors to test their implementations against. If a

server passes the tests, Sun issues a J2EE compliance brand, alerting

customers that the vendor’s product is indeed J2EE-compliant. There

are numerous J2EE-certified vendors, and you can read reviews of their

products for free on TheServerSide.com.

■■ Reference implementation. To enable developers to write code against

J2EE Sun provides its own free reference implementation for each ver-

sion of J2EE. Sun is positioning it as a low-end reference platform,

because it is not intended for commercial use. You can download the

reference implementation for J2EE 1.4, the latest version of J2EE plat-

form that includes EJB 2.1, the technology of focus in this book, from

http://java.sun.com/j2ee/download.html.

The J2EE Technologies

J2EE is a robust suite of middleware services that make life very easy for

server-side application developers. J2EE builds on the existing technologies in

the J2SE. J2SE includes support for core Java language semantics as well as

various libraries (.awt, .net, .io, and so on). Because J2EE builds on J2SE, a

J2EE-compliant product must not only implement all of J2EE, but must also

implement all of J2SE. This means that building a J2EE product is an

absolutely huge undertaking. This barrier to entry has resulted in significant

industry consolidation in the Enterprise Java space, with a few players emerg-

ing from the pack as leaders.

In this book, we will discuss EJB 2.1, an integral part of J2EE 1.4. Some of the

major J2EE technologies are shown working together in Figure 1.6.

To understand more about the real value of J2EE, here are some of the

important technologies and APIs that a J2EE 1.4-compliant implementation

will support for you.

■■ Enterprise JavaBeans (EJB). EJB defines how server-side components

are written and provides a standard contract between components and

the application servers that manage them. EJB is the cornerstone for

J2EE and uses several other J2EE technologies.

22 Chapter 1

Figure 1.6 A J2EE deployment.

■■ Java API for XML RPC (JAX-RPC). JAX-RPC is the main technology

that provides support for developing Web Services on the J2EE plat-

form. It defines two Web Service endpoint models—one based on

servlet technology and another based on EJB. It also specifies a lot of

runtime requirements regarding the way Web Services should be sup-

ported in a J2EE runtime. Another specification called Web Services for

J2EE defines deployment requirements for Web Services and uses the

JAX-RPC programming model. Chapter 5 discusses support of Web

Services provided by both these specifications for EJB applications.

■■ Java Remote Method Invocation (RMI) and RMI-IIOP. RMI is the Java

language’s native way to communicate between distributed objects,

such as two different objects running on different machines. RMI-IIOP

Firewall

EJBs

Existing System

Legacy System

ERP System

IIOP

Client Tier

J2EE Server

Back-End

Systems

Business

Partner

or Other System

Servlets

Business Partner

or Other System

Applets,

Applications,

CORBA Clients

IIOP

Web services technologies

(SOAP, UDDI, WSDL, ebXML) HTTP

Databases

Proprietary Protocol Web Services Technologies

(SOAP, UDDI, WSDL, ebXML)

Connectors

SQL

JSPs

Web Browser Wireless Device

HTTP

JMS

Overview 23

is an extension of RMI that can be used for CORBA integration. RMI-

IIOP is the official API that we use in J2EE (not RMI). We cover RMI-

IIOP in Appendix A.

■■ Java Naming and Directory Interface (JNDI). JNDI is used to access

naming and directory systems. You use JNDI from your application

code for a variety of purposes, such as connecting to EJB components or

other resources across the network, or accessing user data stored in a

naming service such as Microsoft Exchange or Lotus Notes. JNDI is

covered in Appendix A.

■■ Java Database Connectivity (JDBC). JDBC is an API for accessing rela-

tional databases. The value of JDBC is that you can access any relational

database using the same API. JDBC is used in Chapter 7.

■■ Java Transaction API (JTA) and Java Transaction Service (JTS). The

JTA and JTS specifications allow for components to be bolstered with

reliable transaction support. JTA and JTS are explained in Chapter 12.

■■ Java Messaging Service (JMS). JMS allows for your J2EE deployment

to communicate using messaging. You can use messaging to communi-

cate within your J2EE system as well as outside your J2EE system. For

example, you can connect to existing message-oriented middleware

(MOM) systems such as IBM MQSeries or Microsoft Message Queue

(MSMQ). Messaging is an alternative paradigm to RMI-IIOP, and has

its advantages and disadvantages. We explain JMS in Chapter 9.

■■ Java servlets. Servlets are networked components that you can use to

extend the functionality of a Web server. Servlets are request/response

oriented in that they take requests from some client host (such as a Web

browser) and issue a response back to that host. This makes servlets

ideal for performing Web tasks, such as rendering an HTML interface.

Servlets differ from EJB components in that the breadth of server-side

component features that EJB offers, such as declarative transactions, is

not readily available to servlets. Servlets are much better suited to han-

dling simple request/response needs, and they do not require sophisti-

cated management by an application server. We illustrate using servlets

with EJB in Chapter 22.

■■ JavaServer Pages (JSP). JSP technology is very similar to servlets. In

fact, JSP scripts are compiled into servlets. The largest difference

between JSP scripts and servlets is that JSP scripts are not pure Java

code; they are much more centered on look-and-feel issues. You would

use JSP when you want the look and feel of your deployment to be

physically separate and easily maintainable from the rest of your

deployment. JSP technology is perfect for this, and it can be easily writ-

ten and maintained by non–Java-savvy staff members (JSP technology

24 Chapter 1

does not require a Java compiler). We illustrate using JSP with EJB in

Chapter 22.

■■ Java IDL. Java IDL is the Sun Microsystems Java-based implementation

of CORBA. Java IDL allows for integration with other languages. Java

IDL also allows for distributed objects to leverage the full range of

CORBA services. J2EE is thus fully compatible with CORBA, complet-

ing the Java 2 Platform, Enterprise Edition. We discuss CORBA interop-

erability in Appendix B.

■■ JavaMail. The JavaMail service enables you to send e-mail messages in

a platform-independent, protocol-independent manner from your Java

programs. For example, in a server-side J2EE deployment, you can use

JavaMail to confirm a purchase made on your Internet e-commerce site

by sending an e-mail to the customer. Note that JavaMail depends on

the JavaBeans Activation Framework (JAF), which makes JAF part of J2EE

as well. We do not cover JavaMail in this book.

■■ J2EE Connector Architecture (JCA). Connectors enable you to access

existing enterprise information systems from a J2EE application. This

could include any existing system, such as a mainframe system running

high-end transactions (such as those deployed with IBM CICS, or BEA

TUXEDO), Enterprise Resource Planning (ERP) systems, or your own

proprietary systems. Connectors are useful because they automatically

manage the details of middleware integration to existing systems, such

as handling transactions and security concerns, life-cycle management,

thread management, and so on. Another value of this architecture is

that you can write a connector to access an existing system once, and

then deploy it into any J2EE-compliant server. This is important

because you only need to learn how to access an existing system once.

Furthermore, the connector needs to be developed only once and can be

reused in any J2EE server. This is extremely useful for independent soft-

ware vendors (ISVs) such as SAP, Siebel, Peoplesoft and others who

want their software to be accessible from within J2EE application

servers. Rather than write a custom connector for each application

server, these ISVs can write a standard J2EE connector. We discuss

legacy integration in more details in Chapter 17.

■■ The Java API for XML Parsing (JAXP). There are many applications of

XML in a J2EE deployment. For example, you might need to parse XML

if you are performing B2B interactions (such as through Web Services),

if you are accessing legacy systems and mapping data to and from

XML, or if you are persisting XML documents to a database. JAXP is the

de facto API for parsing XML documents in a J2EE application and is an

implementation-neutral interface to XML parsing technologies such as

DOM and SAX. You typically use the JAXP API from within servlets,

JSP, or EJB components.

Overview 25

■■ The Java Authentication and Authorization Service (JAAS). JAAS is a

standard API for performing security-related operations in J2EE. Con-

ceptually, JAAS also enables you to plug in an authentication mecha-

nism into a J2EE application server. See Chapter 13 for more details on

security pertaining to EJB applications.

  

  

they are gonna ask thius in 20 marks about wht is j2ee

## Gemini said

Bhai, agar ye seedha **20 marks** ka aane wala hai, toh tumhe examiner ko ekdum structured aur well-organized answer dena hoga. Lambi kahani likhne ki jagah, isko **4 Main Sections** mein baant kar likhna. Isse tumhe pure marks milenge aur yaad rakhna bhi aasan hoga.

Yahan tumhara "20-Mark Exam Master Answer" hai, ekdum to-the-point aur professional:

---

### **Question: What is J2EE? Explain its architecture and core technologies.**

#### **Part 1: Introduction to J2EE (Definition & Purpose)**

- **What is it?** J2EE (Java 2 Platform, Enterprise Edition) is an industry-standard specification (not a product) developed by the Java Community Process (JCP).
- **Mission:** Its goal is to provide a platform-independent, portable, scalable, secure, and multiuser environment for developing enterprise-class server-side applications.
- **Key Concept:** Because J2EE is a "Specification" (rulebook) and not a software, different vendors (like IBM, Oracle, RedHat) build their own "J2EE-compliant" Application Servers based on these rules. This prevents vendor lock-in.

#### **Part 2: The Java Platform Ecosystem (Where does J2EE fit?)**

Examiner ko batao ki Java ke 3 levels hote hain:

1. **J2ME (Micro Edition):** For small, mobile, and wireless devices (phones, pagers) with limited memory and processing power.
2. **J2SE (Standard Edition):** The core Java language and libraries (I/O, GUI, Networking). It is the foundation.
3. **J2EE (Enterprise Edition):** The umbrella standard for enterprise computing. It builds *on top* of J2SE. A J2EE server must support all J2SE features plus enterprise APIs.

#### **Part 3: The 3 Pillars of the J2EE Stack**

How does Sun Microsystems ensure everyone follows the rules?

1. **Specifications:** PDF documents detailing exactly how every API (like EJB, JMS) should work. This ensures code portability across different vendors.
2. **Test Suite (TCK - Test Compatibility Kit):** A testing tool provided by Sun. Vendors must pass these tests to get the "J2EE-compliant" brand certification.
3. **Reference Implementation (RI):** A free, working (but non-commercial) version of a J2EE server provided by Sun so developers can test their code without buying an expensive commercial server.

*(Exam Tip: Yahan par ek basic N-Tier architecture ka block diagram zaroor draw karna)*

#### **Part 4: The Core J2EE Technologies (Grouped by Function)**

*Note: Examiner ko impress karne ke liye inko random list mat karna, inko "Layers" mein likhna.*

**1\. Presentation / Web Technologies (Client Facing):**

- **Servlets:** Java classes that run on the server, intercept HTTP requests from browsers, process them, and send back responses.
- **JSP (JavaServer Pages):** HTML-like pages with embedded Java code. Used for creating dynamic web interfaces separating UI from business logic.

**2\. Business Logic Technologies (The Brains):**

- **EJB (Enterprise JavaBeans):** The cornerstone of J2EE. Used to write secure, transactional, and scalable server-side business components (Session, Entity, and Message-Driven Beans).

**3\. Communication & Integration Technologies (The Network):**

- **RMI-IIOP:** Allows distributed Java objects on different machines to communicate synchronously.
- **JMS (Java Message Service):** API for asynchronous communication using Message Queues or Topics (Publish/Subscribe).
- **JCA (J2EE Connector Architecture):** Used to connect J2EE applications to old legacy systems (like Mainframes or ERPs like SAP).
- **JAX-RPC:** The API for building and consuming SOAP-based Web Services.
- **Java IDL:** Allows Java to communicate with other languages (like C++) using CORBA.

**4\. Data & Persistence Technologies (Storage):**

- **JDBC (Java Database Connectivity):** The standard API for connecting to and querying relational databases (SQL).
- **JAXP:** API for parsing and processing XML documents (DOM and SAX).

**5\. Core Middleware Services (The Foundation):**

- **JNDI (Java Naming and Directory Interface):** The "phonebook" of J2EE. Used to locate objects, resources, or EJBs over the network using names.
- **JTA/JTS (Java Transaction API):** Manages reliable, distributed transactions (ensuring ACID properties) across multiple databases or systems.
- **JAAS (Java Authentication and Authorization Service):** Handles security, verifying who the user is and what they are allowed to do.
- **JavaMail:** API for sending platform-independent emails (e.g., automated purchase receipts).

---

**Exam Strategy Tip:** Agar time kam bache, toh Part 4 (Technologies) mein har technology ke aage sirf 1-1 line ka description likhna, par **saari categories (Web, Business, Network, DB, Services)** cover karna. Ye structure dekh kar examiner direct 20/20 dega kyunki isme flow aur logic dono hain.

You said

ava RMI-IIOP and EJB Objects

You may have noticed that javax.ejb.EJBObject extends java.rmi.Remote. The

java.rmi.Remote interface is part of Java Remote Method Invocation over the

Internet Inter-ORB Protocol (RMI-IIOP). Any object that implements

java.rmi.Remote is a remote object and is callable from a different JVM. This is

how remote method invocations are performed in Java. (We fully describe this

in Appendix A.)

Because the EJB object provided by the container implements your remote

interface, it also indirectly implements java.rmi.Remote. Your EJB objects are

fully networked RMI-IIOP objects, able to be called from other JVMs or physi-

cal machines located elsewhere on the network. Thus, EJB remote interfaces

are really just RMI-IIOP remote interfaces—except that EJB remote interfaces

must also be built to conform to the EJB specification.

EJB remote interfaces must conform to the RMI-IIOP remote interface rules.

For example, any method that is part of a remote object callable across virtual

machines must throw a special remote exception. A remote exception is a

java.rmi.RemoteException, or (technically) a subclass of it. A remote exception

indicates that something unexpected happened on the network while you

were invoking across virtual machines, such as a network, process, or machine

failure. Every method shown in Source 2.2 for javax.ejb.EJBObject throws a

java.rmi.RemoteException.

Remote interfaces must conform to the RMI-IIOP parameter-passing con-

ventions as well. Not everything can be passed over the network in a cross-VM

method call. The parameters you pass in methods must be valid types for

RMI-IIOP. This includes primitives, serializable objects, and RMI-IIOP remote

objects. The full details of what you can pass are in Appendix A.

EJB Fundamentals 41

The Home Object

As we’ve discussed, client code deals with EJB objects and never with beans

directly. The next logical question is, how do clients acquire references to EJB

objects?

The client cannot instantiate an EJB object directly because the EJB object can

exist on a different machine than the one the client is on. Similarly, EJB pro-

motes location transparency, so clients should never be aware of exactly where

an EJB object resides.

42 Chapter 2

THE INSTANCE-POOLING CONCEPT

A multitier architecture’s overall scalability is enhanced when an application

server intelligently manages needed resources across a variety of deployed

components. The resources could be threads, socket connections, database

connections, and more. For example, database connections could be pooled by

application servers and reused across heterogeneous components. In the EJB

realm, the container is responsible for providing all resource management

services behind the scenes.

In addition to resource management, the EJB container is responsible for

controlling the life cycle of the deployed enterprise bean components. As bean

client requests arrive, the EJB container dynamically instantiates, destroys, and

reuses beans as appropriate. For example, if a client requests a certain type of

bean that does not yet exist in memory, the EJB container may instantiate a

new in-memory instance on behalf of the client. On the other hand, if a bean

already exists in memory, it may not be appropriate to instantiate a new bean,

especially if the system is low on memory. It might make more sense to

reassign a bean from one client to another instead. It might also make sense to

destroy some beans that are not being used anymore. This is called instance

pooling.

The benefit of bean instance pooling is that the pool of beans can be much

smaller than the actual number of clients connecting. This is due to client think

time, such as network lag or human decision time on the client side. The classic

example of this is an HTML (Web) client interacting with a human being. Web

users often click a button that executes some business logic in a component,

but then read text before initiating another action. While the user is waiting

and reading, the application server could reuse that component to service other

clients. While the client is thinking, the container can use the bean instances to

service other clients, saving previous system resources.

The take-away point here is that the EJB container is responsible for

coordinating the entire effort of resource management as well as managing the

deployed beans’ life cycle. Note that the exact scheme used is EJB container-

specific.

  

  

this instance pooling is asked

## Gemini said

Bhai, Unit 3 ka ek bohot hi important aur frequently asked question hai **"Instance Pooling"**.

Tumne Architecture concepts padhe hain, toh isko tum easily ek "Resource Optimization Strategy" ki tarah samajh sakte ho. Examiner basically ye check karna chahta hai ki tumhe EJB server ka memory management samajh aaya hai ya nahi.

---

### **Question: What is Instance Pooling in EJB? Explain its benefits.**

#### **1\. The Core Concept (What is it?)**

- **In Simple Terms:** Jab bohot saare log bank ya ATM ki line mein khade hote hain, toh bank har customer ke liye naya ATM nahi kharidta. Bank 4-5 ATM rakhta hai, aur log unhe **reuse** karte hain. EJB mein **Instance Pooling** bilkul yahi hai.
- **Technical Definition:** Instance Pooling is an optimization technique used by the EJB Container where it creates a set (a "pool") of ready-to-use EJB instances (objects) in memory. Instead of creating a new Java object every time a client makes a request, the container assigns an already existing, idle bean instance from the pool to handle the request.

#### **2\. How does it work? (The Mechanism)**

- **Client Request:** When a client sends a request (e.g., clicks a "Transfer Funds" button), the EJB Container checks if there is a free bean in the pool.
- **Assignment:** If a bean is free, it is temporarily pulled out of the pool and assigned to that specific client to process the request.
- **Return to Pool:** Once the method execution finishes, the bean does *not* die. It is stripped of client-specific data (its state is cleared) and put back into the pool, ready to serve the next client.
- **Creation/Destruction:** If all beans are busy and a new request comes, the container might instantiate a new bean. If there are too many idle beans and memory is low, the container will destroy some to free up RAM.

#### **3\. Why is it needed? (The Motivation)**

- **The Problem:** Creating (`new Object()`) and destroying (`Garbage Collection`) Java objects is an expensive and time-consuming operation for the CPU. If 10,000 users connect, making 10,000 objects will crash the server.
- **Client "Think Time":** Clients are humans. A user clicks a button, gets a web page, and then spends 2 minutes reading it ("Think Time"). During these 2 minutes, if the server kept an object dedicated to that user, it would be a huge waste of memory. Pooling solves this.

#### **4\. Benefits of Instance Pooling (The Advantages)**

- **Memory Conservation:** You can serve 10,000 active clients using only a pool of 50 or 100 bean instances.
- **High Performance (Scalability):** Because objects are pre-created and waiting in the pool, the response time is much faster since the server skips the object initialization phase.
- **Better Garbage Collection:** Fewer objects are created and destroyed, reducing the load on Java's Garbage Collector, which prevents server lag.
- **Resource Sharing:** Along with bean objects, heavy resources like Database Connections and Network Sockets are also pooled, making the whole system incredibly efficient.

---

**Exam Tip:** Agar isko likhte waqt tum **"Client Think Time"** aur **"Scalability"** wale keywords use karoge, toh examiner ko pata chal jayega ki tumhare concepts ekdum solid hain.

Samajh gaya bhai ye pooling ka mechanism? Isme mainly Stateless Session Beans aur Entity Beans involve hote hain.

You said

The Count Bean’s Remote Interface

First let’s define our bean’s remote interface. The code is shown in Source 4.1.

package examples;

import javax.ejb.\*;

import java.rmi.RemoteException;

/\*\*

\* These are CountBean’s business logic methods.

\*

\* This interface is what clients operate on when they

\* interact with EJB objects. The container vendor will

\* implement this interface; the implemented object is

\* the EJB object, which delegates invocations to the

\* actual bean.

\*/

public interface Count extends EJBObject {

/\*\*

\* Increments the int stored as conversational state

\*/

public int count() throws RemoteException;

}

Source 4.1 Count.java.

Our remote interface defines a single business method, count(), which we

will implement in the enterprise bean class.

The Count Bean

Our bean implementation has one business method, count(), which is respon-

sible for incrementing an integer member variable, called val. The conversa-

tional state is the val member variable. Source 4.2 shows the code for our

counter bean.

package examples;

import javax.ejb.\*;

/\*\*

\* Demonstration Stateful Session Bean. This Bean is initialized

\* to some integer value, and has a business method which

Source 4.2 CountBean.java.

90 Chapter 4

\* increments the value.

\*

\* This example shows the basics of how to write a stateful

\* session bean, and how passivation/activation works.

\*/

public class CountBean implements SessionBean {

// The current counter is our conversational state.

public int val;

//

// Business methods

//

/\*\*

\* Counts up

\*/

public int count() {

System.out.println(“count()”);

return ++val;

}

//

// EJB-required methods

//

public void ejbCreate(int val) throws CreateException {

this.val = val;

System.out.println(“ejbCreate()”);

}

public void ejbRemove() {

System.out.println(“ejbRemove()”);

}

public void ejbActivate() {

System.out.println(“ejbActivate()”);

}

public void ejbPassivate() {

System.out.println(“ejbPassivate()”);

}

public void setSessionContext(SessionContext ctx) {

}

}

Source 4.2 (continued)

Introduction to Session Beans 91

Note the following about our bean:

■■ The bean implements javax.ejb.SessionBean (described fully in Appendix

E). This means the bean must define all methods in the SessionBean

interface. By looking at the bean, you can see we’ve defined them but

kept them fairly trivial.

■■ Our ejbCreate() initialization method takes a parameter, val. This

method customizes our bean to the client’s needs. Our ejbCreate()

method is responsible for beginning a conversation with the client. It

uses val as the starting state of the counter.

■■ The val member variable obeys the rules for conversational state

because it is serializable. Thus, it lasts across method calls and is auto-

matically preserved during passivation/activation.

Notice, too, that our code has a setSessionContext() method. This associates

our bean with a session context, which is a specific EJB context used only for ses-

sion beans. Our bean can call back to the container through this object. The ses-

sion context interface looks like this:

public interface javax.ejb.SessionContext

extends javax.ejb.EJBContext

{

public javax.ejb.EJBLocalObject getEJBLocalObject();

public javax.ejb.EJBObject getEJBObject();

}

Notice that the SessionContext interface extends the EJBContext interface,

giving session beans access to all the methods defined in EJBContext (see

Chapter 3 or Appendix E).

Specific to session beans, the getEJBObject() and getEJBLocalObject() methods

are useful if your bean needs to call another bean and if you want to pass a ref-

erence to your own bean. In Java, an object can obtain a reference to itself with

the this keyword. In EJB, however, a bean cannot use the this keyword and pass

it to other beans because all clients invoke methods on beans indirectly

through a bean’s EJB object. Thus, a bean can refer to itself by using a reference

to its EJB object, rather than the this keyword.

The Count Bean’s Home Interface

To complete our stateful bean code, we must define a home interface. The

home interface details how to create and destroy our Count EJB object. The

code for our home interface is in Source 4.3.

92 Chapter 4

package examples;

import javax.ejb.\*;

import java.rmi.RemoteException;

/\*\*

\* This is the home interface for CountBean. This interface

\* is implemented by the EJB Server’s glue-code tools - the

\* implemented object is called the Home Object, and serves

\* as a factory for EJB Objects.

\*

\* One create() method is in this Home Interface, which

\* corresponds to the ejbCreate() method in the CountBean file.

\*/

public interface CountHome extends EJBHome {

/\*

\* This method creates the EJB Object.

\*

\* @param val Value to initialize counter to

\*

\* @return The newly created EJB Object.

\*/

Count create(int val) throws RemoteException, CreateException;

}

Source 4.3 CountHome.java.

Because we implement javax.ejb.EJBHome, our home interface gets the

remove() destroy method for free.

The Count Bean’s Deployment Descriptor

Now that we have all our Java files for our bean, we need to define the deploy-

ment descriptor to identify the bean’s settings to the container. The deploy-

ment descriptor settings we use are listed in Source 4.4.

<!DOCTYPE ejb-jar PUBLIC

“-//Sun Microsystems, Inc.//DTD Enterprise JavaBeans 2.0//EN”

“http://java.sun.com/dtd/ejb-jar\_2\_0.dtd”>

<ejb-jar>

<enterprise-beans>

<session>

<ejb-name>Count</ejb-name>

<home>examples.CountHome</home>

Source 4.4 ejb-jar.xml. (continued)

Introduction to Session Beans 93

<remote>examples.Count</remote>

<ejb-class>examples.CountBean</ejb-class>

<session-type>Stateful</session-type>

<transaction-type>Container</transaction-type>

</session>

</enterprise-beans>

</ejb-jar>

Source 4.4 (continued)

Note that our bean’s stateful nature is defined declaratively in the deploy-

ment descriptor. We never introduce the notion of a bean being stateful in the

bean code itself. This enables us to easily switch from the stateful to the state-

less paradigm and back.

The Count Bean’s Proprietary Descriptor and Ejb-jar File

To complete our component, we need to write any proprietary files that our

application server may require and package those files and our bean together

into an Ejb-jar file. These steps are similar to our Hello, World! example.

One special setting we will try to make (which is vendor specific) is to force

the container to limit the number of bean instances that it will keep active to

two beans. Note that this may or may not be possible with your particular

application server. We will then create three beans and observe how the con-

tainer passivates instances to service requests.

To save space, in future examples we’ll consider that the proprietary

descriptors, the Ejb-jar file, and the deployment itself are implied steps. If

you’re really curious about how this is achieved, take a look at the source code

accompanying the book.

The Count Bean’s Client Code

Now that our bean is deployed, we can write some Java code to test our beans.

Our client code performs the following steps:

1\. We acquire a JNDI initial context.

2\. We locate the home object using JNDI.

3\. We use the home object to create three different Count EJB objects.

Thus, we are creating three different conversations and are simulating

three different clients.

4\. We limited the number of active bean instances to two beans, so during

the previous step some of the three beans must have been passivated. We

print out a message during the ejbPassivate() callback to illustrate this.

94 Chapter 4

5\. We call count() on each EJB object. This forces the container to activate

the instances, restoring the conversations to memory once again. We

print out a message during the ejbActivate() callback to illustrate this.

6\. Finally, all the EJB objects are removed.

The code appears in Source 4.5.

package examples;

import javax.ejb.\*;

import javax.naming.\*;

import java.util.Properties;

/\*\*

\* This class is a simple example of client code.

\*

\* We create 3 EJB Objects in this example, but we only allow

\* the container to have 2 in memory. This illustrates how

\* beans are passivated to storage.

\*/

public class CountClient {

public static void main(String\[\] args) {

try {

/\*

\* Get System properties for JNDI initialization

\*/

Properties props = System.getProperties();

/\*

\* Get a reference to the Home Object - the

\* factory for EJB Objects

\*/

Context ctx = new InitialContext(props);

CountHome home = (CountHome)

javax.rmi.PortableRemoteObject.narrow(

ctx.lookup(“CountHome”), CountHome.class);

/\*

\* An array to hold 3 Count EJB Objects

\*/

Count count\[\] = new Count\[3\];

int countVal = 0;

/\*

\* Create and count() on each member of array

Source 4.5 CountClient.java. (continued)

Introduction to Session Beans 95

\*/

System.out.println(“Instantiating beans...”);

for (int i=0; i < 3; i++) {

/\*

\* Create an EJB Object and initialize

\* it to the current count value.

\*/

count\[i\] = home.create(countVal);

/\*

\* Add 1 and print

\*/

countVal = count\[i\].count();

System.out.println(countVal);

/\*

\* Sleep for 1/2 second

\*/

Thread.sleep(500);

}

/\*

\* Let’s call count() on each EJB Object to

\* make sure the beans were passivated and

\* activated properly.

\*/

System.out.println(“Calling count() on beans...”);

for (int i=0; i < 3; i++) {

/\*

\* Add 1 and print

\*/

countVal = count\[i\].count();

System.out.println(countVal);

/\*

\* Sleep for 1/2 second

\*/

Thread.sleep(500);

}

/\*

\* Done with EJB Objects, so remove them

\*/

for (int i=0; i < 3; i++) {

count\[i\].remove();

}

Source 4.5 (continued)

96 Chapter 4

} catch (Exception e) {

e.printStackTrace();

}

}

}

Source 4.5 (continued)

Running the Client

To run the client, you need to know the parameters your JNDI service provider

uses. This should also be part of your container’s documentation. See the

book’s accompanying source code for scripts.

Client-Side Output

After running the client, we see the following output:

Instantiating beans...

1

2

3

Calling count() on beans...

2

3

4

We first created three beans and then called count() on each. As expected, the

beans incremented their values by one each during the second pass, so output

is as expected. But were our beans really passivated and activated? Let’s check

the server log.

Server-Side Output

If the container log yields the following results:

ejbCreate()

count()

ejbCreate()

count()

ejbCreate()

ejbPassivate()

count()

ejbPassivate()

ejbActivate()

count()

ejbPassivate()

ejbActivate()

Introduction to Session Beans 97

count()

ejbPassivate()

ejbActivate()

count()

ejbPassivate()

ejbActivate()

ejbRemove()

ejbActivate()

ejbRemove()

ejbRemove()

Then, as you can see from the passivation/activation messages in the log,

the container is indeed passivating and activating beans to conserve system

resources. Because the client-side output is correct, each of our beans’ conver-

sational state was retained properly. However, not all containers enable you to

control their internal bean caching at the granularity of a single bean instance.

If your actual application server product does not trigger passivation with the

small number of beans in this example, you may have to increase the number

of session bean instances to see the effects of activation and passivation.

  

  

give the only code required like teacher said that write the important code not all the things comments so give me the bean code that I would write

client home remote bean descriptor

## Gemini said

Bhai, teacher ekdum sahi bol rahe hain. Exam mein agar tum poora "fluff" (faltu comments aur extra methods) likhne baithoge toh time kam pad jayega.

Examiner ko sirf **Core Structure** aur **Naming Convention** dekhni hoti hai. Maine yahan **Count Bean** ka wahi "Clean Code" taiyar kiya hai jo tumhe answer sheet mein likhna chahiye.

---

### **1\. Remote Interface (`Count.java`)**

*Sabse chota aur simple part.*

Java

```
import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface Count extends EJBObject {
    public int count() throws RemoteException;
}
```

---

### **2\. Home Interface (`CountHome.java`)**

*Yahan `create()` ka logic likhna zaroori hai.*

Java

```
import javax.ejb.EJBHome;
import javax.ejb.CreateException;
import java.rmi.RemoteException;

public interface CountHome extends EJBHome {
    // Ye ejbCreate() se map hota hai
    public Count create(int val) throws RemoteException, CreateException;
}
```

---

### **3\. Bean Class (`CountBean.java`)**

*Teacher ko isme sirf `val` (State) aur callbacks dekhne hain.*

Java

```
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class CountBean implements SessionBean {
    public int val; // Conversational State

    // Business Method
    public int count() {
        return ++val;
    }

    // EJB Lifecycle Methods
    public void ejbCreate(int val) {
        this.val = val;
    }

    public void ejbRemove() {}
    public void ejbActivate() {}
    public void ejbPassivate() {}
    public void setSessionContext(SessionContext ctx) {}
}
```

---

### **4\. Deployment Descriptor (`ejb-jar.xml`)**

*Isme sirf `<session>` ke andar ki mapping important hai.*

XML

```
<ejb-jar>
    <enterprise-beans>
        <session>
            <ejb-name>CountEJB</ejb-name>
            <home>examples.CountHome</home>
            <remote>examples.Count</remote>
            <ejb-class>examples.CountBean</ejb-class>
            <session-type>Stateful</session-type>
            <transaction-type>Container</transaction-type>
        </session>
    </enterprise-beans>
</ejb-jar>
```

---

### **5\. Client Code (`CountClient.java`)**

*Sirf main logic: Lookup aur Create.*

Java

```
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

public class CountClient {
    public static void main(String[] args) throws Exception {
        InitialContext ctx = new InitialContext();
        
        // 1. Lookup Home Object
        Object obj = ctx.lookup("CountHome");
        CountHome home = (CountHome) PortableRemoteObject.narrow(obj, CountHome.class);
        
        // 2. Create EJB Object
        Count myCount = home.create(10); // Start count from 10
        
        // 3. Call Business Method
        System.out.println("Result: " + myCount.count()); // Prints 11
        
        myCount.remove();
    }
}
```

---

### **Exam ke liye Pro-Tips (Short Notes):**

1. **Stateful Nature:** Bean code mein kahin "Stateful" nahi likha, ye **Deployment Descriptor** mein define hota hai.
2. **Conversational State:** `val` variable hi state hai. Jab bean **Passivate** hoti hai, toh container is `val` ko disk pe save kar deta hai.
3. **this keyword:** Bean ke andar kabhi `this` return mat karna (reference ke liye). Hamesha `SessionContext.getEJBObject()` use karna.

Bhai, ye 5 parts tumhare Unit 3/4 ke **Stateful Session Bean** ka complete package hain. Exam mein yehi structure follow karna!

You said

  

When a statement is sent to a database, the container’s installer JDBC driver

parses it, determines the best way to execute the statement based on

statistics that it maintains, and then executes the statement. Parsing and

determining an execution strategy can be computationally expensive. The

good news is that JDBC is smart—when an instance of PreparedStatement is

executed on a connection, it first checks its cache to see whether this

statement has been executed previously; if so, it reuses the previously

prepared version, thus improving performance. For more information, refer

to Billy Newport’s article “How Prepared Statements Greatly Improve

Performance,” posted at www.ejbinfo.com.

AccountException.java

Our custom exception class is AccountException.java, displayed in Source 7.11.

It simply delegates to the parent java.lang.Exception class. It is still useful to

define our own custom exception class, however, so that we can distinguish

between a problem with our bank account component and a problem with

another part of a deployed system.

package examples.bmp;

/\*\*

\* Exceptions thrown by Accounts

\*/

public class AccountException extends Exception {

public AccountException() {

super();

}

public AccountException(Exception e) {

super(e.toString());

}

public AccountException(String s) {

super(s);

}

}

Source 7.11 AccountException.java.

170 Chapter 7

  

Client.java

Our last Java file is a simple test client to exercise our bean’s methods. It is

shown in Source 7.12.

package examples.bmp;

import javax.ejb.\*;

import javax.naming.\*;

import java.rmi.\*;

import javax.rmi.\*;

import java.util.\*;

/\*\*

\* Sample client code that manipulates a Bank Account Entity Bean.

\*/

public class AccountClient {

public static void main(String\[\] args) throws Exception {

Account account = null;

try {

/\*

\* Get a reference to the Account Home Object - the

\* factory for Account EJB Objects

\*/

Context ctx =

new InitialContext(System.getProperties());

Object obj = ctx.lookup(“AccountHome”);

AccountHome home = (AccountHome)

PortableRemoteObject.narrow(

obj, AccountHome.class);

System.err.println(

“Total of all accounts in bank initially = “

\+ home.getTotalBankValue());

/\* Use the factory to create the Account EJB Object \*/

home.create(“123-456-7890”, “John Smith”);

/\* Find an account \*/

Iterator i = home.findByOwnerName(

“John Smith”).iterator();

if (i.hasNext()) {

account =

(Account)javax.rmi.PortableRemoteObject.narrow(

i.next(), Account.class);

Source 7.12 Client.java. (continued)

Writing Bean-Managed Persistent Entity Beans 171

  

}

else {

throw new Exception(“Could not find account”);

}

/\* Call the balance() method, and print it \*/

System.out.println(“Initial Balance = “ +

account.getBalance());

/\* Deposit $100 into the account \*/

account.deposit(100);

/\* Retrieve the resulting balance. \*/

System.out.println(

“After depositing 100, account balance = “

\+ account.getBalance());

System.out.println(

“Total of all accounts in bank now = “

\+ home.getTotalBankValue());

/\* Retrieve the Primary Key from the EJB Object \*/

AccountPK pk = (AccountPK) account.getPrimaryKey();

/\*

\* Release our old EJB Object reference. Now call

\* find() again, this time querying on Account ID

\* (i.e. the Primary Key).

\*/

account = null;

account = home.findByPrimaryKey(pk);

/\* Print out current balance \*/

System.out.println(

“Found account with ID “ + pk + “. Balance = “

\+ account.getBalance());

/\* Try to withdraw $150 \*/

System.out.println(

“Now trying to withdraw $150, which is more “

\+ “than is currently available. This should “

\+ “generate an exception..”);

account.withdraw(150);

}

catch (Exception e) {

System.out.println(“Caught exception!”);

e.printStackTrace();

}

Source 7.12 (continued)

172 Chapter 7

  

finally {

/\*

\* Destroy the Entity permanently

\*/

try {

System.out.println(“Destroying account..”);

if (account != null) {

account.remove();

}

}

catch (Exception e) {

e.printStackTrace();

}

}

}

}

Source 7.12 (continued)

The client code is fairly self-explanatory. We perform some bank account

operations in the try block. We have a finally clause to make sure our bank

account is properly deleted afterward, regardless of any exceptions that may

have been thrown.

The Deployment Descriptor

Now, let’s take a look at our deployment descriptor, shown in Source 7.13.

<?xml version=”1.0” encoding=”UTF-8”?>

<ejb-jar xmlns=”http://java.sun.com/xml/ns/j2ee” version=”2.1”

xmlns:xsi=”http://www.w3.org/2001/XMLSchema-instance”

xsi:schemaLocation=”http://java.sun.com/xml/ns/j2ee

http://java.sun.com/xml/ns/j2ee/ejb-jar\_2\_1.xsd”>

<display-name>AccountJAR</display-name>

<enterprise-beans>

<entity>

<ejb-name>AccountEJB</ejb-name>

<home>examples.bmp.AccountHome</home>

<remote>examples.bmp.Account</remote>

<ejb-class>examples.bmp.AccountBean</ejb-class>

<persistence-type>Bean</persistence-type>

<prim-key-class>examples.bmp.AccountPK</prim-key-class>

<reentrant>false</reentrant>

<resource-ref>

<res-ref-name>jdbc/bmp-account</res-ref-name>

Source 7.13 The Account Bean’s ejb-jar.xml deployment descriptor. (continued)

Writing Bean-Managed Persistent Entity Beans 173

  

<res-type>javax.sql.DataSource</res-type>

<res-auth>Container</res-auth>

<res-sharing-scope>Shareable</res-sharing-scope>

</resource-ref>

</entity>

</enterprise-beans>

<assembly-descriptor>

<container-transaction>

<method>

<ejb-name>AccountEJB</ejb-name>

<method-intf>Remote</method-intf>

<method-name>\*</method-name>

</method>

<method>

<ejb-name>AccountEJB</ejb-name>

<method-intf>Local</method-intf>

<method-name>\*</method-name>

</method>

<trans-attribute>Required</trans-attribute>

</container-transaction>

</assembly-descriptor>

</ejb-jar>

Source 7.13 (continued)

Notice the following features of our deployment descriptor that are differ-

ent from session beans:

■■ The persistence-type element indicates whether we are bean-managed

persistent (set it to “Bean”) or container-managed persistent (set it to

“Container”).

■■ The prim-key-class element specifies our primary key class.

■■ The reentrant element dictates whether our bean can call itself through

another bean. A given bean A is reentrant if bean A calls bean B, which

calls back on bean A. This is a special case of multithreading because it

is really only one path of execution that happens to loop back on itself.

If we would like to support this reentrant behavior, we should set this

setting to True so that the container will allow two threads to run inside

of bean A at once. Since our bean doesn’t call itself through another

bean, we set it to False, which is usually what you’ll want to do to avoid

unintended multithreading issues.

■■ The resource-ref element sets up our JDBC driver and makes it available

at the proper JNDI location (see Chapter 10 for a full description of this

process).

■■ The assembly-descriptor associates transactions with our bean. We will

describe transactions fully in Chapter 12.

174 Chapter 7

  

The Container-Specific Deployment Descriptor

Finally, we have our container-specific deployment descriptor, which config-

ures our bean in ways specific to a particular EJB server. We will not show this

file because we want the code in this book to remain vendor-neutral. Typically,

you would use this proprietary descriptor to associate the home interface,

local home interface, and JDBC driver with JNDI locations. For an example

descriptor, see the book’s accompanying source code.

Setting up the Database

Lastly, we need to create the appropriate database table and columns for our

bank accounts. You can do this through your database’s GUI or command-line

interface. The book’s included source code includes installation scripts that

will do this for you for the J2EE SDK’s database. If you’re using a different

database, you should enter the following SQL Data Definition Language (DDL)

statements in your database’s SQL interface:

drop table accounts;

create table accounts (id varchar(64), ownername varchar(64), balance

numeric(18));

This creates an empty table of bank accounts. The first column is the bank

account ID (the primary key), the second column is the bank account owner’s

name, and the third column is the bank account balance.

Running the Client Program

To run the client program, type a command similar to the following (depend-

ing on what your EJB container’s Java Naming and Directory Interface \[JNDI\]

connection parameters are—see your container’s documentation):

java -Djava.naming.provider.url=corbaloc::localhost:3700/NameService

\-Djava.naming.factory.initial=com.sun.jndi.cosnaming.CNCtxFactory

examples.bmp.AccountClient

The initialization parameters are required by JNDI to find the home object,

as we learned in Chapter 3.

Server-Side Output

When you run the client, you should see something similar to the following

output on the server side. Note that your particular output may vary, because

of variances in EJB container behavior.

Writing Bean-Managed Persistent Entity Beans 175

  

New Bank Account Entity Bean Java Object created by EJB Container.

setEntityContext called.

ejbHomeGetTotalBankValue() called.

ejbCreate() called.

ejbStore() called.

New Bank Account Entity Bean Java Object created by EJB Container.

setEntityContext called.

ejbFindByOwnerName(John Smith) called.

ejbLoad() called.

getBalance() called.

ejbStore() called.

ejbLoad() called.

deposit(100.0) called.

ejbStore() called.

ejbLoad() called.

getBalance() called.

ejbStore() called.

ejbHomeGetTotalBankValue() called.

ejbFindByPrimaryKey(123-456-7890) called.

ejbLoad() called.

getBalance() called.

ejbStore() called.

ejbLoad() called.

withdraw(150.0) called.

ejbStore() called.

ejbLoad() called.

ejbRemove() called.

Notice what’s happening here:

■■ When our client code called create() on the home object, the container

created an entity bean instance. The container first called newInstance()

and setEntityContext() to get the entity bean into the available pool of

entity beans. The container then serviced our client’s home business

method and used the bean in the pool. Then the client called create(),

which caused the container to take the bean out of the pool and call the

bean’s ejbCreate() method, which created some new database data, and

returned control back to the container. Finally, the container associated

the bean instance with a new EJB object and returned that EJB object to

the client.

176 Chapter 7

  

■■ To service our finder method, the container instantiated another entity

bean. The container called newInstance() and then setEntityContext() to

get that new bean instance into the available pool of entity beans. It

then used the bean in the pool to service our finder method. Note that

the bean instance is still in the pool and could service any number of

finder methods.

■■ In addition to the methods that the client calls, our EJB container

inserted a few ejbStore() and ejbLoad() calls to keep the database in

synch.

Client-Side Output

Running the client program yields the following client-side output:

Total of all accounts in bank initially = 1200000.0

Initial Balance = 0.0

After depositing 100, account balance = 100.0

Total of all accounts in bank now = 1200100.0

Found account with ID 123-456-7890. Balance = 100.0

Now trying to withdraw $150, which is more than is currently

available. This should generate an exception..

Caught exception!

examples.AccountException: Your balance is 100.0! You cannot

withdraw 150.0!

Destroying account..

Our table already had $1,200,000 from previous records in the database. We

then created an entity bean, deposited into it, and tried to withdraw more than

we had. The entity bean correctly threw an application-level exception, indi-

cating that our balance had insufficient funds

  

  

this is the same for the this code this is also asked in 12 marks and please shorten this too

- 2 successful queries

## Gemini said

Bhai, jaisa tumne pehle (Session Bean wale example mein) bataya tha, exam ke liye sirf **Core Logic** chahiye, no `try-catch`, no `System.out.println` fluff. Ye 12 marks ka question hai, toh tumhe bas charo files ka zaroori hissa dikhana hai jo Bean-Managed Persistence (BMP) ka architecture samjha sake.

Yahan tumhara **"12-Mark Shortened BMP Account"** code hai.

---

### **1\. Remote Interface (`Account.java`)**

*Business methods jo client use karega.*

Java

```
import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface Account extends EJBObject {
    public void deposit(double amt) throws RemoteException;
    public void withdraw(double amt) throws RemoteException, AccountException;
    public double getBalance() throws RemoteException;
}
```

---

### **2\. Home Interface (`AccountHome.java`)**

*Lifecycle aur Finder methods.*

Java

```
import javax.ejb.EJBHome;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.rmi.RemoteException;

public interface AccountHome extends EJBHome {
    // Creates a new database row
    public Account create(String accountID, String ownerName) throws RemoteException, CreateException;
    
    // Finds an existing database row
    public Account findByPrimaryKey(AccountPK key) throws RemoteException, FinderException;
    
    // Global business method (Runs from pool)
    public double getTotalBankValue() throws RemoteException, AccountException;
}
```

---

### **3\. Primary Key Class (`AccountPK.java`)**

*Database ki primary key ko represent karne wali custom class.*

Java

```
import java.io.Serializable;

public class AccountPK implements Serializable {
    public String accountID;

    public AccountPK() {}
    public AccountPK(String id) {
        this.accountID = id;
    }
}
```

---

### **4\. Deployment Descriptor (`ejb-jar.xml`)**

*Main logic yahan hai ki EJB Container ko batana hai ki ye BMP hai.*

XML

```
<ejb-jar>
    <enterprise-beans>
        <entity>
            <ejb-name>AccountEJB</ejb-name>
            <home>examples.bmp.AccountHome</home>
            <remote>examples.bmp.Account</remote>
            <ejb-class>examples.bmp.AccountBean</ejb-class>
            
            <persistence-type>Bean</persistence-type>
            
            <prim-key-class>examples.bmp.AccountPK</prim-key-class>
            <reentrant>false</reentrant>
            
            <resource-ref>
                <res-ref-name>jdbc/bmp-account</res-ref-name>
                <res-type>javax.sql.DataSource</res-type>
                <res-auth>Container</res-auth>
            </resource-ref>
        </entity>
    </enterprise-beans>
</ejb-jar>
```

---

### **5\. Client Code (`AccountClient.java`)**

*Client code sirf EJB create/find karke business method call karta hai.*

Java

```
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

public class AccountClient {
    public static void main(String[] args) throws Exception {
        InitialContext ctx = new InitialContext();
        
        // 1. Lookup Home Object
        Object obj = ctx.lookup("AccountHome");
        AccountHome home = (AccountHome) PortableRemoteObject.narrow(obj, AccountHome.class);
        
        // 2. Create a new Account (Triggers ejbCreate -> INSERT query)
        Account myAccount = home.create("123-456", "John Smith");
        
        // 3. Call Business Method (Changes RAM state)
        myAccount.deposit(100.0);
        
        // 4. Destroy Account (Triggers ejbRemove -> DELETE query)
        myAccount.remove();
    }
}
```

### **Exam ke liye Quick Revision Points (12 Marks Strategy):**

- Teacher ko `AccountBean` ka pura SQL code likhne ki zarurat nahi hai (wo tumne pehle hi pichle chapter mein short karke dekh liya tha). Is question mein mainly **Interfaces, PK class, aur XML file** par focus hota hai.
- **`<persistence-type>Bean</persistence-type>`** likhna bhoolna mat XML mein, wahi BMP ki identity hai.
- **`AccountPK`** zaroori hai kyunki Entity Beans ka uniqueness database ki primary key par depend karta hai.