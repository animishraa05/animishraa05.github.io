---
title: "You said I don’t know anything about this subject ..."
created: 2026-04-28
description: "Gemini conversation with 76 messages"
tags:
  - "clippings"
---
Bhai, ye Chapter 6 ka concluding part hai aur Entity Beans ke mechanics ka core hai. Isko directly EJB ke flow se map karte hain, specifically focusing on creation, deletion, finding, and context.

Here's a breakdown of the textbook concepts in clear Hinglish.

---

### **1\. Container-Managed Persistence (CMP) vs Bean-Managed Persistence (BMP)**

- **The Core Difference:**
	- **BMP (Bean-Managed Persistence):** Developer (Tum) bean class ke andar khud raw JDBC code (`INSERT INTO Account...`) likhta hai.
		- **CMP (Container-Managed Persistence):** EJB Container (Server) tumhare liye SQL code generate karta hai aur execute karta hai. Tum apni bean se saari persistence logic (SQL queries) hata dete ho aur sirf O/R Mapping tool ko use karte ho.
- **Why CMP?** CMP tumhari bean ka size chota karta hai aur database porting (MySQL se Oracle jaana) aasan karta hai, kyunki SQL server handle kar raha hai, tum nahi.

---

### **2\. Creation and Removal (Figures 6.6 & 6.7)**

Ye samajhna crucial hai ki `ejbCreate()` aur `ejbRemove()` Entity Beans mein kaise alag behave karte hain (compared to Session Beans).

- **The Synchronization Rule:** Entity bean instance (RAM mein object) aur database data (Hard drive pe row) ek hain. Agar memory mein create hua, toh database mein row insert honi chahiye. Agar memory se remove hua, toh database ki row delete honi chahiye.
- **Creating (Figure 6.6):**
	1. Client `home.create("ID1", "Ray")` call karta hai.
		2. Container bean ka `ejbCreate()` call karta hai.
		3. Bean database mein **nayee row insert** karti hai (BMP) ya Container khud karta hai (CMP).
		4. Bean container ko **Primary Key** return karti hai.
		5. Container us key se EJB Object banata hai aur client ko deta hai.
- **Removing (Figure 6.7):**
	1. Client `proxy.remove()` call karta hai.
		2. Container bean ka `ejbRemove()` call karta hai.
		3. Bean database se us row ko **delete (DROP/DELETE)** kar deti hai (BMP) ya Container khud karta hai (CMP).
	- *Exam Note:* Session bean mein `ejbRemove()` ka matlab tha bean ko RAM se hatana. Entity bean mein iska matlab hai data ko database se hamesha ke liye mita dena.

---

### **3\. Finder Methods (The "SELECT" statement of EJB)**

- **The Concept:** Entity Beans ko sirf create nahi kiya jata, purane data ko *dhoondha* bhi jata hai. Ye Session Beans mein nahi hota.
- **How it works:** Home Interface mein `findByPrimaryKey(String id)` jaise methods hote hain. Ye SQL ke `SELECT * FROM table WHERE id = ?` ke barabar hote hain.

---

### **4\. Modifying Data Externally (Figure 6.8)**

- **The Reality:** Har application EJB ke through database touch nahi karti. Kuch purane (legacy) systems direct database query chala kar row update kar sakte hain.
- **The Danger:** Agar ek direct script ne database mein account balance update kar diya, par EJB Server ki RAM (Cache) mein abhi bhi purana balance loaded hai, toh "Cache Inconsistency" (data mismatch) ho jayega. (Ye Chapter 19 ka topic hai, par architecture mein yaad rakhna zaroori hai).

---

### **5\. Entity Context (`EntityContext` Interface)**

Jaise Session Context tha, waise hi Entity Context bean ka server se baat karne ka tareeka hai. Isme do sabse important naye methods aate hain:

1. **`getEJBLocalObject()` / `getEJBObject()`:** Agar bean ko apna hi proxy (bodyguard) kisi aur ko pass karna hai, toh wo `this` keyword use nahi karegi. Wo context se apna EJB Object mangegi aur wo pass karegi.
2. **`getPrimaryKey()` (SUPER IMPORTANT FOR EXAM):**
	- **The Problem:** Entity beans pooled hoti hain. Ek hi memory object kabhi Account ID 1 handle karta hai, kabhi ID 2.
		- **The Solution:** Jab container `ejbLoad()` (data RAM mein laao) ya `ejbRemove()` (data delete karo) call karta hai, toh bean ko kaise pata chalega ki *kaunse* customer ka data load/delete karna hai?
		- Bean `ctx.getPrimaryKey()` call karti hai, jo use batata hai: "Abhi tum Account ID 5 ko represent kar rahi ho, jao 5 number ka data load karo."

---

### **Visualizing the Flow (Mind Map)**

1. **Client:** Mujhe Ray ka account dikhao.
2. **Home Object:** `findByPrimaryKey("Ray123")` call karta hai.
3. **Container:** Pool se ek khaali Entity Bean uthata hai.
4. **Context Action:** Container us bean ka `EntityContext` set karta hai aur usme Primary Key "Ray123" daal deta hai.
5. **Activation:** Container `ejbLoad()` call karta hai. Bean context se "Ray123" padhti hai aur Database se `SELECT` query marke data RAM mein bhar leti hai.
6. **Proxy:** Container client ko EJB Object (Proxy) de deta hai jisse client baat karega.

Bhai, Chapter 6 yahan khatam hota hai. Isne BMP aur CMP ka theoretical ground clear kar diya hai. Ab batao, kya main directly Chapter 7 (Writing BMP Entity Beans) pe jaau, ya isme ORM/Context mein koi deep doubt hai?

You said

getPrimaryKey()

getPrimaryKey()retrieves the primary key that is currently associated with this

entity bean instance. Primary keys uniquely identify an entity bean. When an

entity bean is persisted in storage, the primary key can be used to uniquely

retrieve the entity bean because no two entity bean database data instances can

ever have the same primary key.

Why would you want to call getPrimaryKey()? You call it whenever you

want to figure out with which database data your instance is associated.

Remember that entity bean instances can be reused and pooled, as shown in

Figure 6.4. When the container wants to switch an entity bean instance from

one data instance to another, the container needs to passivate and activate that

138 Chapter 6

entity bean instance. When this happens, your bean instance may switch to a

different data instance and thus a different primary key. But your entity bean

instance is never told this explicitly when it is activated. Rather, your entity

bean must perform a getPrimaryKey() callback to the entity context to figure

out what data it should be dealing with.

Thus, when you have an entity bean that’s performing any persistent work

(with bean-managed persistence), you should be calling getPrimaryKey()

whenever you need to figure out what data your bean is associated with. This

is very useful, for example, in the following methods:

■■ ejbLoad(). Recall that ejbStore() and ejbLoad() are bean callbacks to syn-

chronize a bean instance with an underlying storage. ejbStore() saves

data to storage, and ejbLoad() reads data from storage. When the con-

tainer calls ejbStore(), your bean knows exactly what data to save

because the bean instance has the data in memory. But when the con-

tainer calls ejbLoad(), how does your bean know what data to load?

After all, bean instances are pooled and can be dynamically assigned to

different data. The answer is to use getPrimaryKey(); it will tell you what

primary key you should be looking for in the underlying storage when

loading database data.

■■ ejbRemove(). Recall that ejbCreate() and ejbRemove() are callbacks for cre-

ating and removing data from an underlying storage, respectively.

When the container calls ejbCreate(), your bean knows exactly what data

to create in the database because your bean has received information in

the parameters of ejbCreate(). But when the container calls ejbRemove(),

how does your bean know what data to remove? Because bean

instances are pooled and dynamically assigned to handle different data

instances, you might be deleting the wrong data. Thus, you must call

getPrimaryKey() to figure out what data, keyed on the primary key, your

bean should remove from the database.

It is important to consider bean pooling when writing your enterprise

beans, and getPrimaryKey() is the key to knowing what data your bean is rep-

resentin

## Gemini said

Bhai, ye specific page EJB ke sabse tricky concept—**"The Identity Crisis of Entity Beans"**—ko explain karta hai. Exam mein BMP (Bean-Managed Persistence) par question aaye, toh ye `getPrimaryKey()` ka logic likhna full marks dilaiga.

Isko direct aur simple Hinglish mein samajhte hain:

### **1\. The Problem: Bean ko "Identity Crisis" hota hai**

- **Context:** Session Beans ki tarah, Entity Beans bhi RAM mein **Pooled** (ek group mein) hoti hain.
- **The Issue:** Server RAM bachane ke liye ek hi Entity Bean instance ko reuse karta hai. Abhi ye bean 'Account 101' ka data handle kar rahi thi, 5 minute baad server isse 'Account 505' ka data handle karne ko de dega.
- **The Crisis:** Jab server is bean ko wapas jagata hai (activate karta hai), toh bean ko **khud nahi pata hota** ki wo abhi kis customer ka data represent kar rahi hai!

### **2\. The Solution: `getPrimaryKey()`**

Is identity crisis ka ek hi ilaaj hai: `getPrimaryKey()` method. Bean apne EJB Context (Server) se puchti hai: *"Bhai, meri current identity kya hai?"* Server use ek Primary Key (jaise ID = 505) de deta hai. Isse bean ko pata chal jata hai ki use kis database row par operation perform karna hai.

---

### **3\. Kahan aur Kyun use hota hai? (The Core Logic)**

Book ne do methods ko highlight kiya hai jahan iski sabse zyada zaroorat padti hai. Ise dhyan se samajhna:

#### **Case A: `ejbLoad()` (Database se RAM mein data laana)**

- **Scenario:** Server bean ko bolta hai, "Jaake database se data RAM mein load karo."
- **Confusion:** Bean sochti hai, "Kiska data load karu? Pooled hone ki wajah se mujhe toh pata hi nahi ki main kaun hoon."
- **Action:** Bean `getPrimaryKey()` call karti hai. Use milta hai ID = `505`. Phir wo database mein raw SQL fire karti hai: `SELECT * FROM table WHERE id = 505`. Ab sahi data memory mein aa jata hai.

#### **Case B: `ejbRemove()` (Database se data hamesha ke liye mitana)**

- **Scenario:** Server bean ko bolta hai, "Database se record delete kar do."
- **Confusion:** Bean sochti hai, "Agar maine bina confirm kiye delete SQL chala di, toh galti se kisi aur customer ka data delete ho jayega!" (Kyunki `ejbRemove()` mein koi parameter pass nahi hota).
- **Action:** Bean confirm karne ke liye `getPrimaryKey()` call karti hai. Use ID milti hai. Phir wo SQL chalati hai: `DELETE FROM table WHERE id = 505`.

---

### ** Exam Trick Question:**

- **Q:** *`ejbLoad()` mein `getPrimaryKey()` chahiye, par `ejbStore()` (RAM se Database mein save karna) mein kyun nahi chahiye?*
- **Ans:** Kyunki jab `ejbStore()` call hota hai, toh data pehle se hi RAM (Bean ki memory) mein loaded hota hai. Bean ko apna account number pehle se pata hota hai jo memory mein saved hai, toh usko alag se context se ID mangne ki zaroorat nahi padti.

**In Short:** EJB Pooling ki wajah se server ki RAM bachti hai, par bechari Entity Bean ko apna naam baar-baar `getPrimaryKey()` se yaad karna padta hai jab use database se read (`ejbLoad`) ya delete (`ejbRemove`) karna ho.

Ye Chapter 6 ka aakhiri theory part tha. Ab agla step **Chapter 7 (Writing BMP Entity Beans)** hai, jahan hum in baaton ko actual code (SQL queries ke sath) mein badalte hue dekhenge. Shuru karein Chapter 7?

You said

You call it whenever you

want to figure out with which database data your instance is associated.

Remember that entity bean instances can be reused and pooled, as shown in

Figure 6.4. When the container wants to switch an entity bean instance from

one data instance to another, the container needs to passivate and activate that

138 Chapter 6

entity bean instance. When this happens, your bean instance may switch to a

different data instance and thus a different primary key. But your entity bean

instance is never told this explicitly when it is activated. Rather, your entity

bean must perform a getPrimaryKey() callback to the entity context to figure

out what data it should be dealing with

## Gemini said

Ani bhai, lagta hai tumne galti se wahi paragraph dobara paste kar diya!  Maine just pichle message mein is "Identity Crisis" wale logic ko detail mein explain kiya tha.

Ekdum short mein wapas yaad dila deta hoon: Kyunki server RAM bachane ke liye ek hi Entity Bean ko alag-alag customers ke liye reuse (pool) karta hai, bean ko khud nahi pata hota ki wo currently kisko represent kar rahi hai. Isliye jab bhi usko database se data load ya delete karna hota hai, wo `getPrimaryKey()` call karke apni current identity (jaise Account ID) confirm karti hai taaki kisi galat customer ka data delete na ho jaye.

Agar is specific paragraph ki kisi line mein abhi bhi doubt hai toh pooch lo, warna hum seedha **Chapter 7 (Writing BMP Entity Beans)** par attack karein?

You said

no i need exact meaning o f this You call it whenever you

want to figure out with which database data your instance is associated.

Remember that entity bean instances can be reused and pooled, as shown in

Figure 6.4. When the container wants to switch an entity bean instance from

one data instance to another, the container needs to passivate and activate that

138 Chapter 6

entity bean instance. When this happens, your bean instance may switch to a

different data instance and thus a different primary key. But your entity bean

instance is never told this explicitly when it is activated. Rather, your entity

bean must perform a getPrimaryKey() callback to the entity context to figure

out what data it should be dealing with

## Gemini said

Bhai, main samajh gaya. Tumhe is exact paragraph ka word-to-word literal meaning aur logic chahiye, bina kisi analogy ya ghuma-phira ke.

Chalo is paragraph ki ek-ek line ko break karte hain aur uska exact meaning nikalte hain:

---

**Line 1:** *"You call it whenever you want to figure out with which database data your instance is associated."*

- **Exact Meaning:** Bean ke andar `getPrimaryKey()` method tab chalaya jata hai jab Bean ko ye pata karna hota hai ki wo database ki kis row (record) ke liye kaam kar rahi hai.

**Line 2:** *"Remember that entity bean instances can be reused and pooled, as shown in Figure 6.4."*

- **Exact Meaning:** EJB Container (Server) har naye database record ke liye naya Java object (bean instance) nahi banata. Wo objects ka ek group (pool) banata hai aur unhi objects ko alag-alag data ke liye baar-baar reuse karta hai.

**Line 3:** *"When the container wants to switch an entity bean instance from one data instance to another, the container needs to passivate and activate that entity bean instance."*

- **Exact Meaning:** Jab container ek object ko Record A (data instance 1) se hata kar Record B (data instance 2) par lagana chahta hai, toh wo pehle us object ko inactive (passivate) karta hai aur fir naye record ke liye active (activate) karta hai.

**Line 4:** *"When this happens, your bean instance may switch to a different data instance and thus a different primary key."*

- **Exact Meaning:** Is switching ke dauran, tumhara wahi same in-memory object ab ek naye database record ko point karne lagta hai. Matlab uski Primary Key change ho chuki hoti hai (Pehle ID 10 tha, ab ID 20 ho gaya).

**Line 5 (The most important line):** *"But your entity bean instance is never told this explicitly when it is activated."*

- **Exact Meaning:** Jab object naye record ke liye activate (wake up) hota hai, toh Container aakar us object ko seedhe-seedhe (explicitly) nahi batata ki *"Lo tumhara naya ID 20 hai"*. Usko koi direct parameter pass nahi hota.

**Line 6:** *"Rather, your entity bean must perform a getPrimaryKey() callback to the entity context to figure out what data it should be dealing with."*

- **Exact Meaning:** Kyunki container ne khud nahi bataya, isliye ab Entity Bean ki khud ki zimmedari hai ki wo apne **Entity Context** (apne environment) ko call kare (`getPrimaryKey()`) aur pooche: *"Mera current ID kya hai taaki main sahi data fetch/delete kar saku?"*

---

### **In Short (The Exact Core Logic):**

Kyunki ek hi Java object alag-alag data records ke beech switch (reuse) ho raha hai, aur EJB Server switch karte waqt us object ko uska naya naam/ID bata kar nahi bhejta. Isliye us Java object ko code ke through `getPrimaryKey()` chala kar khud apna naya ID context se nikalna padta hai.

Ab ye ekdum strictly book-to-brain clear hua?

You said

141

In this chapter, we’ll demonstrate how to program bean-managed persistent

entity beans, the first of two flavors of entity beans. When you code these types

of entity beans, you must provide your own data access logic. You are respon-

sible for providing the implementation to map your entity bean instances to

and from storage. To do this, you typically use a database API, such as JDBC,

or an O/R mapping framework, such as TopLink or Hibernate. This contrasts

with container-managed persistent entity beans, which have their data access

handled for them by the EJB container. Bean-managed persistence is typically

used only when the container-managed persistence (CMP) provided by your

application server and database does not deliver satisfactory performance. In

this case, you may need to exercise tight control over each and every data

access for improving the performance of your entity beans. For more details on

performance issues please refer to Chapters 16 and 18.

This chapter explains the basics of bean-managed persistence (BMP) and

shows you how to build a simple bean-managed entity bean using JDBC.

Entity Bean Coding Basics

To write an entity bean class, you write a Java class that implements the

javax.ejb.EntityBean interface. This interface defines a number of required

methods that your entity bean class must implement. Most of these methods

are management methods called by your EJB container. The following code

(Source 7.1 and Source 7.2) details javax.ejb.EntityBean, as well as its parent,

javax.ejb.EnterpriseBean (exceptions are omitted).

The javax.ejb.EnterpriseBean interface defines no methods—it is simply a

marker interface. The javax.ejb.EntityBean interface defines callback methods

that your bean must implement. The container will call these methods when-

ever it wishes.

public interface javax.ejb.EnterpriseBean

implements java.io.Serializable {

}

Source 7.1 The javax.ejb.EnterpriseBean interface.

public interface javax.ejb.EntityBean

extends javax.ejb.EnterpriseBean {

public void setEntityContext(javax.ejb.EntityContext);

public void unsetEntityContext();

public void ejbRemove();

public void ejbActivate();

public void ejbPassivate();

public void ejbLoad();

public void ejbStore();

}

Source 7.2 The javax.ejb.EntityBean interface.

142 Chapter 7

JAVA DATABASE CONNECTIVITY

This chapter uses Java Database Connectivity (JDBC). JDBC is a standard Java

extension that enables Java programmers to access relational databases. By

using JDBC, Java programmers can represent database connections, issue SQL

statements, process database results, and more in a relatively portable way.

Clients program to the unified JDBC API, which is implemented by a JDBC Driver,

an adapter that knows how to talk to a particular database in a proprietary way

(see Figure 7.1). JDBC is similar to the Open Database Connectivity (ODBC)

standard, and the two are quite interoperable through JDBC-ODBC bridges. JDBC

contains built-in support for database connection pooling, further enhancing the

database independence of your application code.

  

All entity bean classes, both bean-managed persistent and container-man-

aged persistent, must implement the javax.ejb.EntityBean interface. This inter-

face defines callback methods that the container invokes on your beans. There

are additional methods you also may define, such as methods to create and

find your entity beans.

Finding Existing Entity Beans: Finder Methods

As shown in Table 7.1, we have methods labeled ejbFind(). These finder meth-

ods are defined on the local and remote home interfaces and implemented by

your bean implementations to find an existing entity bean in storage. Finder

methods do not create new database data—they simply load old entity bean

data.

Figure 7.1 Java Database Connectivity.

Client

JDBC Driver

JDBC API

Relational Database(s)

Writing Bean-Managed Persistent Entity Beans 143

  

144 Chapter 7

Table 7.1 Descriptions and Implementation Guidelines for Bean-Managed Persistent Entities

TYPICAL

IMPLEMENTATION METHOD EXPLANATION

setEntityContext() Stick the entity context If the container wants to

somewhere, such as in a increase its pool size of bean

member variable. You can instances, it will instantiate a

access the context later new entity bean instance.

to acquire environment Next, the container calls the

information, such as instance’s setEntityContext()

security information, from method. Once this method is

the container. You should called, the bean can access

also request any resources information about its

you will need regardless environment.

of what data the bean

manages. The bean is now in a pool,

does not have any specific

database data inside of it,

and is not bound to any

particular EJB object.

ejbFind<...>(<...>) While your bean instance Search through a data store

is still in the pool, the using a storage API such as

container can use your JDBC or SQL/J. For example,

bean to service a finder you might perform relational

method. Finder methods query such as “SELECT id

locate one or more FROMaccounts WHERE

existing entity bean balance > 0.”

data instances in the

underlying persistent store. When you’ve found some

You must define a least data, return the primary keys

one finder method— for that data back to the

ejbFindByPrimaryKey(). container by creating one or

more primary key Java object

instances. The container will

then create EJB objects for

the client to invoke on and

possibly associate some

entity bean instances with

those EJB objects.

Those entity bean instances

are no longer in the pool—

they now have specific

database data inside of them,

and they are bound to

particular EJB objects.

  

Writing Bean-Managed Persistent Entity Beans 145

Table 7.1 (continued)

TYPICAL

IMPLEMENTATION METHOD EXPLANATION

ejbHome<...>(<...>) Sometimes you need Perform your global

methods on an entity operations, such as counting

bean that are not specific the rows in a database using

to any given data instance JDBC, and return the result to

(or row). For example, the client.

counting the total number

of accounts in a table.

You can write home

methods to perform these

operations. The home

methods are special

business methods

because they are called

from a bean in the pool,

before the bean is

associated with any

specific data. Clients call

home methods from

the home interface or

local home interface.

ejbCreate(<...>) When a client calls the Make sure the client’s

create() method on a initialization parameters are

Note: You do not need home object, the container valid. Explicitly create the

to write any ejbCreate() calls ejbCreate() on a database representation of

methods if you don’t pooled bean instance. the data through a storage

want EJB clients to be ejbCreate() methods are API like JDBC or SQL/J,

able to create new responsible for creating typically through a SQL

database data. Instead, new database data and INSERT. Then return a primary

you could mandate for initializing your bean. key to the container, so that

that all data is created Each ejbCreate() method the container can identify

through other means, you define gives clients a which data your instance

such as through direct different way to create represents.

database inserts or your entity beans, such as

batch files. methods to create a Your entity bean instance is

checking account and a no longer in the pool—it now

savings account. has specific database data

inside of it. The container will

bind your instance to a

particular EJB objects.

(continued)

  

Table 7.1 (continued)

TYPICAL

IMPLEMENTATION METHOD EXPLANATION

ejbPostCreate(<...>) Your bean class must The container calls

define one ejbPostCreate() ejbPostCreate() after it has

for each ejbCreate(). associated your bean instance

Each pair must accept the with an EJB object. You can

same parameters. now complete your

The container calls initialization by doing

ejbPostCreate() right anything you need to that

after ejbCreate(). requires that EJB object, such

as passing your bean’s EJB

object reference to other

beans.

You might also use this

method to reset certain

transaction-related

parameters. For example, you

could keep a data status flag

in the bean to indicate

whether a field has been

changed. Because the bean

instance may have been used

before, these fields might

have dirty data.

ejbActivate() When a client calls a Acquire any resources, such

business method on an as socket connections, that

EJB object, but no entity your bean needs to service a

bean instance is bound particular client when it is

to the EJB object, the moved into the ready state.

container needs to take

a bean from the pool and Note that you should not read

transition it into a ready the entity bean data from the

state. This is called database in this method. That

activation. Upon activation, is handled by a separate

the ejbActivate() method is method, ejbLoad(), which is

called by the EJB container. called right after ejbActivate().

ejbLoad() The EJB container calls First, your bean instance must

this method to load figure out what data it should

database data into your load. Call the getPrimaryKey()

bean instance (typically a method on the entity context;

SQL SELECT), based on that will tell your bean what

the current transactional data it should be loading.

state. Next, read database data into

your bean using a storage API

such as JDBC or SQL/J.

146 Chapter 7

  

Table 7.1 (continued)

TYPICAL

IMPLEMENTATION METHOD EXPLANATION

ejbStore() The EJB container calls Explicitly update the database

this method to update the representation of the data via

database to the new a storage API like JDBC.

values of your in-memory Typically, you’ll write a

fields, thus synchronizing number of your member

the database. The current variable fields out to disk

transactional state dictates through a SQL UPDATE.

when this method is called.

This method is also called

during passivation, directly

before ejbPassivate().

bPassivate() The EJB container calls Release any resources, such

this method when it as socket connections, that

wants to return your you allocated in ejbActivate()

entity bean to the pool. and that bean was holding

This is called passivation during the ready state for a

and is the opposite of particular client.

activation. On passivation,

the ejbPassivate() method You should not save the

is called by the EJB entity bean data into the

container. database in this method. That

is handled by a separate

method, ejbStore(), which is

called right before

ejbPassivate().

ejbRemove() Destroys database data. First, figure out what data you

It is not used to destroy should destroy using the

the Java object; the object getPrimaryKey() method on

can be pooled and reused the EntityContext field. Then

for different data. explicitly delete the database

representation of the data

using a storage API like JDBC,

typically through a SQL

DELETE.

unsetEntityContext() This method disassociates Release any resources you

a bean from its allocated during

environment. The setEntityContext(), and get

container calls this right ready to be garbage collected.

before your entity bean

instance is destroyed

when it wants to reduce

the pool size.

Writing Bean-Managed Persistent Entity Beans 147

  

You define finder methods only when you use bean-managed persistence.

With container-managed persistence (CMP), these method implementations

are generated for you.

As with ejbCreate(), clients do not invoke your finder methods on the bean

instance itself. A finder method is just like any other method on your entity

bean class—clients never directly call any of your bean’s methods. Rather,

clients invoke finder methods on home objects, implemented by the EJB con-

tainer, that delegate to your bean. Therefore, for each finder method you

define in your bean class, you should define a corresponding finder in the local

home interface. Clients call your local home object’s finder methods, which

delegate to your bean’s finders.

For example, given the following finder method in the local home interface:

public AccountLocal findBigAccounts(int minimum) throws FinderException;

here is the finder implementation in your bean class (notice the ejb prefix):

public AccountPK ejbFindBigAccounts(int minimum)

throws FinderException { ... }

As with ejbCreate(), the home signature and the bean class signature have a

couple of differences:

■■ The entity bean instance returns a primary key to the container,

whereas the home object returns an EJB object to the client.

■■ The bean class signature is the same as the home signature, except for

an extra, mandatory ejb prefix and that the first letter in the word Find

is capitalized.

These signature differences between the home and bean are valid because

the bean does not implement the local home interface. Rather, the local home

object delegates to the bean, so strict signature matching is not needed.

You can have many different finder methods, all of which perform different

operations. Here are some examples of finder methods in an entity bean class:

/\*\*

\* Finds the unique bank account indexed by primary key

\*/

public AccountPK ejbFindByPrimaryKey(AccountPK key)

throws FinderException { ... }

/\*\*

\* Finds all the product entity beans. Returns a Collection

\* of primary keys.

148 Chapter 7

  

\*/

public Collection ejbFindAllProducts()

throws FinderException { ... }

/\*\*

\* Finds all Bank Accounts that have at least a minimum balance.

\* Returns a Collection of primary keys.

\*/

public Collection ejbFindBigAccounts(int minimum)

throws FinderException { ... }

/\*\*

\* Finds the most recently placed order

\*/

public OrderPK ejbFindMostRecentOrder()

throws FinderException { ... }

Another interesting aspect of finders is that they can return collections. Your

database search may turn up more than one result and therefore more than one

entity bean. Here is the local home interface signature:

public Collection findAllProducts() throws FinderException;

And here is the bean implementation signature:

public Collection ejbFindAllProducts()

throws FinderException { ... }

The finder process works as follows:

■■ When the client invokes the home object’s finder, the home object asks a

bean to find all primary keys matching the client’s criteria. The bean

then returns a collection of those primary keys to the container.

■■ When the container receives the collection of keys from the entity bean

instance, it creates a collection of EJB objects, one for each primary key,

and returns those EJB objects in its own collection to the client. The

client can then invoke methods on the EJB objects: Each EJB object rep-

resents its own instance of data within the entity bean’s database stor-

age.

In summary, here are some of the rules about finder methods:

■■ All finder methods must begin with ejbFind. This is simply a syntactic

rule.

■■ You must have at least one finder method, called ejbFindByPrimaryKey.

This method finds one unique entity bean instance in the database

Writing Bean-Managed Persistent Entity Beans 149

  

based on its unique primary key. Because every entity bean has an asso-

ciated primary key, it makes sense that every entity bean class supports

this method.

■■ You can have many different finder methods, each with different names

and different parameters. This allows you to find using different

semantics, as illustrated by the examples above.

■■ A finder method must return either the primary key for the entity bean

it finds or a collection of primary keys if it finds more than one. Because

you could find more than one data instance in the database, finder

methods can return collections of primary keys

  

this one is a important chapter and I want to make sure I understand all the codes in this chapter and also learn them as they come in exams

## Gemini said

Bhai, ye Chapter 7 EJB ka sabse practical aur coding-heavy hissa hai. **Bean-Managed Persistence (BMP)** mein developer ko apna SQL aur JDBC code khud likhna padta hai. Isliye isme code ki details samajhna exam point of view se bahut zaroori hai.

Pehle is book ka Table 7.1 aur Finder methods ka concept ekdum deep aur simple Hinglish mein decode karte hain, kyunki ye interviews aur exams dono mein poochha jata hai.

---

### **1\. The Two Interfaces of an Entity Bean**

Entity bean ka class likhne se pehle tumhe EJB ki base interfaces samajhni hongi:

- **`javax.ejb.EnterpriseBean`:** Ye ek "Marker Interface" hai. Isme koi method nahi hota. Ye bas Java ko batata hai ki ye ek special EJB object hai.
- **`javax.ejb.EntityBean`:** Ye interface EJB Container ko hooks (callbacks) deti hai. Isme 7 required methods hote hain jo tumhari bean class ko implement (override) karne hi padte hain: `setEntityContext`, `unsetEntityContext`, `ejbRemove`, `ejbActivate`, `ejbPassivate`, `ejbLoad`, `ejbStore`.

---

### **2\. The 10 Callbacks of BMP (Table 7.1 Decoded)**

Ye table exam ke liye "Sanjeevani Booti" hai. Isme likha har method container call karta hai, aur tumhe unke andar kya SQL likhna hai, ye pata hona chahiye.

1. **`setEntityContext()`:**
	- **Kab:** Jab naya object banta hai (Pool mein aane se pehle).
		- **Kya likhna hai:** Container ne context diya hai, usko ek global variable mein save kar lo (`this.ctx = ctx;`).
2. **`ejbFind...()` (The SELECT queries):**
	- **Kab:** Jab data dhoondna ho.
		- **Kya likhna hai:** Raw JDBC likho (e.g., `SELECT id FROM table`). Aur jo `id` (Primary Key) mile, wo return kar do. Ye method pool mein baithe-baithe chalta hai.
3. **`ejbHome...()`:**
	- **Kab:** Aise operations jo kisi ek customer se jude na hon (e.g., total accounts kitne hain).
		- **Kya likhna hai:** Global SQL query likho (e.g., `SELECT COUNT(*) FROM table`).
4. **`ejbCreate()` (The INSERT query):**
	- **Kab:** Jab naya record banana ho.
		- **Kya likhna hai:** Client ne jo data diya hai (Name, Balance), uska `INSERT INTO table` fire karo. Aur phir uski Primary Key return karo.
5. **`ejbPostCreate()`:**
	- **Kab:** `ejbCreate()` ke turant baad.
		- **Kya likhna hai:** Yahan naya EJB Object ban chuka hota hai. Agar tumhe kisi doosre bean ko apna reference (EJB Object) pass karna hai, toh wo yahan karte hain. (Har `ejbCreate` ka ek corresponding `ejbPostCreate` likhna zaroori hai).
6. **`ejbActivate()`:**
	- **Kab:** Jab bean ko pool se utha kar 'Ready' state mein laya jata hai.
		- **Kya likhna hai:** Network sockets ya file streams open karne ka code. **Alert:** Yahan Database se data read nahi karna hai!
7. **`ejbLoad()` (The DATA FETCH):**
	- **Kab:** `ejbActivate` ke baad, ya transaction ke shuru mein.
		- **Kya likhna hai:** Pehle context se ID mango: `ctx.getPrimaryKey()`. Phir SQL chalao: `SELECT * FROM table WHERE id=?`. Phir database ki values ko Java variables mein set kar do (`this.balance = rs.getDouble("balance");`).
8. **`ejbStore()` (The DATA SAVE):**
	- **Kab:** Transaction ke end mein ya passivation se pehle.
		- **Kya likhna hai:** Java variables ka data wapas database mein update karo: `UPDATE table SET balance=? WHERE id=?`.
9. **`ejbPassivate()`:**
	- **Kab:** Jab bean wapas pool mein jaati hai (Sleep state).
		- **Kya likhna hai:** Jo network sockets `ejbActivate` mein khole the, wo band kar do. **Alert:** Yahan `UPDATE` query nahi chalegi, wo `ejbStore` mein chalti hai.
10. **`ejbRemove()` (The DELETE query):**
	- **Kab:** Jab client record delete karne ko bole.
		- **Kya likhna hai:** Context se ID mango, aur raw SQL fire karo: `DELETE FROM table WHERE id=?`.

---

### **3\. The Finder Methods in Depth**

BMP mein, data dhoondne ka logic (Finder methods) tumhe khud likhna padta hai. CMP mein container khud SQL bana leta hai.

**The Naming Rule (Exam Question):**

- **Home Interface** mein naam hoga: `findBigAccounts(int minimum)`
- **Bean Class** mein naam hoga: `ejbFindBigAccounts(int minimum)`

**The Return Type Rule (Super Important):**

- **Home Interface** client ko `Account` (EJB Object) ya Collection of `Account` return karta hai.
- **Bean Class** container ko `AccountPK` (Primary Key) ya Collection of `AccountPK` return karti hai.
- *Logic:* Bean ka kaam sirf ID dhoondna hai. Container us ID ko pakadta hai, naya EJB Object (Proxy) banata hai, us EJB object mein ID dalta hai, aur client ko wo EJB Object de deta hai.

**Types of Finders:**

1. **`ejbFindByPrimaryKey(AccountPK key)`:** Ye method **COMPULSORY** hai. Har BMP Entity Bean mein ye hona hi chahiye. Ye hamesha single key return karta hai.
2. **Custom Finders:** Tum jitne chaho utne bana sakte ho.
	- `ejbFindAllProducts()` 
		$$
		→
		$$
		 Returns `Collection` (of multiple keys).
		- `ejbFindBigAccounts(int min)` 
		$$
		→
		$$
		 Returns `Collection`.

---

**Summary for the code ahead:** Ab jo actual code (e.g., `Account.java`, `AccountBean.java`) aayega, usme tumhe bas yahi dekhna hai ki in methods ke andar JDBC ka code kaise fit kiya gaya hai. Database connection kaise open hua aur `ResultSet` kaise read kiya gaya.

Batao, `ejbLoad()` vs `ejbStore()` ka flow clear hai? Hum seedha Bank Account ke example code par move karein?

You said

  

}

// Getter/setter methods on Entity Bean fields

public double getBalance() {

System.out.println(“getBalance() called.”);

return balance;

}

public void setOwnerName(String name) {

System.out.println(“setOwnerName() called.”);

ownerName = name;

}

public String getOwnerName() {

System.out.println(“getOwnerName() called.”);

return ownerName;

}

public String getAccountID() {

System.out.println(“getAccountID() called.”);

return accountID;

}

public void setAccountID(String id) {

System.out.println(“setAccountID() called.”);

this.accountID = id;

}

/\*\*

\* This home business method is independent of any

\* particular account instance. It returns the total

\* of all the bank accounts in the bank.

\*/

public double ejbHomeGetTotalBankValue() throws AccountException {

PreparedStatement pstmt = null;

Connection conn = null;

try {

System.out.println(“ejbHomeGetTotalBankValue()”);

/\* Acquire DB connection \*/

conn = getConnection();

/\* Get the total of all accounts \*/

pstmt = conn.prepareStatement(

“select sum(balance) as total from accounts”);

Source 7.9 (continued)

160 Chapter 7

  

ResultSet rs = pstmt.executeQuery();

/\* Return the sum \*/

if (rs.next()) {

return rs.getDouble(“total”);

}

}

catch (Exception e) {

e.printStackTrace();

throw new AccountException(e);

}

finally {

/\*

\* Release DB Connection for other beans

\*/

try { if (pstmt != null) pstmt.close(); }

catch (Exception e) { }

try { if (conn != null) conn.close(); }

catch (Exception e) { }

}

throw new AccountException(“Error!”);

}

/\*\*

\* Gets JDBC connection from the connection pool.

\*

\* @return The JDBC connection

\*/

public Connection getConnection() throws Exception {

try {

Context ctx = new InitialContext();

javax.sql.DataSource ds =

(javax.sql.DataSource)ctx.lookup(“java:comp/env/jdbc/ejbPool”);

return ds.getConnection();

}

catch (Exception e) {

System.err.println(“Couldn’t get datasource!”);

e.printStackTrace();

throw e;

}

}

}

Source 7.9 (continued)

Our withdraw and deposit methods simply modify the in-memory fields of

the entity bean instance. If the client tries to withdraw more money than is

Writing Bean-Managed Persistent Entity Beans 161

  

available in the account, we throw our custom application-level exception,

AccountException.

The ejbHomeGetTotalBankValue() business method implementation adds the

total of all bank account balances in the database. It retrieves a JDBC connec-

tion using the getConnection() helper method. In that getConnection() method

we look up the database connection using JNDI (see Chapter 10 for a full

description of this process).

Notice, too, that we close each connection after every method call. This

allows our EJB container to pool JDBC connections. When the connection is

not in use, another bean can use our connection. This is the standard, portable

way for connection pooling. The connection pooling is built into the JDBC 2.0

specification and happens automatically behind the scenes.

The final part of our bean demonstrates the various EJB callback methods,

shown in Source 7.10.

... continued ...

//

// EJB-required methods

//

/\*\*

\* Called by Container. Implementation can acquire

\* needed resources.

\*/

public void ejbActivate() {

System.out.println(“ejbActivate() called.”);

}

/\*\*

\* Removes entity bean data from the database.

\* Corresponds to when client calls home.remove().

\*/

public void ejbRemove() throws RemoveException {

System.out.println(“ejbRemove() called.”);

/\*

\* Remember that an entity bean class can be used to

\* represent different data instances. So how does

\* this method know which instance in the database

\* to delete?

\*

\* The answer is to query the container by calling

\* the entity context object. By retrieving the

\* primary key from the entity context, we know

\* which data instance, keyed by the PK, that we

\* should delete from the DB.

Source 7.10 AccountBean.java (Part 3 of 3).

162 Chapter 7

  

\*/

AccountPK pk = (AccountPK) ctx.getPrimaryKey();

String id = pk.accountID;

PreparedStatement pstmt = null;

Connection conn = null;

try {

/\*

\* 1) Acquire a new JDBC Connection

\*/

conn = getConnection();

/\*

\* 2) Remove account from the DB

\*/

pstmt = conn.prepareStatement(

“delete from accounts where id = ?”);

pstmt.setString(1, id);

/\*

\* 3) Throw a system-level exception if something

\* bad happened.

\*/

if (pstmt.executeUpdate() == 0) {

throw new RemoveException(

“Account “ + pk +

“ failed to be removed from the database”);

}

}

catch (Exception ex) {

throw new EJBException(ex.toString());

}

finally {

/\*

\* 4) Release the DB Connection

\*/

try { if (pstmt != null) pstmt.close(); }

catch (Exception e) { }

try { if (conn != null) conn.close(); }

catch (Exception e) { }

}

}

/\*\*

\* Called by Container. Releases held resources for

\* passivation.

\*/

public void ejbPassivate() {

System.out.println(“ejbPassivate () called.”);

Source 7.10 (continued)

Writing Bean-Managed Persistent Entity Beans 163

  

}

/\*\*

\* Called by the container. Updates the in-memory entity

\* bean object to reflect the current value stored in

\* the database.

\*/

public void ejbLoad() {

System.out.println(“ejbLoad() called.”);

/\*

\* Again, query the Entity Context to get the current

\* Primary Key, so we know which instance to load.

\*/

AccountPK pk = (AccountPK) ctx.getPrimaryKey();

String id = pk.accountID;

PreparedStatement pstmt = null;

Connection conn = null;

try {

/\*

\* 1) Acquire a new DB Connection

\*/

conn = getConnection();

/\*

\* 2) Get account from the DB, querying

\* by account ID

\*/

pstmt = conn.prepareStatement(

“select ownerName, balance from accounts “

\+ “where id = ?”);

pstmt.setString(1, id);

ResultSet rs = pstmt.executeQuery();

rs.next();

ownerName = rs.getString(“ownerName”);

balance = rs.getDouble(“balance”);

}

catch (Exception ex) {

throw new EJBException(

“Account “ + pk

\+ “ failed to load from database”, ex);

}

finally {

/\*

\* 3) Release the DB Connection

\*/

try { if (pstmt != null) pstmt.close(); }

catch (Exception e) { }

Source 7.10 (continued)

164 Chapter 7

  

try { if (conn != null) conn.close(); }

catch (Exception e) { }

}

}

/\*\*

\* Called from the Container. Updates the database

\* to reflect the current values of this in-memory

\* entity bean instance.

\*/

public void ejbStore() {

System.out.println(“ejbStore() called.”);

PreparedStatement pstmt = null;

Connection conn = null;

try {

/\*

\* 1) Acquire a new DB Connection

\*/

conn = getConnection();

/\*

\* 2) Store account in DB

\*/

pstmt = conn.prepareStatement(

“update accounts set ownerName = ?, balance = ?”

\+ “ where id = ?”);

pstmt.setString(1, ownerName);

pstmt.setDouble(2, balance);

pstmt.setString(3, accountID);

pstmt.executeUpdate();

}

catch (Exception ex) {

throw new EJBException(“Account “ + accountID +

“ failed to save to

database”, ex);

}

finally {

/\*

\* 3) Release the DB Connection

\*/

try { if (pstmt != null) pstmt.close(); }

catch (Exception e) { }

try { if (conn != null) conn.close(); }

catch (Exception e) { }

}

Source 7.10 (continued)

Writing Bean-Managed Persistent Entity Beans 165

  

}

/\*\*

\* Called by the container. Associates this bean

\* instance with a particular context. We can query

\* the bean properties that customize the bean here.

\*/

public void setEntityContext(EntityContext ctx) {

System.out.println(“setEntityContext called”);

this.ctx = ctx;

}

/\*\*

\* Called by Container. Disassociates this bean

\* instance with a particular context environment.

\*/

public void unsetEntityContext() {

System.out.println(“unsetEntityContext called”);

this.ctx = null;

}

/\*\*

\* Called after ejbCreate(). Now, the Bean can retrieve

\* its EJBObject from its context, and pass it as

\* a ‘this’ argument.

\*/

public void ejbPostCreate(String accountID, String ownerName) {

}

/\*\*

\* This is the initialization method that corresponds to the

\* create() method in the Home Interface.

\*

\* When the client calls the Home Object’s create() method,

\* the Home Object then calls this ejbCreate() method.

\*

\* @return The primary key for this account

\*/

public AccountPK ejbCreate(String accountID, String ownerName)

throws CreateException {

PreparedStatement pstmt = null;

Connection conn = null;

try {

System.out.println(“ejbCreate() called.”);

this.accountID = accountID;

this.ownerName = ownerName;

this.balance = 0;

Source 7.10 (continued)

166 Chapter 7

  

/\*

\* Acquire DB connection

\*/

conn = getConnection();

/\*

\* Insert the account into the database

\*/

pstmt = conn.prepareStatement(

“insert into accounts (id, ownerName, balance)”

\+ “ values (?, ?, ?)”);

pstmt.setString(1, accountID);

pstmt.setString(2, ownerName);

pstmt.setDouble(3, balance);

pstmt.executeUpdate();

/\*

\* Generate the Primary Key and return it

\*/

return new AccountPK(accountID);

}

catch (Exception e) {

throw new CreateException(e.toString());

}

finally {

/\*

\* Release DB Connection for other beans

\*/

try { if (pstmt != null) pstmt.close(); }

catch (Exception e) { }

try { if (conn != null) conn.close(); }

catch (Exception e) { }

}

}

/\*\*

\* Finds a Account by its primary Key

\*/

public AccountPK ejbFindByPrimaryKey(AccountPK key)

throws FinderException {

PreparedStatement pstmt = null;

Connection conn = null;

try {

System.out.println(“ejbFindByPrimaryKey(“

\+ key + “) called”);

/\*

\* Acquire DB connection

\*/

Source 7.10 (continued)

Writing Bean-Managed Persistent Entity Beans 167

  

conn = getConnect

  

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

cating that our balance had insufficient funds.

Putting It All Together: Walking through

a BMP Entity Bean’s Life Cycle

Let’s wrap up this chapter by examining the big picture and understanding

exactly how a container interacts with a BMP entity bean. The state machine

diagram in Figure 7.3 illustrates the life cycle of a BMP entity bean.

Writing Bean-Managed Persistent Entity Beans 177

  

Figure 7.3 The BMP entity bean life cycle.

Here is what’s going on in this diagram:

1\. The does not exist state represents entity bean instances that have not

been instantiated yet.

2\. To create a new instance, the container calls the newInstance() method

on the entity bean class. This calls your entity bean’s default construc-

tor, bringing a new instance into memory. Next, the container associates

your entity bean with an entity context object through a callback that

Does Not Exist

Pooled

Ready

ejbRemove()

ejbStore()

1: newInstance()

2: setEntityContext()

1: unsetEntityContext()

2: JVM Will Garbage Collect

and Call finalize()

ejbFind()

Activate Your Bean:

1: ejbActivate()

2: ejbLoad()

Passivate Your Bean:

1: ejbStore()

2: ejbPassivate()

1: ejbCreate()

2: ejbPostCreate()

ejbLoad()

Business Method

The lifecycle of a bean-

managed persistent entity

bean. Each method call

shown is an invocation from

the container to the bean

instance.

ejbHome()

178 Chapter 7

  

you implement, called setEntityContext(EntityContext ctx). Note that this

step occurs only when the container wants to increase the available

pool of entity bean instances, not necessarily when a client connects.

3\. Next, your entity bean is in a pool of other entity beans. At this point

your entity bean does not have any entity bean database data loaded

into it, and it does not hold any bean-specific resources, such as socket

connections. Your bean instance can be used in this mode to find entity

data in the database, by servicing a finder method on behalf of a client.

Your bean instance can also perform operations not dependent on a

particular data instance by servicing an ejbHome() method on behalf of a

client. If the container wants to reduce its pool size, it can destroy your

bean. The container signals your bean instance that it is about to be

destroyed by calling the unsetEntityContext() method on your bean.

Once this is done, the container releases any references to your bean,

and eventually, the Java garbage collector cleans up the memory your

instance had been using. Therefore your unsetEntityContext() method

should prepare your bean to be cleaned up, perhaps by releasing any

resources your bean had claimed during setEntityContext().

4\. When the client wants to create some new database data (say, a new

order for goods placed over the Internet), it calls a create() method on

your entity bean’s home object. The container then grabs an entity bean

instance from the pool, and the instance’s ejbCreate() method is called.

ejbCreate() initializes the entity bean to a specific data set. For example,

if a client calls a create() method to create a bank account, it might pass

the bank account holder’s name and the initial balance as parameters.

Your entity bean’s ejbCreate() method would populate its member vari-

ables with these parameters. It would also create the corresponding

database representation (if you’re using bean-managed persistence).

Now your bean is in the “ready” state.

5\. While your bean is in the ready state, it is tied to specific data and hence

a specific EJB object. If there are other entity bean instances that are

views into the same database data, the container may occasionally need

to synchronize your bean instance with the underlying database, so that

you will always be working with the most recent data. The ejbLoad() and

ejbStore() methods do this; the container calls them as appropriate, based

on how you define your transactions (see Chapter 11).

6\. Your entity beans can be kicked back into the pool in two ways. If a

client calls remove() on the home object, the container will call your

instance’s ejbRemove(). The underlying database data is destroyed and

so, of course, your entity bean instance will become disassociated with

the client’s EJB object to which it was bound.

Writing Bean-Managed Persistent Entity Beans 179

  

7\. The second way your bean can return to the pool is if the EJB container

decides that your client has timed out, if the container needs to use

your bean to service a different client, or if the container is simply run-

ning out of resources. At this point, your bean is passivated, and the

container calls your ejbStore() method to ensure the database has the

most recent version of your in-memory data. Next the container calls

your ejbPassivate() method, allowing your bean instance to release held

resources. Your bean instance then enters the pool.

8\. When the container wants to assign you to an EJB object again, your

bean instance must be activated. The container calls your bean’s ejbActi-

vate() method, allowing your bean to acquire resources. The container

then calls your instance’s ejbLoad() method to load the database data

into your bean.

Note that there are a few other minor steps in this process, such as transac-

tional synchronization. Overall, these stages are the essence of a BMP entity

bean instance’s life cycle. The next step is for you to look at Figure 7.3 again

and make sure you fully grasp it. Do you understand how a single Java object

instance can be pooled and reused, going back and forth through various tran-

sitions between the pooled and ready state, perhaps representing different

database data each time? If so, congratulations. This is a crucial step toward

fully understanding EJB.

Summary

In this chapter, you’ve seen how to write bean-managed persistent (BMP)

entity beans. Table 7.1 is provided for your reference and summarizes what

you should implement in each method in your entity bean when using bean-

managed persistence. You should refer to it when rereading the code in this

chapter or when programming your own entity bean classes.

Bean-managed persistent entity beans are useful if you need to control the

underlying database operations yourself. From a developer’s perspective, the

real advantage of EJB comes from container-managed persistent entity beans.

Container-managed persistent (CMP) entity beans can be developed much

more rapidly because the container handles all data access logic for you. The

next chapter covers the EJB container-managed persistence model

  

  

  

  

wanna each of these things tackle them one by one in depth

## Gemini said

Bhai, ye Chapter 7 ka grand finale hai. Isme actual Bank Account ka example run ho raha hai aur sabse important topic **BMP Entity Bean Life Cycle (Figure 7.3)** detail mein explain kiya gaya hai.

Kyunki tumhara EJB aur J2EE architecture ka exam kaafi pass hai (aur shayad aage Spring Boot wagerah mein bhi ye concepts indirectly help karein), isliye is diagram ko dimaag mein chhap lena sabse zaroori hai. Chalo isse step-by-step todte hain.

---

### **1\. The Bank Account Code Analysis (Source 7.9, 7.10, 7.12)**

Book ne ek bada Bank Account bean likha hai. Uski key baatein kya hain?

- **`ejbHomeGetTotalBankValue()`:** Ye ek "Home Method" hai. Matlab isko call karne ke liye kisi specific customer ka account nahi chahiye. Ye sabhi accounts ka total nikal raha hai (`SELECT sum(balance) FROM accounts`). Isiliye ye *Pooled* state se chalta hai.
- **`getConnection()` helper:** Tumne dekha hoga har method (create, load, store, remove) ke shuru mein `getConnection()` call hota hai aur end mein `finally` block mein connection `close()` hota hai. Ye isliye kiya jata hai taaki database connections ka bhi ek pool maintain ho sake aur unhe block na karna pade.
- **The Client Flow (`Source 7.12`):** Client ne JNDI se connection liya 
	$$
	→
	$$
	 naya account create kiya 
	$$
	→
	$$
	 deposit call kiya 
	$$
	→
	$$
	 `withdraw(150)` kiya (jisse exception aayi kyunki balance 100 tha) 
	$$
	→
	$$
	 aur finally `remove()` call karke record delete kar diya.

---

### **2\. The Deployment Descriptor (`ejb-jar.xml` - Source 7.13)**

Is XML file mein Session Bean aur Entity Bean ke beech ka fark saaf dikhta hai:

- `<persistence-type>Bean</persistence-type>`: Ye line EJB server ko batati hai ki ye BMP hai (matlab SQL queries developer ne khud code mein likhi hain). Agar ye CMP hota, toh yahan "Container" likha hota.
- `<prim-key-class>`: Ye property batati hai ki is data ka primary key (ID) ka format kya hai (e.g., `String` ya custom class).
- `<reentrant>false</reentrant>`: Ye threading se bachaata hai. Agar true hota, toh ek bean apne aap ko hi wapas call kar sakti thi (loop mein), jo ki aamtaur par avoid kiya jata hai.

---

### **3\. The Ultimate Map: BMP Entity Bean Life Cycle (Figure 7.3)**

Ye diagram (page 178) tumhare Unit 5 ka confirm exam question hai. Ise 3 main "States" (hissay) mein samjho.

#### **State A: Does Not Exist**

- Abhi tak server par koi Java object nahi bana hai.

#### **State B: The "Pooled" State (The Waiting Room)**

1. **Entering the Pool:** Server RAM mein naya object banata hai (`newInstance()`) aur usko uska environment deta hai (`setEntityContext()`). Ab ye bean "Pool" (Waiting Room) mein aa gayi hai.
2. **What can it do here?** Is state mein bean ke paas kisi customer ka data nahi hota. Lekin ye do kaam kar sakti hai:
	- `ejbFind()` chalana (Kisi ka account dhoondna).
		- `ejbHome()` chalana (Jaise total bank balance nikalna).
3. **Leaving the Pool (To Death):** Agar server ko lagta hai ki RAM free karni hai, toh wo `unsetEntityContext()` call karke bean ko kachre mein (Garbage Collection) daal dega.

#### **State C: The "Ready" State (The Active Worker)**

Yahan bean kisi specific customer (e.g., "Account ID: 123") se judd jati hai aur EJB Object (Proxy) se attach ho jati hai.

- **Entering Ready State (Creation):** Client naya account banata hai. `ejbCreate()` chalta hai (INSERT query), fir `ejbPostCreate()` chalta hai. Ab bean *Ready* hai.
- **Entering Ready State (Activation):** Server purane account ko uthata hai. `ejbActivate()` chalta hai (sockets open hote hain), fir `ejbLoad()` chalta hai (SELECT query chalake data RAM mein aata hai). Ab bean *Ready* hai.
- **While in Ready State:** Ab client is par business methods (`deposit()`, `withdraw()`) call kar sakta hai.
- **Leaving Ready State (Passivation):** Agar bean idle padi hai, server usse wapas Pool mein daalna chahta hai. Pehle `ejbStore()` chalta hai (UPDATE query se data save), fir `ejbPassivate()` chalta hai (sockets band). Bean wapas Pool mein chali jati hai.
- **Leaving Ready State (Deletion):** Agar client account band karna chahe. `ejbRemove()` chalta hai (DELETE query). Record database se khatam, aur bean wapas khali hoke Pool mein chali jati hai.

---

### **Exam Tip for Animesh (Ani)**

Tum GATE CSE 2027 aur placements ki taiyari kar rahe ho, toh DBMS (Database) concepts tumhare clear honge. EJB BMP kuch nahi hai, bas **SQL CRUD operations ko Java class ke alag-alag life-cycle methods mein fit karne ka tareeka hai.**

- Create = `ejbCreate` (INSERT)
- Read = `ejbLoad` (SELECT)
- Update = `ejbStore` (UPDATE)
- Delete = `ejbRemove` (DELETE)

Chapter 7 khatam! Yahan tumhara BMP pura hota hai. CMP (Chapter 8) mein bas ye saara SQL Container khud likhega. Is Life Cycle mein kis arrow ya transition pe sabse zyada doubt hai?

You said

see the entire code, and give me the account section code, without the exception handlingn fluff only the important code as its too long and explain it too

## Gemini said

Bhai, ekdum sahi demand hai. Book wale code mein `try-catch`, `finally`, aur `System.out.println` itna zyada hota hai ki asli logic chhip jata hai.

Exam mein agar BMP ka code likhne ko aaye, toh tumhe sirf **Core SQL Logic** dikhana hota hai. Maine us pure `AccountBean` code se saara "fluff" hata diya hai. Sirf wahi rakha hai jo actual kaam kar raha hai.

Isko dekho, ye ekdum crystal clear hai:

### **The Simplified AccountBean (BMP Core Code)**

Java

```
public class AccountBean implements javax.ejb.EntityBean {
    
    // 1. In-Memory Variables (Java Object State)
    private EntityContext ctx;
    public String accountID;
    public String ownerName;
    public double balance;

    // 2. Business Methods (Jo client call karta hai)
    public void deposit(double amt) { 
        this.balance += amt; 
    }
    public void withdraw(double amt) { 
        this.balance -= amt; 
    }
    public double getBalance() { 
        return this.balance; 
    }

    // ---------------------------------------------------------
    // 3. EJB CALLBACK METHODS (The real BMP Magic)
    // ---------------------------------------------------------

    // CREATE: Insert a new row into the database
    public AccountPK ejbCreate(String id, String owner) {
        this.accountID = id;
        this.ownerName = owner;
        this.balance = 0;

        Connection conn = getConnection(); // DB Connection
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO accounts (id, ownerName, balance) VALUES (?, ?, ?)"
        );
        pstmt.setString(1, accountID);
        pstmt.setString(2, ownerName);
        pstmt.setDouble(3, balance);
        pstmt.executeUpdate(); // Row saved!
        
        return new AccountPK(accountID); // Return the ID to container
    }

    // LOAD: Read data from database into RAM (Java Variables)
    public void ejbLoad() {
        // Identity Crisis Solved: Find out WHO I am right now
        AccountPK pk = (AccountPK) ctx.getPrimaryKey(); 
        
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "SELECT ownerName, balance FROM accounts WHERE id = ?"
        );
        pstmt.setString(1, pk.accountID);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            this.ownerName = rs.getString("ownerName");
            this.balance = rs.getDouble("balance");
            this.accountID = pk.accountID;
        }
    }

    // STORE: Save RAM data back to the database
    public void ejbStore() {
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "UPDATE accounts SET ownerName = ?, balance = ? WHERE id = ?"
        );
        pstmt.setString(1, ownerName);
        pstmt.setDouble(2, balance);
        pstmt.setString(3, accountID); // ID memory mein already hai
        pstmt.executeUpdate();
    }

    // REMOVE: Delete the row from the database
    public void ejbRemove() {
        // Find out WHO I am before deleting!
        AccountPK pk = (AccountPK) ctx.getPrimaryKey();
        
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "DELETE FROM accounts WHERE id = ?"
        );
        pstmt.setString(1, pk.accountID);
        pstmt.executeUpdate();
    }

    // FINDER: Locate an account in the database
    public AccountPK ejbFindByPrimaryKey(AccountPK key) {
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "SELECT id FROM accounts WHERE id = ?"
        );
        pstmt.setString(1, key.accountID);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            return key; // Found it!
        } else {
            throw new ObjectNotFoundException();
        }
    }

    // Context Setup
    public void setEntityContext(EntityContext ctx) {
        this.ctx = ctx; // Save context to use getPrimaryKey() later
    }
}
```

---

### **Code Explanation (Exam ke liye yaad rakhne wale points):**

1. **Mapping Samajh lo:** \* `ejbCreate` = **INSERT**
	- `ejbLoad` = **SELECT**
		- `ejbStore` = **UPDATE**
		- `ejbRemove` = **DELETE**
2. **Context ka Magic:** Dhyan se dekho `ejbLoad` aur `ejbRemove` ko. Unke parameters khali `()` hote hain. Unhe account ka ID milta kahan se hai? Pehli line dekho: `ctx.getPrimaryKey()`. Ye wahi concept hai jo humne pichle messages mein deeply discuss kiya tha.
3. **Business Methods (Deposit/Withdraw):** In methods ke andar koi database connection nahi khula hai! Client jab deposit call karta hai, toh bas Java ka variable `this.balance += amt;` badalta hai. Phir transaction ke end mein EJB Server khud `ejbStore()` chala deta hai, jo naye balance ko database mein **UPDATE** kar deta hai.

Bhai, fluff hatne ke baad EJB ka BMP sirf basic JDBC CRUD operation lagta hai, haina? Exam mein agar iska snippet pucha jaaye toh strictly bas ye SQL queries aur context logic likh dena, examiner samajh jayega ki tumhe core architecture aata hai.

You said

now we will do the next chapter.

## Gemini said

Bhai, abhi tak humne Entity Beans ka basic architecture (Chapter 6) aur Bean-Managed Persistence (Chapter 7) mein khud SQL queries likhna seekha hai.

EJB mein aage badhte hue, **Chapter 8** usually **Container-Managed Persistence (CMP)** par hota hai. Ye wo chapter hai jahan tumhare SQL likhne ki mehnat khatam ho jati hai, kyunki EJB server (Container) tumhare liye saara database interaction (CRUD operations) khud handle kar leta hai.

**CMP mein hum kya naya seekhte hain?**

- **Abstract Classes:** CMP bean classes `abstract` hoti hain. Tum variables define nahi karte, bas `abstract` getter/setter likhte ho.
- **No JDBC Code:** Tum `ejbCreate`, `ejbLoad`, `ejbStore`, ya `ejbRemove` mein koi SQL query nahi likhte.
- **CMP Fields:** Tum deployment descriptor (`ejb-jar.xml`) mein batate ho ki kaunse variables database table ke columns se map honge.

Tum Chapter 8 ka material share karna shuru karo, main isko BMP ke comparison mein ekdum clear kar dunga. Ek baar text paste kar do, fir usko deeply samajhte hain!

You said

  

For example, in our bank account example from the previous chapter, we

defined a method called ejbHomeGetTotalBankValue(), which added the total of

all bank accounts in the bank table by performing a SQL SELECT statement

using JDBC. With CMP, you shouldn’t be writing this JDBC code—rather, the

container should generate it for you in an ejbSelect() method, and you should

call that ejbSelect() method from the ejbHomeGetTotalBankValue() method. You

then tell the container how to write the ejbSelect() method just like you do for a

finder method—by using the EJB Query Language (EJB QL) described earlier.

For example, you might define the following method in your entity bean:

public abstract double ejbSelectAllAccountBalances()

throws FinderException;

public double ejbHomeGetTotalBankValue() throws Exception {

// Get a collection of bank account balances

Collection c = this.ejbSelectAllAccountBalances();

// Loop through collection and return sum

}

ejbSelect() methods are not exposed to end clients via the remote interface or

local interface. They must be called from within your bean, either from a busi-

ness method or a home business method.

The value of ejbSelect() methods are threefold:

■■ Select methods can perform fine-grained database operations that your

bean needs, but that you do not want to expose to end clients.

■■ Select methods can retrieve data from other entity beans that you have

relationships with. (See Chapter 12 to learn more about relationships.)

■■ Like finder methods, select methods can return entity beans. But select

methods are more powerful because they can also return container-

managed fields, such as our previous example—it returns a collection

of double values.

You tell the container about how to implement your select method by defin-

ing an EJB-QL query string. For more details on how EJB-QL affects ejbSelect()

methods, see Appendix D.

As you may have noticed by now, the major differences between CMP and

BMP lie in the entity bean class and the deployment descriptors. The

remote, local, home, local home interfaces, and primary key class remain

basically the same. This means it is possible to switch between CMP and

BMP without changing the clients who call your beans, which is a nice

side effect.

190 Chapter 8

  

Implementation Guidelines for

Container-Managed Persistence

Now that we’ve explored CMP entity beans in theory, let’s see how to build

CMP entity beans. The method implementations of your BMP entity beans

should be different for CMP. No longer are you controlling the routine persis-

tent operations of your beans, and so many of the methods can be left empty—

the container will do it for you. Table 8.1 summarizes what you should

implement in each method, assuming your entity bean’s persistence is con-

tainer managed. Take a quick glance at the table for now. As you can see, many

of the database-intensive operations have been reduced in scope significantly.

You should refer to the table when reading through the code in this chapter or

when programming your own entity bean classes.

Table 8.1 Descriptions and Implementation Guidelines for Container-Managed Persistent

Entity Beans

METHOD EXPLANATION TYPICAL IMPLEMENTATION

setEntityContext() If the container wants Stick the entity context

(same as BMP) to increase its pool size somewhere, such as in a

of bean instances, it member variable. You can access

instantiates a new the context later to acquire

entity bean instance. environment information, like

Following this, the security information, from the

container calls the container. You should also

instance’s request any resources your

setEntityContext() instance will need regardless of

method. This method what data the bean represents.

associates a bean with The bean is now in a pool, does

context information— not have any specific database

information about the data inside of it, and is not

bean’s environment. bound to any particular EJB

Once this method is object.

called, the bean can

access information

about its environment.

(continued)

Writing Container-Managed Persistent Entity Beans 191

  

Table 8.1 (continued)

METHOD EXPLANATION TYPICAL IMPLEMENTATION

ejbFind,....(,....) You do not write You should not implement these

(new for CMP) finder methods for methods for CMP entity beans.

container-managed

beans. The EJB container

will handle all issues

related to finding data for

you. But how does the

EJB container know what

kinds of finder methods

you want in your bean?

After all, an infinite variety

of ways exist to find data

in a database. The answer

is that your EJB container

ships with tools for this

purpose. You use EJB-QL

and the container tools

to tell the container what

logic to execute when the

client performs a finder

method on the home

object.

ejbSelect,....(,....) ejbSelect() methods are Define this method as abstract.

(new for CMP) helper methods that Then write EJB-QL in the

perform queries deployment descriptor to set up

internally by your bean the query.

but are not accessible

to clients of your bean.

192 Chapter 8

  

Table 8.1 (continued)

METHOD EXPLANATION TYPICAL IMPLEMENTATION

ejbHome,....(,....) Sometimes you need Perform your global operations,

(new for CMP) methods on an entity such as counting up the rows in

bean that are not a database and returning the

specific to any given results to the client. The

data instance (or row)— fast-and-easy way to achieve this

for example, counting is to use JDBC. The cleaner (but

up the total number of lower-performing if you’re not

accounts in a table. You careful) way is to call ejbSelect()

can write ejbHome and perhaps other entity bean

methods to perform methods.

these operations. The

ejbHome methods are

special business methods

because they are called

from a bean in the pool

before the bean is

associated with any

specific data. Clients call

these methods from

the home interface or

local home interface.

ejbCreate(,....) When a client calls Do not create database data in

(new for CMP) create() on a home this method. Rather, validate the

object, the container client’s initialization parameters.

Note: You do not then calls ejbCreate() Call your abstract set() methods

need to write any on a pooled bean to initialize the generated bean

ejbCreate() methods instance. ejbCreate() subclass to the parameters

if you don’t want EJB methods are responsible passed in. The container will

clients to be able to for creating new then use these values in the

create new database data and subclass to create the database

database data. initializing your bean. data for you. Your entity bean

Some systems may instance is then no longer in the

allow creation of pool—it now has specific

data to occur via database data inside it. The

direct database container will bind your instance

inserts through to a particular EJB objects.

batch files or

other means.

(continued)

Writing Container-Managed Persistent Entity Beans 193

  

Table 8.1 (continued)

METHOD EXPLANATION TYPICAL IMPLEMENTATION

ejbPostCreate(,....) There is one The container calls

(same as BMP) ejbPostCreate(...) for ejbPostCreate() after it has

each ejbCreate(...). associated your bean instance

Each pair has the same with an EJB object. You can now

parameters. The container complete your initialization by

calls your bean instance’s doing anything you need to that

ejbPostCreate(...) requires that EJB object, such as

method following passing your bean’s EJB object

ejbCreate(...). reference to other beans. Note:

By now the EJB container will

have created your primary key

object, so you can retrieve and

use it.

ejbActivate() When a client calls a Acquire any bean-specific

(same as BMP) business method on resources, like socket

an EJB object, but no connections, that your bean

entity bean instance is needs to service a particular

bound to the EJB object, client when it is moved into the

the container needs to ready state.

take a bean from the

pool and transition it

into a ready state. This

is called activation.

On activation, the

ejbActivate() method is

called by the EJB

container.

ejbLoad() The EJB container calls Do not read data from the

(new for CMP) this method to load database in this method. Rather,

database data into your the EJB container will read in

bean instance, based data from the database for you

on the current automatically right before calling

transactional state. your ejbLoad() method. It does

this by setting your container-

managed fields to the data it

reads from the database. In this

method, you should perform any

utilities you need to work with

the read-in data, such as

decompressing a text field.

194 Chapter 8

  

Table 8.1 (continued)

METHOD EXPLANATION TYPICAL IMPLEMENTATION

ejbStore() The EJB container Do not update the database in

(new for CMP) calls this to update the this method. Rather, the EJB

database to the new container will update the

values of your in-memory database for you automatically

fields, thus synchronizing right after calling your ejbStore()

the database. The method. It does this in the

current transactional subclass by writing your

state dictates when this container-managed fields to the

method is called. This database. In method, you should

method is also called prepare your container-managed

during passivation, fields to be written to the

directly before database. For example, you can

ejbPassivate(). compress the text of your fields

if necessary by calling your own

abstract set() methods.

ejbPassivate() The EJB container calls Release any resources, such as

(same as BMP) this method when it socket connections, that you

wants to return your allocated in ejbActivate() and

entity bean to the pool. that your bean was holding

This is called passivation during the ready state for a

and is the opposite of particular client.

activation. On passivation,

the ejbPassivate()

method is called by the

EJB container.

ejbRemove() The client calls the home Do not destroy database data in

(new for CMP) object’s remove() this method. Rather, simply

method to destroy perform any operations that

database data remove(), must be done before the data in

then calls your the database is destroyed. The

ejbRemove(). Note that EJB container will destroy the

this does not destroy the data for you right after

Java object because ejbRemove() is called.

the object can be

pooled and reused for

different data.

unsetEntityContext() This method Release any resources you

(same as BMP) disassociates a bean allocated during

from its environment. setEntityContext(), and get ready

The container calls this for garbage collection.

right before your entity

bean instance is

destroyed (when it

wants to reduce the

pool size).

Writing Container-Managed Persistent Entity Beans 195

  

Looking to see how BMP and CMP method implementations compare?

Appendix E has a table comparing them.

## Gemini said

Bhai, Unit 5 ka last major conceptual jump: **Container-Managed Persistence (CMP)**.

Chapter 7 mein (BMP) tum database ke "Driver" the. Chapter 8 mein (CMP) tum "Passenger" ho aur Container (Server) gaadi chala raha hai. Tum bas map (`ejb-jar.xml` deployment descriptor) mein batate ho ki "Wahan jana hai", aur container khud SQL queries generate karke tumhe le jata hai.

Here is the deep dive into the EJB-CMP textbook material you provided, simplified for your exams.

---

### **1\. The Power of `ejbSelect` (The Hidden Finder)**

Tumne ek bahut lamba method `ejbHomeGetTotalBankValue()` banaya tha pichle chapter mein (jisme JDBC se SUM nikala tha). CMP mein EJB ek naya concept lata hai: **`ejbSelect()`**.

- **What is it?** Ye bean ke internal helper methods hain jo database query chalate hain.
- **Abstract Nature:** Tum bean class mein iski sirf definition likhte ho: `public abstract double ejbSelectAllAccountBalances();`. Tum iska code nahi likhte!
- **How it works:** Container iska code khud generate karta hai based on the **EJB QL (EJB Query Language)** query jo tum XML file mein likhte ho.
- **Why use `ejbSelect` instead of `ejbFind`?**
	- `ejbFind` clients ke liye hota hai aur hamesha *Entity Beans* (Remote/Local interface) return karta hai.
		- `ejbSelect` sirf tumhare *internal bean code* ke liye hota hai. Ye direct variables (like `Collection` of Doubles ya Strings) return kar sakta hai. Client isko direct call nahi kar sakta.

---

### **2\. The Abstract Bean Class (A Huge Paradigm Shift)**

Ye CMP ka sabse bada architecture change hai. Tumhari bean class ab ek normal class nahi, ek **`abstract class`** ban jayegi.

- **BMP mein:** Tumne likha tha: `public String accountID;` aur uske getters/setters khud likhe the.
- **CMP mein:** Tum variables define hi nahi karoge! Tum sirf *abstract* methods likhoge:
	Java
	```
	public abstract String getAccountID();
	public abstract void setAccountID(String id);
	```
- **Why?** Kyunki Container tumhari `abstract` class ko extend karke ek *Concrete Subclass* generate karega (deployment ke time pe), jisme wo variables banayega aur un getters/setters ke andar apna JDBC code daalega.

---

### **3\. The CMP Callbacks: Doing *Less* is More (Table 8.1 Decoded)**

Ye table exam ke liye zaroori hai kyunki ye BMP vs CMP ka direct comparison hai. CMP mein tumhe in methods mein **NO SQL, NO JDBC** likhna hai.

- **`ejbFind...()`:** Tum inhe apni bean class mein likhte hi nahi! Tum inhe sirf Home Interface mein define karte ho, aur EJB QL likh dete ho. Container inka code khud banata hai.
- **`ejbCreate()`:**
	- *BMP mein:* Tumne `INSERT INTO` SQL likha tha.
		- *CMP mein:* Tum sirf aane wale data ko abstract setters ke through set karte ho: `setAccountID(id); setBalance(0);`. Container automatically is data ko uthakar INSERT kar dega is method ke khatam hone ke baad.
- **`ejbLoad()`:**
	- *BMP mein:* Tumne `SELECT` query likhi thi.
		- *CMP mein:* Container pehle hi database se data padh kar tumhare abstract getters/setters ke variable mein daal deta hai. Tum is method ko khali chhod sakte ho, ya sirf data formatting kar sakte ho (e.g., koi compressed string mili toh usko decompress karna).
- **`ejbStore()`:**
	- *BMP mein:* Tumne `UPDATE` query likhi thi.
		- *CMP mein:* Tumhe bas make sure karna hai ki tumhare variables ready hain. Container is method ke khatam hone ke baad automatically `UPDATE` chala dega.
- **`ejbRemove()`:**
	- *BMP mein:* Tumne `DELETE` query likhi thi.
		- *CMP mein:* Method khali chhod do. Container is method ke turant baad row delete kar dega.

---

### **Quick Recap for Exam (The "Why CMP" Answer):**

1. **Code Size:** JDBC code hatne se bean ka size 50-70% chota ho jata hai.
2. **Portability:** Kyunki tumne raw SQL nahi likha, tumhara same code Oracle se MySQL bina ek line change kiye shift ho sakta hai (Container us naye database ke hisaab se SQL generate kar dega).
3. **Performance:** Container-managed relationships aur caching ki wajah se kai baar CMP BMP se zyada fast hota hai kyunki container ko EJB objects ke internals zyada achhe se pata hote hain.

Bhai, CMP ki theory ekdum straightforward hai. Ab iska code example dekhna chahte ho ki ye abstract getters/setters aur EJB-QL actual mein kaise dikhte hain?

You said

  

<abstract-schema-name>PRODUCTS</abstract-schema-name>

<cmp-field>

<field-name>productID</field-name>

</cmp-field>

<cmp-field>

<field-name>name</field-name>

</cmp-field>

<cmp-field>

<field-name>description</field-name>

</cmp-field>

<cmp-field>

<field-name>basePrice</field-name>

</cmp-field>

<primkey-field>productID</primkey-field>

<query>

<query-method>

<method-name>findByName</method-name>

<method-params>

<method-param>java.lang.String</method-param>

</method-params>

</query-method>

<ejb-ql>SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE p.name = ?1

</ejb-ql>

</query>

<query>

<query-method>

<method-name>findByDescription</method-name>

<method-params>

<method-param>java.lang.String</method-param>

</method-params>

</query-method>

<ejb-ql>SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE p.description =

?1

</ejb-ql>

</query>

<query>

<query-method>

<method-name>findByBasePrice</method-name>

<method-params>

<method-param>double</method-param>

</method-params>

</query-method>

<ejb-ql>SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE p.basePrice =

?1</ejb-ql>

</query>

<query>

Source 8.7 (continued)

208 Chapter 8

  

<query-method>

<method-name>findExpensiveProducts</method-name>

<method-params>

<method-param>double</method-param>

</method-params>

</query-method>

<ejb-ql><!\[CDATA\[SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE

p.basePrice > ?1\]\]></ejb-ql>

</query>

<query>

<query-method>

<method-name>findCheapProducts</method-name>

<method-params>

<method-param>double</method-param>

</method-params>

</query-method>

<ejb-ql><!\[CDATA\[SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE

p.basePrice < ?1\]\]></ejb-ql>

</query>

<query>

<query-method>

<method-name>findAllProducts</method-name>

<method-params>

</method-params>

</query-method>

<ejb-ql>SELECT DISTINCT OBJECT(p) FROM PRODUCTS p WHERE p.productID IS

NOT NULL</ejb-ql>

</query>

</entity>

</enterprise-beans>

<assembly-descriptor>

<container-transaction>

<method>

<ejb-name>Product</ejb-name>

<method-intf>Remote</method-intf>

<method-name>\*</method-name>

</method>

<method>

<ejb-name>Product</ejb-name>

<method-intf>Home</method-intf>

<method-name>\*</method-name>

</method>

<trans-attribute>Required</trans-attribute>

</container-transaction>

</assembly-descriptor>

</ejb-jar>

Source 8.7 (continued)

Writing Container-Managed Persistent Entity Beans 209

  

Our deployment descriptor begins by identifying the name of the bean,

then the bean class, and so on, which is the same as BMP. We then define the

container-managed fields, which must match the abstract get/set methods in

the enterprise bean class.

The bulk of the descriptor following this is the code for our queries. For

example, the findExpensiveProducts() finder method locates all products that are

more expensive than the double parameter passed in. To instruct the container

on how to implement this finder functionality, we define our EJB-QL as follows:

<!\[CDATA\[SELECT OBJECT(p) FROM PRODUCTS p WHERE p.basePrice > ?1\]\]>

When the container interprets this EJB-QL, it generates database access code

(such as JDBC) to find all of the expensive products whose basePrice column is

greater in value than the double passed in, represented by the ?1. Whenever a

client wants to execute a finder method on the home object, the container auto-

matically runs the database access code.

Notice also the word CDATA. This instructs the container’s XML parser that

reads the descriptor to treat the text SELECT OBJECT(a) FROM ProductBean AS

a WHERE basePrice . ?1 as unstructured character data. This is important

because the container’s XML parser may think that the text inside the CDATA

section does not comply with the XML standard; it may think the > character

is actually the closing of an XML tag, rather than a less-than sign. Thus, all EJB-

QL that contains < or > must be enclosed in CDATA sections. Alternatively,

< and > can be written as the escape sequences ‘&lt;’ and ‘&gt;’, so the previ-

ous example could also be written as:

SELECT OBJECT(p) FROM PRODUCTS p WHERE p.basePrice &gt; ?1

We recommend enclosing queries in CDATA sections, however, so that the

whole query remains readable.

The end of our descriptor associates transactions with our entity bean,

which we’ll discuss in Chapter 11.

The Container-Specific Deployment Descriptor

In addition to the deployment descriptor, we need to tell the container exactly

how to perform persistent operations. This is one trade-off of CMP—you still

need to declare persistent rules, even if you don’t code them into your bean

using JDBC.

If you’re using a relational data store, you need to define exactly how your

entity bean’s public fields map to that database. Thus, we must define a series

210 Chapter 8

  

of object-relational mapping entries. These entries map entity bean fields to

relational database column names. The EJB container uses this mapping when

storing or retrieving our container-managed fields from the database. Note

that this is very EJB container-specific! Some EJB containers support object

databases and thus do not have a mapping into a two-dimensional relational

database. Consult your EJB container’s documentation for more information.

Our product line bean’s persistent entries for a relational database are shown in

Table 8.2. See the book’s accompanying source code for the actual descriptor.

Table 8.2 Sample Persistent Settings for ProductBean

OBJECT/RELATIONAL SETTING

(ENTITY BEAN FIELD = RELATIONAL COLUMN NAME)

productID=productid

name=name

description=description

basePrice=basePrice

Writing Container-Managed Persistent Entity Beans 211

WHEN TO USE CUSTOM PRIMARY KEY CLASSES

In our bean we’ve declared a custom primary key class, ProductPK. We then

have this element in our deployment descriptor:

<prim-key-class>examples.ProductPK</prim-key-class>

This is not strictly necessary, however. You can choose not to invent a

custom primary key class and just use one of your container-managed fields

as the primary key. For example, we could use the productID String field as the

primary key, rather than wrapping it in another primary key wrapper class. Then

we would declare the primary key class to be a java.lang.String, and we would

have this element after we declare the container-managed fields:

<primkey-field>productID</primkey-field>

When should you use a custom primary key class, and when should you use

one of your fields? In our opinion, you should avoid using your own fields as

primary key classes. The reason is because having a primary key class wrapper

isolates you from changes to how you’d like to be uniquely represented in an

underlying storage. Having a primary key class wrapper makes it much easier to

change how you’d like to be uniquely identified without breaking code.

  

Client.java

Our client code is a simple suite of test cases to try out our bean, as shown

Source 8.8.

package examples.cmp;

import javax.ejb.\*;

import javax.naming.\*;

import java.rmi.\*;

import javax.rmi.PortableRemoteObject;

import java.util.\*;

/\*\*

\* Client test application on a CMP Entity Bean, Product.

\*/

public class ProductClient {

public static void main(String\[\] args) throws Exception {

ProductHome home = null;

try {

/\*

\* Get a reference to the Product Home Object - the

\* factory for Product EJB Objects

\*/

Context ctx = new InitialContext(System.getProperties());

home = (ProductHome) PortableRemoteObject.narrow(

ctx.lookup(“ProductHome”), ProductHome.class);

/\*

\* Use the factory to create the Product EJB Object

\*/

home.create(“123-456-7890”, “P5-350”, “350 Mhz Pentium”, 200);

home.create(“123-456-7891”, “P5-400”, “400 Mhz Pentium”, 300);

home.create(“123-456-7892”, “P5-450”, “450 Mhz Pentium”, 400);

home.create(“123-456-7893”, “SD-64”, “64 MB SDRAM”, 50);

home.create(“123-456-7894”, “SD-128”, “128 MB SDRAM”, 100);

home.create(“123-456-7895”, “SD-256”, “256 MB SDRAM”, 200);

/\*

\* Find a Product, and print out its description

\*/

Iterator i = home.findByName(“SD-64”).iterator();

System.out.println(“These products match the name SD-64:”);

while (i.hasNext()) {

Source 8.8 Client.java. (continued)

212 Chapter 8

  

Product prod = (Product) PortableRemoteObject.narrow(

i.next(), Product.class);

System.out.println(prod.getDescription());

}

/\*

\* Find all products that cost $200

\*/

System.out.println(“Finding all products that cost $200”);

i = home.findByBasePrice(200).iterator();

while (i.hasNext()) {

Product prod = (Product) PortableRemoteObject.narrow(

i.next(), Product.class);

System.out.println(prod.getDescription());

}

}

catch (Exception e) {

e.printStackTrace();

}

finally {

if (home != null) {

System.out.println(“Destroying products..”);

/\*

\* Find all the products

\*/

Iterator i = home.findAllProducts().iterator();

while (i.hasNext()) {

try {

Product prod = (Product) PortableRemoteObject.narrow(

i.next(), Product.class);

if (prod.getProductID().startsWith(“123”)) {

prod.remove();

}

}

catch (Exception e) {

e.printStackTrace();

}

}

}

}

}

}

Source 8.8 (continued)

Writing Container-Managed Persistent Entity Beans 213

  

Because this standalone application runs in a separate process from the

application server, for testing purposes, this client calls through the bean’s

remote interface rather than a local interface. However, in a real-world sce-

nario, we would wrap this entity bean with a session bean and call it through

its local interface.

The client performs a JNDI lookup to acquire the home object and create

some entity bean data. We then try out a couple of finder methods. We can

loop through the finders’ returned collection and call business methods on

each EJB object. We then destroy all the EJB objects we created in a finally{ }

clause.

Running the Client Program

To run the client program, type a command similar to the following (depend-

ing on your EJB container’s JNDI initialization parameters):

java -Djava.naming.factory.initial=com.sun.jndi.cosnaming.CNCtxFactory

\-

Djava.naming.provider.url=corbaloc::raccoon:3700/NameServiceexamples.cmp

.ProductClient

The initialization parameters are required by JNDI to find the home object,

as we learned in Chapter 3.

When we run the client, we first create a few products and then perform a

find for all products that cost $200. Indeed, multiple entity beans were returned

in our collection, as shown here:

These products match the name SD-64:

64 MB SDRAM

Finding all products that cost $200

350 Mhz Pentium

256 MB SDRAM

Destroying products..

The Life Cycle of a CMP Entity Bean

Now that we’ve seen a complete CMP entity bean example, you should be able

to understand Figure 8.4, which illustrates how the container interacts with

CMP entity beans.

214 Chapter 8

  

Figure 8.4 The CMP entity bean life cycle.

The life cycle of a CMP entity bean is exactly the same as that of a BMP entity

bean, which we fully described at the end of the previous chapter. The only

differences are that ejbSelect() methods can be called from the pooled state or

ready state.

does not exist

pooled

ready

ejbRemove()

ejbStore()

1: newInstance()

2: setEntityContext()

1: unsetEntityContext()

2: JVM will garbage collect

and call finalize()

ejbFind()

or

ejbSelect()

Activate your bean:

1: ejbActivate()

2: ejbLoad()

Passivate your bean:

1: ejbStore()

2: ejbPassivate()

1: ejbCreate()

2: ejbPostCreate()

ejbLoad()

business method

or

ejbSelect()

The life cycle of a container-

managed persistent entity

bean. Each method call

shown is an invocation from

the container to the bean

instance.

ejbHome()

Writing Container-Managed Persistent Entity Beans 215

  

Summary

In this chapter, we learned how to write CMP entity beans. We saw how the

bean instance callback methods differ between BMP and CMP. We then went

through an example that modeled a product line. Finally, we wrapped up with

a look at the life cycle of a CMP entity bean.

In the next chapter, we’ll look at the last EJB 2.0 bean type, message-driven

bean.

  

  

this is where the chapter complete, these are the important topics, lecturer told to do that dont use try catch in the code to reduce the code to learn only use very less finder method and only 1 method in home and final, something like that, let that be you continue with the understanding in depth while also comparing everything with session bean and bmp we read and understood before.

## Gemini said

Bhai, Chapter 8 (CMP) ka end bahut clear aur scoring hai. Tumhari background database schema aur architecture mein kafi strong hai, toh ye tumhe direct ORM (Object-Relational Mapping) jaisa lagega. Tumhare professor ki tip ekdum sahi hai—exam mein code jitna chota aur point-to-point hoga, utna better hai. "Fluff" hata kar core logic par focus karna chahiye.

Let's break down this final section, compare it to BMP, and get the exact minimal code you need.

---

### **1\. The Deployment Descriptor (`ejb-jar.xml`) and EJB-QL**

CMP ka "dil" uski Java class mein nahi, is XML file mein hota hai. Yahan tum Container ko batate ho ki database se kaise baat karni hai.

- **CMP Fields:** Tum list karte ho ki kaunse variables database columns hain (`<cmp-field>`).
- **The Queries (EJB-QL):** Ye sabse important part hai. BMP mein tumne `ejbFind...` methods ke andar raw JDBC (SQL) likha tha. CMP mein, tum wo methods class mein likhte hi nahi! Tum is XML mein EJB-QL likhte ho.

**EJB-QL vs SQL:**

- *SQL:* `SELECT * FROM accounts WHERE balance > 100` (Direct table aur column names).
- *EJB-QL:* `SELECT OBJECT(p) FROM PRODUCTS p WHERE p.basePrice > ?1` (Ye objects par operate karta hai. `p` tumhari bean hai, aur `?1` pehla parameter hai jo method mein pass hoga).

**The CDATA Trick:** Kyunki XML mein `<` aur `>` tags ke liye use hote hain, `basePrice > 200` likhne se XML parser confuse ho jata hai. Isliye isko `<![CDATA[ ... ]]>` mein wrap kiya jata hai. Ye bas ek hack hai parser ko batane ke liye ki "Isko as-is text padho".

---

### **2\. Primary Key Classes (The "Wrapper" Logic)**

Book ek interesting point batati hai Primary Keys ke baare mein.

- **Option 1 (Direct Field):** Tum apne `String accountID` ko direct primary key bana sakte ho (`<primkey-field>productID</primkey-field>`).
- **Option 2 (Custom Wrapper Class):** Tum ek alag class banate ho (e.g., `ProductPK.java`) jisme sirf ID hota hai.
- **Why Option 2?** Agar kal ko database change hua aur primary key akeli ID ki jagah `ID + Region Code` (Composite Key) ho gayi, toh Wrapper Class use karne se tumhara code nahi tootega. (Ye pure architecture best practice hai).

---

### **3\. The Minimalist CMP Bean Code (For Exams)**

Tumhare professor ki advice follow karte hue, BMP ke comparison mein CMP ka code bahut chota hai. Yahan try/catch aur extra finders hataye hue hain:

Java

```
public abstract class ProductBean implements javax.ejb.EntityBean {

    private EntityContext ctx;

    // 1. ABSTRACT GETTERS/SETTERS (Container will generate the real code)
    // No variables defined here!
    public abstract String getProductID();
    public abstract void setProductID(String id);
    
    public abstract double getBasePrice();
    public abstract void setBasePrice(double price);

    // 2. ABSTRACT EJBSELECT (Internal helper method)
    public abstract java.util.Collection ejbSelectAllAccountBalances() throws FinderException;

    // 3. HOME BUSINESS METHOD
    public double ejbHomeGetTotalBankValue() {
         // Uses the abstract select method above
         Collection c = this.ejbSelectAllAccountBalances();
         double sum = 0;
         for(Double amt : c) { sum += amt; }
         return sum;
    }

    // 4. EJB CREATE (Only set the variables, NO SQL!)
    public ProductPK ejbCreate(String id, double price) throws CreateException {
        // Just call the abstract setters. Container handles the INSERT later.
        setProductID(id);
        setBasePrice(price);
        return null; // CMP specifically returns null here, unlike BMP
    }

    public void ejbPostCreate(String id, double price) { }

    // 5. REQUIRED CALLBACKS (Leave them EMPTY for basic CMP!)
    public void ejbLoad() { } // Container already loaded data into fields
    public void ejbStore() { } // Container will save fields to DB automatically
    public void ejbRemove() { } // Container will delete the row automatically
    public void ejbActivate() { }
    public void ejbPassivate() { }

    public void setEntityContext(EntityContext ctx) { this.ctx = ctx; }
    public void unsetEntityContext() { this.ctx = null; }
}
```

*Comparison Note:* Dhyan do ki BMP mein `ejbCreate`, `ejbLoad`, etc. SQL se bhare the. CMP mein ye sab effectively khali hain.

---

### **4\. The CMP Life Cycle (Figure 8.4)**

CMP ka lifecycle diagram (Figure 8.4) BMP ke diagram (Figure 7.3) ki **exact copy** hai. Isme koi difference nahi hai!

Sirf ek choti si detail add hui hai: **`ejbSelect()`**.

- `ejbSelect` Pooled State mein chal sakta hai (kisi Home method ke andar se).
- `ejbSelect` Ready State mein chal sakta hai (kisi Business method ke andar se).

Baaki sab same hai: `newInstance()` 
$$
→
$$
 Pool 
$$
→
$$
 `ejbCreate/ejbActivate` 
$$
→
$$
 Ready 
$$
→
$$
 `ejbStore/ejbPassivate` 
$$
→
$$
 Pool 
$$
→
$$
 `ejbRemove` 
$$
→
$$
 Destroy.

### **The Grand Comparison (Session vs BMP vs CMP)**

| Feature | Session Bean (Stateless/Stateful) | Entity Bean (BMP) | Entity Bean (CMP) |
| --- | --- | --- | --- |
| **Purpose** | Business Workflow (Verbs). | Database Data (Nouns). | Database Data (Nouns). |
| **Lifespan** | Dies with the client/session. | Lives forever in the DB. | Lives forever in the DB. |
| **Identity (Primary Key)** | No. | Yes. | Yes. |
| **Database Queries (CRUD)** | Manually written (usually via DAO). | Developer writes raw SQL/JDBC. | Container generates SQL from XML. |
| **Class Type** | Regular `class`. | Regular `class`. | `abstract class`. |

Bhai, Unit 5 aur ye pura persistence ka concept yahan lock ho jata hai. Tumhara syllabus Unit 3, 4, aur 5 (uptil persistence) yahi tha.

Ab ek last baar, kya koi aisi specific definition, diagram flow, ya comparison hai jo dimaag mein fasa hua hai? Ya sab ekdum sorted hai exam ke liye?

You said

Motivation to Use Message-Driven Beans

In previous chapters, you learned how to code session and entity beans—

distributed components that are accessed using RMI-IIOP. RMI-IIOP is a

Introduction to

Message-Driven Beans

C H A P T E R

9

traditional, heavyweight way to call components. While RMI-IIOP may be

useful in many scenarios, several other areas are challenging for RMI-IIOP.

Here are just four examples:

■■ Performance. A typical RMI-IIOP client must wait (or block) while the

server performs its processing. Only when the server completes its

work does the client receive a return result, which enables it to continue

processing.

■■ Reliability. When an RMI-IIOP client calls the server, the latter has to

be running. If the server crashes or the network crashes, the client can-

not perform its intended operation.

■■ Support for multiple senders and receivers. RMI-IIOP limits you to a

single client talking to a single server at any given time. There is no

built-in functionality for multiple clients to broadcast events to multiple

servers.

■■ Integration with other MOM systems. When you have enterprise sys-

tems that communicate through messages, message-driven beans cou-

pled along with J2EE connectors can integrate these different

message-driven enterprise systems.

Messaging is an alternative to remote method invocations (see Figure 9.1).

The idea behind messaging is that a middleman sits between the client and the

server. (A layer of indirection solves every problem in computer science.) This

middleman receives messages from one or more message producers and broad-

casts those messages to one or more message consumers. Because of this mid-

dleman, the producer can send a message and then continue processing. He

can optionally be notified of the response later when the consumer finishes.

This is called asynchronous programming.

Figure 9.1 Remote method invocations versus messaging.

Application

Message

Middleware

Application Application

Application

Remote Method Invocations:

Messaging:

218 Chapter 9

Messaging addresses the three previous concerns with RMI-IIOP as follows:

■■ Non-blocking request processing. A messaging client does not need to

block when executing a request. As an example, when you purchase a

book using the Amazon.com one-click order functionality, you can

continue browsing the site without waiting to see if your credit card

authorizes. Unless something goes wrong, Amazon.com sends you a

confirmation e-mail afterwards. This type of fire-and-forget system

could easily be coded using messaging. When the user clicks to buy the

book, a message is sent that results in credit card processing later. The

user can continue to browse.

■■ Reliability. If your message-oriented middleware supports guaranteed

delivery, you can send a message and know for sure that it will reach its

destination, even if the consumer is not available. You send the message

to the MOM middleman, and that middleman routes the message to the

consumer when he comes back alive again. With RMI-IIOP, this is not

possible because there is no middleman. If the server is down, an

exception is thrown.

■■ Support for multiple senders and receivers. Most message-oriented

middleware products can accept messages from many senders and

broadcast them to many receivers. This enables you to have multinary

communications.

Note that messaging also has many disadvantages. Performance, for one,

can be slower in many circumstances due to the overhead of having the mes-

saging middleman. For a complete comparison of when to (and when not to)

use messaging, see Chapter 18.

Message-oriented middleware (MOM) is a term used to refer to any infrastruc-

ture that supports messaging. A variety of products are considered to have a

MOM-based architecture. Examples include Tibco Rendezvous, IBM Web-

Sphere MQ, BEA Tuxedo/Q, Sun Java System Messaging Server, Microsoft

MSMQ, Sonic Software SonicMQ, and FioranoMQ. These products can give

you a whole host of value-added services, such as guaranteed message deliv-

ery, fault tolerance, load balancing of destinations, subscriber throttling of

message consumption, inactive subscribers, support for SOAP over JMS, and

much, much more. By allowing the MOM server to address these infrastruc-

ture issues, you can focus on the business task at hand.

The Java Message Service

Over the years, MOM systems have evolved in a proprietary way. Each prod-

uct has its own API, which creates vendor lock-in because code is not portable

to other messaging systems. It also hurts developers, because they need to

relearn each messaging product’s proprietary API.

Introduction to Message-Driven Beans 219

The Java Message Service (JMS) is a messaging standard, designed to elimi-

nate many of the disadvantages that MOM-based products faced over past

years. JMS has two parts: an API, for which you write code to send and receive

messages, and a Service Provider Interface (SPI) where you plug in JMS

providers. A JMS provider knows how to talk to a specific MOM implementa-

tion. The JMS promise is that you can learn the JMS API once and reuse your

messaging code with different plug-and-play MOM implementations (an idea

similar to the other J2EE APIs, such as JNDI or JDBC).

Let’s explore the JMS API and see how to write a simple JMS program that

publishes messages

## Gemini said

Bhai, ye Chapter 9 ka intro hai jo tumhare Unit 4 ka part hai (**JMS and Message-Driven Beans**). Ye topic tumhare placement aur exam dono ke liye bahut zaruri hai kyunki modern architecture (Microservices, Kafka, RabbitMQ) isi logic par base hai.

Ed Roman ne yahan bataya hai ki **RMI-IIOP** (jo humne Session/Entity beans mein dekha) aur **Messaging** (JMS) mein kya fark hai.

---

### **1\. Motivation: RMI-IIOP ki Problem kya hai?**

Abhi tak tumne dekha ki Client, EJB Object ko call karta hai aur wait karta hai jab tak result na aa jaye. Isme 3 bade masle hain:

- **Blocking (Performance):** Client tab tak khali baitha rehta hai jab tak server kaam khatam na kar de. Socho agar Amazon pe "Order" button dabate hi tumhara browser tab tak lock ho jaye jab tak bank payment confirm na ho. Boring, right?
- **Reliability (Dependence):** Client aur Server dono ka ek saath "Zinda" (Running) hona zaruri hai. Agar server down hai, toh client ko Error mil jayegi.
- **1-to-1 Limit:** RMI mein ek client sirf ek server se baat kar sakta hai. Ek saath 10 servers ko message nahi bhej sakta.

### **2\. Indirection: The Messaging Middleman**

Messaging iska solution hai. Isme ek **Middleman** (jisey MOM - Message Oriented Middleware kehte hain) client aur server ke beech baith jata hai.

**Fayde:**

- **Non-Blocking (Asynchronous):** Client message "bhej kar bhool jata hai" (**Fire-and-Forget**). Amazon pe order dabo, browse karte raho, confirmation baad mein mail pe aa jayegi.
- **Guaranteed Delivery:** Agar server (consumer) down bhi hai, toh Middleman us message ko apne paas save kar lega aur jab server wapas aayega, usey de dega.
- **Many-to-Many:** Ek message producer kai saare consumers ko broadcast kar sakta hai.

### **3\. MOM vs JMS (The Standard)**

- **MOM:** Ye wo software hai jo asliyat mein message transfer karta hai (Jaise IBM MQ, RabbitMQ). Pehle ye sab proprietary the, matlab har ek ka code alag likhna padta tha.
- **JMS (Java Message Service):** Ye Java ka standard API hai (Jaise JDBC database ke liye hai). Tum sirf JMS ka code likhte ho, aur pichhe koi bhi MOM (ActiveMQ, SonicMQ) laga sakte ho bina code badle.

---

### **Summary of Difference (Exam Point)**

| Feature | RMI-IIOP (Session/Entity) | JMS (Message-Driven Beans) |
| --- | --- | --- |
| **Communication** | Synchronous (Wait karna padta hai). | Asynchronous (Bhej ke bhool jao). |
| **Coupling** | Tightly Coupled (Dono online chahiye). | Loosely Coupled (Middleman sambhaal lega). |
| **API** | Remote/Local Interfaces. | JMS API / Message-Driven Beans. |
| **Reliability** | Server down = Call fail. | Server down = Message queue mein wait karega. |

Bhai, ye asynchronous wala concept clear hai? Kyunki **Message-Driven Beans (MDB)** wahi beans hain jo is Middleman se message receive karne ke liye "Ready" baithi rehti hain.

Aage **JMS Programming Model** (Queues vs Topics) samjhein? Ye Unit 4 ka core hai.

You said

The JMS API

The JMS API is more involved than RMI-IIOP. You need to become familiar

with many different interfaces to get going. Despite the complexities involved

in working with each of these interfaces, low-level topology issues, such as

networking protocol, message format and structure, and server location, are

mostly abstracted from the developer.

The JMS programming model is shown in Figure 9.3. It is explained in the

list that follows:

1\. Locate the JMS Provider ConnectionFactory instance. You first need

to get access to the JMS provider of the particular MOM product

you’re using. For this, you need to establish a connection using a

ConnectionFactory instance. You can get hold of ConnectionFactory by

looking it up in JNDI. An administrator will typically create and config-

ure the ConnectionFactory for the JMS client’s use.

2\. Create a JMS connection. A JMS Connection is an active connection to

the JMS provider, managing the low-level network communications

(similar to a JDBC connection). You use the ConnectionFactory to get a

Connection. If you’re in a large deployment, this connection might be

load-balanced across a group of machines.

3\. Create a JMS session. A JMS Session is a helper object that you use

when sending and receiving messages. It serves as a factory for mes-

sage consumers and producers, and also enables you to encapsulate

your messages in transactions. You use the Connection to get a Session.

4\. Locate the JMS destination. A JMS Destination is the channel to which

you’re sending or from which you’re receiving messages. Locating the

right destination is analogous to tuning into the right channel when

watching television or answering the correct phone, so that you get the

messages you desire. Your deployer typically sets up the destination in

advance by using your JMS provider’s tools, so that the destination is

permanently set up. Your code looks up that destination using JNDI.

This enables your programs to use the destination over and over again

at runtime.

222 Chapter 9

5\. Create a JMS producer or a JMS consumer. If you want to send mes-

sages, you need to call a JMS object to pass it your messages. This object

is called producer. To receive messages, you call a JMS object and ask it

for a message. This object is called the Consumer object. You use the

Session and Destination to get a hold of a Producer or a Consumer object.

6\. Send or receive your message. If you’re producing, you first need to

put your message together. There are many different types of messages,

such as text, bytes, streams, objects, and maps. After you instantiate

your message, you send it using the Producer object. If, on the other

hand, you’re receiving messages, you first receive a message using the

Consumer object, and then crack it open (depending on the message

type) and see what is in it.

Figure 9.3 Client view of a JMS system.

JMS Server

Queue1

Queue2

Topic1

Serialized

Message

Communication

Naming Service

Such as LDAP

1: Retrieve

JMS Driver

(Connection

Factory)

Client

JMS Connection

Factory

JMS Connection

3: Create

Session

4: Lookup

JMS Destination

JNDI

5: Create

Producer

or Consumer

JMS Producer

or

JMS Consumer

6: Send or

Receive

Message

JMS Session

2: Create

Connection

JMS Driver Client Runtime

Introduction to Message-Driven Beans 223

Everything we just learned applies to both publish/subscribe and point-to-

point messaging. The words in italics in the preceding process represent actual

JMS interface names. There are two different flavors of those interfaces, and

the flavor you use depends on if you’re using publish/subscribe or point-to-

point. See Table 9.1 for a list.

As you can see from Table 9.1, point-to-point

  

  

explain the figure too

## Gemini said

Bhai, ye Chapter 9 ka jo section hai, ye Unit 4 ka sabse "Technical" part hai. Isme bataya gaya hai ki code ke through JMS (Java Message Service) kaise kaam karta hai.

RMI-IIOP mein hum seedha Bean ko call karte the, lekin JMS mein ek poori chain (pipeline) banti hai. Figure 9.3 isi pipeline ko dikhata hai. Chalo isse ekdum simple steps mein samajhte hain.

---

### **1\. Figure 9.3 ka Breakdown (The JMS Pipeline)**

Is diagram ko ek **"Water Supply System"** ki tarah socho. Paani (Message) ko bhejane ke liye tumhe pipes, pumps aur tanks chahiye hote hain.

- **Step 1: JNDI Lookup (Connection Factory):** Sabse pehle client JNDI (Phonebook) mein dekhta hai ki JMS Driver kahan hai. Use **Connection Factory** milti hai. Ye factory wo machine hai jo "Connections" paida karti hai.
- **Step 2: Create Connection:** Factory ka use karke ek **JMS Connection** banaya jata hai. Ye server aur client ke beech ka physical rasta (pipe) hai.
- **Step 3: Create Session:** Connection ke andar ek **Session** banta hai. Session ek "Helper" hai jo messages ko pack karne aur transactions sambhaalne ka kaam karta hai.
- **Step 4: Lookup Destination (JNDI):** Client fir se JNDI mein dekhta hai ki message bhejna kahan hai? Use **Destination** (Queue ya Topic) ka address milta hai.
- **Step 5: Create Producer/Consumer:** Session aur Destination ko mila kar ek **Producer** (Message bhejane wala) ya **Consumer** (Message lene wala) banaya jata hai.
- **Step 6: Send/Receive:** Producer message ko Queue mein daal deta hai, ya Consumer Queue se message nikaal leta hai.

---

### **2\. Point-to-Point vs Publish/Subscribe (The Two Flavors)**

Tumne Table 9.1 ka zikr kiya, usme do main styles hote hain messaging ke:

#### **A. Point-to-Point (PTP) - Queues**

- **Logic:** Ye **One-to-One** hota hai. Jaise tumne kisi ko personal SMS bheja.
- **Destination:** Isse **Queue** kehte hain.
- **Rule:** Message queue mein tab tak rehta hai jab tak koi use read na kar le. Ek message sirf **ek hi** consumer ko milta hai.

#### **B. Publish/Subscribe (Pub/Sub) - Topics**

- **Logic:** Ye **One-to-Many** hota hai. Jaise Radio broadcast ya YouTube notification.
- **Destination:** Isse **Topic** kehte hain.
- **Rule:** Ek "Publisher" message bhejta hai aur jitne bhi log us topic ke "Subscribers" hain, un sabko wo message ek saath mil jata hai.

---

### **3\. JMS Interface Names (Jo exam mein likhne hain)**

| Interface Type | Point-to-Point (Queue) | Publish/Subscribe (Topic) |
| --- | --- | --- |
| **Connection Factory** | `QueueConnectionFactory` | `TopicConnectionFactory` |
| **Connection** | `QueueConnection` | `TopicConnection` |
| **Session** | `QueueSession` | `TopicSession` |
| **Destination** | `Queue` | `Topic` |
| **Producer** | `QueueSender` | `TopicPublisher` |
| **Consumer** | `QueueReceiver` | `TopicSubscriber` |

---

### **Hinglish Summary for Exam:**

Bhai, agar exam mein JMS ka flow pucha jaye, toh Figure 9.3 draw kar dena.

1. **Connection Factory** dhoondo (JNDI se).
2. **Connection** banao (Physical link).
3. **Session** banao (Context/Transaction ke liye).
4. **Destination** (Queue/Topic) dhoondo.
5. **Producer/Consumer** banao.
6. **Message** bhejo ya receive karo.

Ye poora system **Asynchronous** hai, isliye client ko wait nahi karna padta.

Aage chalein? Ab shayad **Message-Driven Beans (MDB)** ki coding aayegi jo in messages ko automatically process karti hain.

You said

What Is a Message-Driven Bean?

A message-driven bean, introduced in EJB 2.0, is a special EJB component that

can receive JMS messages as well as other types of messages. See the sidebar

Pluggable Message Providers to find out more about how message-driven beans

can be used to consume messages other than JMS. A message-driven bean is

invoked by the container upon arrival of a message at the destination or end-

point that is serviced by message-driven bean. A message-driven bean is

Introduction to Message-Driven Beans 227

228 Chapter 9

PLUGGABLE MESSAGE PROVIDERS

A message-driven bean can be defined to consume messages of a given

messaging type in accordance with the message listener interface it employs,

that is JMS-based message-driven beans will implement the javax.jms.

MessageListener interface and so on. In EJB 2.0, message-driven beans

supported consumption of JMS messages only. You could not receive non-JMS

messages, such as asynchronous enterprise information system–specific

message. This has changed in EJB 2.1 standard so that the message-driven bean

can employ different listener interfaces to consume different message types in

addition to JMS.

This is achieved with the help of J2EE Connector Architecture 1.5. Connector

architecture defines message inflow contracts to enable resource adapters to

asynchronously deliver messages to message endpoints residing in the

application server independent of the specific messaging type or messaging

semantics. So in practice, we can write resource adapters that act as

message providers. Resource adapters are standard J2EE components and

hence, can be plugged into any J2EE compliant application server. As a

result, resource adapters capable of delivering messages to message

endpoints, such as message-driven beans, can be plugged into any J2EE-

compliant application server as well. This is widely known as message

provider pluggability.

For example, imagine a scenario where you want your EJB application to

receive EbXML messages. Using JAX-RPC is not a choice here since it supports

only SOAP 1.1 messages. Besides, JAX-RPC does not support asynchronous

messaging. In this case, connector architecture–based message providers/

resource adapters can be extremely handy. We can write an EbXML message

provider using connector architecture such that it provides a specific messaging

listener interface say, com.xyz.messaging.EbXMLMessageListener, which can be

implemented by message-driven beans so as to enable their receiving EbXML

messages.

This is a powerful concept—any enterprise information system can effectively

send any type of messages to a message-driven bean endpoint via J2EE

connector architecture-based resource adapter. All message providers from EJB

2.1 onwards, regardless of whether they consume JMS messages or not, are

resource adapters based on J2EE Connector Architecture 1.5. In Chapter 17 we

discuss J2EE connector architecture and provide guidance toward developing

resource adapters that consume messages.

decoupled from any clients that send messages to it. A client cannot access a

message-driven bean through a component interface. You will have to use message

provider–specific API, such as JMS, to send messages from clients, which in

turn would be received by the message-driven beans (see Figure 9.4).

Figure 9.4 A client calling JMS message-driven beans.

The following are some major characteristics of message-driven beans.

■■ A message-driven bean does not have a home interface, local home

interface, remote interface, or a local interface. You do not call mes-

sage-driven beans using an object-oriented remote method invocation

interface. The reason is that message-driven beans process messages,

and those messages can come from any messaging client, such as an

MQSeries client, an MSMQ client, a message provider/resource adapter,

or a J2EE client using the JMS API. Message-driven beans, along with

appropriate message providers, can thus consume any valid message.

■■ Message-driven beans have weakly typed business method. Message-

driven beans are merely receiving messages from a destination or a

resource adapter and they do not know anything about what’s inside

the messages. The listener interface implemented by message-driven

beans typically has a method (or methods) called by an EJB container

upon arrival of a message or by the resource adapter (via application

server). JMS message listener interface, javax.jms.MessageListener has

EJB Server

Message-Driven

Bean Pool

The EJB container is a

consumer of messages

from JMS

Destination as

specified by the deployer

in the deployment

descriptor.

Message-Driven

Bean Instances

JMS DestinationClient

Sends /

Publishes

Introduction to Message-Driven Beans 229

only one method called onMessage(). This method accepts a JMS Message,

which could represent anything—a BytesMessage, ObjectMessage,

TextMessage, StreamMessage, or MapMessage. In a typical implementation

of onMessage(), the message is cracked open at runtime and its contents

are examined, perhaps with the help of a bunch of if statements. In for-

mal terms, you don’t get compile-time type-checking of messages that

are consumed; rather, you need to use the instanceof operator to deter-

mine the exact type of a consumed message at runtime. This also means

that you need to be careful to make sure the message you receive is

intended for you. In comparison, session or entity beans can support

strongly typed business methods. Type checking can be performed at

compile time to ensure that clients are properly using a given interface.

■■ Message-driven bean listener method(s) might not have any return

values. Although EJB 2.1 specification does not restrict a message-

driven bean listener method from returning a value to the client, certain

messaging types might not be suitable for this. For example, consider

the listener interface of a messaging type that supports asynchronous

messaging, such as JMS. In this case, due to the asynchronous interac-

tion between message producers and consumers, the message produc-

ers don’t wait for your message-driven bean to respond. As a result, it

doesn’t make sense for the onMessage() listener method on the

javax.jms.MessageListener interface to return value. The good news is

that using several design patterns, it is possible to send a response to an

asynchronous message producer. We discuss this later in this chapter.

■■ Message-driven beans might not send exceptions back to clients.

Although, EJB 2.1 does not restrict message-driven bean listener interface

methods from throwing application exceptions, certain messaging types

might not be able to throw these exceptions to the clients. Again consider

the example of a listener interface of a messaging type that supports asyn-

chronous messaging, such as JMS. In this case, message producers won’t

wait for your message-driven bean to send a response because the interac-

tion is asynchronous. Therefore clients can’t receive any exceptions. All

message listener interfaces, however, can generate system exceptions

regardless of the messaging semantics (synchronous versus asynchronous)

because the container (rather than the client) handles system exceptions.

■■ Message-driven beans are stateless. Message-driven beans hold no con-

versational state. It would be impossible to spread messages across a clus-

ter of message-driven beans if a message-driven bean held state. In this

sense, they are similar to stateless session beans because the container can

similarly treat each message-driven bean instance as equivalent to all other

instances. All instances are anonymous and do not have an identity that is

visible to a client. Thus, multiple instances of the bean can process multi-

ple messages from a JMS destination or a resource adapter concurrently

## Gemini said

Bhai, ab hum Unit 4 ke sabse interesting part par hain: **Message-Driven Beans (MDB)**.

Abhi tak tumne Session aur Entity beans padhi hain, jahan client direct bean ko "Call" karta tha (jaise tum kisi ko phone karke baat kar rahe ho). MDB bilkul alag hai—ye **"Post Box"** ki tarah kaam karti hai. Client message box mein daal deta hai, aur MDB aaram se use nikaal kar process karti hai.

Isko Figure 9.4 aur book ke points ke saath deeply samajhte hain.

---

### **1\. Message-Driven Bean (MDB) Kya Hai?**

MDB ek aisa EJB component hai jo JMS (ya doosre types ke) messages ko consume karne ke liye banaya gaya hai.

- **Decoupled (Alag-alag):** Client aur MDB ek doosre ko nahi jaante. Client ko bas **Destination (Queue/Topic)** ka pata hota hai.
- **No Interfaces:** MDB ki sabse badi pehchaan ye hai ki isme **Home, Remote, ya Local interfaces nahi hote**. Tum ise direct call nahi kar sakte. Ise sirf "Message" ke zariye trigger kiya ja sakta hai.

---

### **2\. MDB ki Major Characteristics (Exam ke liye Points)**

#### **A. Weakly Typed Business Methods**

Session beans mein tum `withdraw(100)` jaisa fixed method call karte the (Strongly Typed). Lekin MDB mein sirf ek standard method hota hai: **`onMessage(Message msg)`**.

- **Problem:** MDB ko pehle se nahi pata ki message ke andar kya hai (Text hai, Object hai, ya Bytes).
- **Solution:** Aapko `onMessage` ke andar `instanceof` use karke check karna padta hai ki ye `TextMessage` hai ya kuch aur, phir use "Crack open" (kholna) padta hai.

#### **B. Asynchronous Nature (No Return Values/Exceptions)**

Kyunki client message bhej kar chala gaya hai (Fire-and-forget), isliye MDB client ko kuch **Return** nahi kar sakti.

- Agar MDB mein koi error (Application Exception) aayi, toh client ko pata hi nahi chalega kyunki wo tab tak disconnected hota hai.
- System exceptions ko Container handle karta hai, client nahi.

#### **C. MDBs are Stateless (Memory-less)**

Ye **Stateless Session Beans** ki tarah hoti hain.

- Inki koi "Yaaddaash" (Conversational State) nahi hoti. Har message ek naya fresh start hota hai.
- **Benefit:** Is wajah se Container inka **Pool** bana sakta hai. Agar ek saath 100 messages aaye, toh Container 100 MDB instances ko ek saath kaam pe laga sakta hai (**Concurrent Processing**).

---

### **3\. Pluggable Message Providers (The Sidebar Logic)**

EJB 2.0 tak MDB sirf JMS messages leti thi. Lekin EJB 2.1 ke baad ye **J2EE Connector Architecture (JCA)** use karti hai.

- **Matlab:** Ab MDB sirf JMS hi nahi, balki EbXML ya kisi purane (Legacy) system ke messages bhi receive kar sakti hai.
- Bas ek "Resource Adapter" (Driver) ki zaroorat hoti hai jo un messages ko MDB tak pahuncha sake.

---

### ** Quick Comparison (Session vs MDB)**

| Feature | Session Bean | Message-Driven Bean (MDB) |
| --- | --- | --- |
| **Interfaces** | Remote/Local/Home required. | None. |
| **Client Interaction** | Synchronous (Direct call). | Asynchronous (Via Destination). |
| **State** | Stateless or Stateful. | **Always Stateless.** |
| **Method** | Multiple business methods. | Only `onMessage()`. |

---

### **Summary of Figure 9.4:**

Diagram mein dekho—Client message bhej raha hai **JMS Destination** ko. **EJB Container** use Destination se nikaal raha hai aur Pool mein se ek **MDB Instance** ko de raha hai. Client aur MDB ke beech koi direct line nahi hai.

Bhai, ye concept clear hai? Agar haan, toh hum MDB ki coding (kaise class likhte hain aur deployment descriptor mein kya likhte hain) par move kar sakte hain. Isme `onMessage` hi sabse bada player hai!

You said

oison Messages

When using container-managed transactions (see Chapter 12) with a JMS

message-driven bean, it is easy to code yourself into a situation that causes the

generation of poison messages. A poison message is a message that is continu-

ally retransmitted by a JMS destination to the consumer because the consumer

continuously fails to acknowledge the consumption of the message. Any time

your JMS message-driven bean does not acknowledge messages to the JMS

destination, you have a situation with the potential to create poison messages.

See Figure 9.7 to see a diagram indicating how poison messages can inadver-

tently be generated.

246 Chapter 9

USING QUEUES TO PARTITION BUSINESS PROCESSING IN A CLUSTER

Suppose you have two clusters of machines: One cluster is configured for a

development and test environment, and the other cluster is configured for a

production environment. You need to make sure that traffic coming from test

clients is sent to the development cluster, while traffic coming from real clients

is sent to the production cluster.

As one solution, you could set up your JMS server with two queues:

DevelopmentQueue and ProductionQueue. You could deploy a series of JSPs or

front-end stateless session beans that analyze each incoming request, format it

into a JMS message, and then place requests onto one of the queues. Requests

that come from an internal development machine could be placed onto the

DevelopmentQueue, and all other requests could be placed on the

ProductionQueue.

On the back end, you could configure two clusters: One cluster has JMS

message-driven beans bound to the DevelopmentQueue, and the other cluster

has JMS message-driven beans bound to the ProductionQueue. The logic for

each of these beans can vary based on the needs of the system. For example,

the behavior of the JMS message-driven beans bound to the

DevelopmentQueue can mimic those bound to the ProductionQueue but add

on debugging statements. You can also tune each cluster independently based

on load to the system. Since the ProductionQueue will likely have more load

than the DevelopmentQueue, you could independently grow the size of the

cluster servicing the ProductionQueue without impacting the cluster servicing

the DevelopmentQueue.

This illustrates a general paradigm of using queues to partition business

logic processing. Rather than the servers pulling messages off a single queue,

you pre-choose which machines get the messages by splitting the queue into

two queues. This is an artificial way to achieve controlled load-balancing in a

JMS system.

Figure 9.7 How JMS message-driven beans can cause poison messages.

For example, suppose you have a stock-quoting JMS message-driven bean

that accepts a text message, which represents the stock ticker symbol to be

quoted. Your bean cracks open that message. If the string contained within the

message matches a stock symbol, the bean retrieves the value of that symbol

and sends a response message. Otherwise, the bean throws a system exception

or calls MessageDrivenContext.setRollbackOnly(). This causes the transaction to

be rolled back, which means the message acknowledgment will never be sent

to the JMS destination. The JMS destination eventually resends the same mes-

sage to the container, causing this same process to occur.

See Source 9.4 for an example of a JMS message-driven bean implementa-

tion class that will cause a poison message scenario. Note that our abuse of

threading is for illustrative purposes only!

## Gemini said

Bhai, ye Chapter 9 ka ek bahut hi "dangerous" aur practical concept hai: **Poison Messages**. Exam mein ye short note ya "Transaction Management in MDB" ke under pucha jata hai.

Isko ekdum simple logic se samajhte hain.

---

### **1\. What is a Poison Message? (The Definition)**

Poison message wo bad-luck message hai jo loop mein fans jata hai.

- **Hinglish Logic:** Socho ek message MDB ke paas aaya. MDB ne use process karne ki koshish ki par code mein error aa gaya ya transaction fail ho gaya.
- Kyunki transaction **Rollback** ho gaya, JMS Server (Destination) ko laga ki "Oh, message deliver nahi hua".
- Server wo message **phir se** bhejta hai. MDB phir se fail hoti hai. Server phir bhejta hai... ye loop chalta rehta hai. Ise hi "Poison Message" kehte hain kyunki ye system ke resources (CPU/RAM) ko "zeher" ki tarah khatam kar deta hai.

---

### **2\. How it happens (Figure 9.7 Logic)**

Book ne Stock Quoting bean ka example diya hai:

1. Client ne ek ticker symbol bheja (e.g., "AAPL").
2. MDB ne message khola. Agar symbol galat hai, toh MDB ne **System Exception** throw kar di ya `setRollbackOnly()` call kar diya.
3. **The Result:** Transaction rollback ho gaya. JMS Destination ko "Acknowledge" (receipt) nahi mili.
4. JMS Destination wahi message dobara bhej dega.
5. MDB wapas wahi symbol dekhegi, phir se fail hogi. **Boom! Infinite Loop.**

---

### **3\. Partitioning Business Processing (The Cluster Solution)**

Book mein ek "Box" hai jo batata hai ki Queues ko use karke hum clustering kaise manage karte hain.

- **Scenario:** Tumhare paas do environment hain—**Development** (Test) aur **Production** (Real).
- **The Architecture:** \* Tum do alag-alag queues banate ho: `DevelopmentQueue` aur `ProductionQueue`.
	- Front-end (JSP/Servlet) check karta hai ki request kahan se aa rahi hai. Agar internal developer hai, toh message `DevelopmentQueue` mein daal deta hai.
		- Back-end par do clusters hote hain. Ek cluster sirf test messages process karta hai, doosra sirf real production messages.

**Fayda:** Isse "Load Balancing" control mein rehti hai. Agar Production par traffic badh jaye, toh tum sirf Production wala cluster bada kar sakte ho bina Test environment ko chede.

---

### **4\. Key Takeaways for Exams**

- **MDB is Stateless:** Isliye wo har message ko naya maanti hai. Use nahi pata ki ye wahi "Poison Message" hai jo pehle fail hua tha.
- **Dead Letter Queue (DLQ):** (Ye book ke is part mein hint kiya gaya hai aage)—Is problem ka solution ye hota hai ki agar ek message 5-10 baar fail ho jaye, toh JMS server use ek special "Dead Letter Queue" mein daal de taaki loop toot sake.
- **Fire-and-Forget:** Messaging asynchronous hai, isliye client ko kabhi pata hi nahi chalta ki uska message loop mein fasa hua hai.

---

### ** Final Comparison for your revision:**

| Topic | Key Point |
| --- | --- |
| **Poison Message** | Continuous rollback  $$ → $$  continuous retransmission. |
| **Rollback Cause** | System Exception or `setRollbackOnly()`. |
| **Queue Partitioning** | Splitting traffic into different queues for different server clusters. |

Bhai, Chapter 9 (MDB) yahan finish hota hai. Unit 4 ka major part cover ho gaya hai. Ab batao, kya main **Unit 5 (Transactions and Security)** ya **Unit 1 (RMI/JNDI revision)** ki taraf badhu?

Tumhare exams 2026 mein hain, toh humare paas concepts ko deep dive karne ka achha waqt hai!

You said

  

3\. Your application purchases a balloon ride ticket from London, England,

to Paris, France.

4\. Your application finds out that there are no outgoing flights from France.

This is the famous trip-planning problem. If this sequence of bookings were

performed under a flat transaction, your application would have only one

option: to roll back the transaction. Thus, because there are no outgoing flights

from France, your application has lost all of its bookings! But it may be possi-

ble to use another means of transportation out of France, allowing you to sal-

vage the train ticket, plane ticket, and balloon ride. Thus, a flat transaction is

insufficient. The all-or-nothing proposition is shooting us in the foot, and we

need a more comprehensive transactional model.

A nested transaction solves this problem. A nested transaction enables you to

embed atomic units of work within other units of work. The unit of work that

is nested within another unit of work can roll back without forcing the entire

transaction to roll back. Therefore the larger unit can attempt to retry the

embedded unit of work. If the embedded unit can be made to succeed, the

larger unit can succeed. If the embedded unit of work cannot be made to work,

it will ultimately force the entire unit to fail.

You can think of a nested transaction as a tree of transactions, all spawning

off one root- or top-level transaction. The root transaction is the main transaction:

In our trip-planning example, the root transaction is the overall process of

booking tickets around the world. Every other transaction in the tree is called

a subtransaction. The subtransactions can be flat or nested transactions (see

Figure 12.4).

Figure 12.4 The nested transaction.

Transaction

Occurring

H

Begin Transaction

Initial State

(No Transaction Occurring)

H

Final State

(Transaction Rolled Back)

If All Goes Well, Commit Transaction

H

Final State

(Transaction Succeeded)

If Problem Occurs, Abort Transaction

Perform One or More

Smaller-Grained Transactions

The smaller-grained

transactions can be retried

without affecting the main

transaction.

Transactions 309

  

What’s special about nested transactions is that subtransactions can inde-

pendently roll back without affecting higher transactions in the tree. That’s a

very powerful idea, and it solves our trip-planning problem: If each individual

booking is a nested transaction, we can roll back any one booking without can-

celing all our other reservations. But in the end, if the nested transaction

cannot be committed, the entire transaction will fail.

Other Transactional Models

This concludes our discussion of transactional models. There are other models

as well, such as chained transactions and sagas, but we will not address these

subjects here because the EJB specification does not support them. And

because the EJB specification does not currently mandate support for nested

transactions, for the rest of this chapter we’ll assume that our transactions

are flat.

Enlisting in Transactions with Enterprise JavaBeans

Let’s apply what we’ve learned so far about transactions to the EJB world.

Enterprise beans can be transactional in nature. This means they can fully

leverage the ACID properties to perform reliable, robust server-side opera-

tions. Thus, enterprise beans are ideal modules for performing mission-critical

tasks.

Underlying Transaction System Abstraction

In EJB, your code never gets directly involved with the low-level transaction

system. Your enterprise beans never interact with a transaction manager or a

resource manager. You write your application logic at a much higher level,

without regard for the specific underlying transaction system. The low-level

transaction system is totally abstracted out by the EJB container, which runs

behind the scenes. Your bean components are responsible for simply voting on

whether a transaction should commit or abort. If things run smoothly, you

should commit; otherwise, abort.

Declarative, Programmatic, and

Client-Initiated Transactions

Throughout this chapter, we’ve said that once a transaction begins, it ends

with either commit or abort. The key piece of information we’re lacking is who

begins a transaction, who issues either a commit or abort, and when each of

310 Chapter 12

  

these steps occurs. This is called demarcating transactional boundaries. You can

demarcate transactions programmatically, declaratively, or client-initiated.

Programmatic Transactions

Most existing systems demarcate transactional boundaries programmatically.

When using programmatic transactions, you are responsible for programming

transaction logic into your application code. That is, you are responsible for

issuing a begin statement and either a commit or an abort statement.

For example, an EJB banking application might have an enterprise bean

that acts as a bank teller. A teller bean would expose a method to transfer

funds from one bank account to another. With programmatic transactions, the

teller bean is responsible for issuing a begin statement to start the transaction,

performing the transfer of funds, and issuing either a commit or abort state-

ment. This is the traditional way to perform transactions, and it is shown in

Figure 12.5.

Figure 12.5 Beans with programmatic transactions.

Teller Bean Transaction

Service

3: Call begin()

4: Perform Business Operations

5: Call commit() or abort()

Client Code

1: Call Method

EJB Container/Server

Teller EJB

Object

2: Delegate

Transactions 311

  

Declarative Transactions

Declarative transactions allow for components to automatically be enlisted in

transactions. That is, your enterprise beans never explicitly issue a begin, commit,

or abort statement. The EJB container performs it for you.

Let’s take our bank teller example again, and assume some client code has

called our teller bean to transfer funds from one account to another. With

declarative transactions, the EJB container intercepts the request and starts a

transaction automatically on behalf of your bean. That is, the container issues

the begin statement to the underlying transaction system to start the trans-

action. The container then delegates the invocation to your enterprise bean,

which performs operations in the scope of that transaction. Your bean can do

anything it wants to, such as perform logic, write to a database, send an asyn-

chronous message, or call other enterprise beans. If a problem occurs, the bean

can signal to the container that the transaction must abort. When the bean

is done, it returns control to the container. The container then issues either a

commit or abort statement to the underlying transaction system, depending on

whether a problem occurred. This is a very simple model, and it is shown in

Figure 12.6.

Figure 12.6 Beans with declarative transactions.

Teller Bean

2: Call begin()

4: Perform Business Operations

5: Call commit() or abort()

Client Code

1: Call Method

EJB Container/Server

3: Delegate

Transaction

Service

Teller EJB

Object

312 Chapter 12

  

EJB declarative transactions add huge value to your deployments because

your beans may not need to interact with any transaction API. In essence, your

bean code and your client are not even really aware of transactions happening

around them.

So how do you instruct the container about whether your bean is using

declarative or programmatic transactions? EJB enables you to specify how

your enterprise bean is enrolled in a transaction through the deployment

descriptor, as follows:

<?xml version=”1.0” encoding=”UTF-8”?>

<ejb-jar xmlns=http://java.sun.com/xml/ns/j2ee

xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance

xsi:schemaLocation=”http://java.sun.com/xml/ns/j2ee

http://java.sun.com/xml/ns/j2ee/ejb-jar\_2\_1.xsd”

version=”2.1”>

<enterprise-beans>

<session>

<ejb-name>Hello</ejb-name>

<home>examples.HelloHome</home>

<remote>examples.Hello</remote>

<ejb-class>examples.HelloBean</ejb-class>

<session-type>Stateless</session-type>

<transaction-type>Container</transaction-type>

</session>

</enterprise-beans>

</ejb-jar>

The preceding deployment descriptor chooses container-managed (declara-

tive) transactions. If instead of Container we chose Bean, then we would use

bean-managed (programmatic) transactions.

Client-Initiated Transactions

The final way to perform transactions is to write code to start and end the

transaction from the client code outside of your bean. For example, if you have

a servlet, JSP tag library, application, applet, CORBA client, or other enterprise

bean as a client of your beans, you can begin and end the transaction in that

client. This is shown in Figure 12.7.

Note that the enterprise bean the client calls would still need to be written to

use either programmatic or declarative transactions.

Transactions 313

  

Figure 12.7 Beans with client-initiated transactions.

Choosing a Transaction Style

One question that students often ask in our EJB training classes is “Should I

use declarative, programmatic, or client-controlled transactions?”

The benefit of programmatic transactions is that your bean has full control

over transactional boundaries. For instance, you can use programmatic trans-

actions to run a series of mini-transactions within a bean method. In compari-

son, with declarative or client-initiated transactions, your entire bean method

must either run under a transaction or not run under a transaction.

The benefit of declarative transactions is that they are simpler. You don’t

need to write transactional logic into your bean class, which saves coding time

and enables you to tune transactions without having access to source code.

Also, by having transactions automatically start up and end, you keep client

code from misusing your beans. If you’re a component vendor, this will reduce

a great number of headaches down the line.

Teller Bean

1: Call begin()

4: Perform Business Operations

5: Call commit() or abort()

2: Call Method

EJB Container/Server

3: Delegate

Transaction

Service

Client Code

Teller EJB

Object

314 Chapter 12

  

To understand the benefit of client-controlled transactions, consider the fol-

lowing scenario in which we don’t use client-controlled transactions. Imagine

that a non-transactional remote client calls an enterprise bean that performs its

own transactions (either programmatically or declaratively). The bean suc-

ceeds in the transaction, but the network or application server crashes before

the result is returned to a remote client. The remote client would receive a Java

RMI RemoteException indicating a network error, but would not know whether

the transaction that took place in the enterprise bean was a success or a failure.

The remote client would then have to write code to check the state of the

resources to find out whether they were updated successfully by the transac-

tion. This code places an additional burden on the application developer.

Transactions 315

TRANSACTIONS AND ENTITY BEANS

Perhaps one of the most misunderstood concepts in EJB is how transactions

relate to entity beans. Let’s explore this concept.

When you call an entity bean in a transaction, the first action that happens is

the entity bean needs to load database data through the ejbLoad() method,

which acquires locks in the database and ensures the entity bean cache is

consistent. Then one or more business methods are called. When the

transaction is committed, the entity bean’s ejbStore() method is called, which

writes all updates to the database and releases the locks. A transaction should

thus span the ejbLoad() business methods, and the final ejbStore(), so that if

any one of those operations fail, they all fail.

If we were to use bean-managed transactions, we would write code to

perform begin() and commit() methods inside our bean (perhaps around the

JDBC code). Perhaps we would start the transaction in ejbLoad(), and then

commit the transaction in ejbStore(). The problem, though, is that you do not

call your own ejbLoad() or ejbStore() methods—the container does. The bean

cannot enforce that these methods happen in this order, if at all. Therefore if

you started a transaction in ejbLoad(), the transaction may never complete.

Because of this, bean-managed transactions are illegal for entity beans.

Entity beans must use declarative transactions. Session beans or message-

driven beans can use bean-managed transactions because a session bean can

load database data, perform operations on that data, and then store that data;

all in a single method call, and thus is in direct control over the transaction.

A corollary of this discussion is that entity beans do not load and store their

data on every method call; rather, they load and store their data on every

transaction. If your entity beans are not performing well, it could be because a

transaction is happening on each method call, and thus a database read/write

is happening on every get/set method. The solution is to make sure your

transactions begin earlier and end later, perhaps encompassing many entity

bean method calls. By properly controlling the duration of your transactions

with transaction attributes (as we will see later in this chapter), you can control

when database reads and writes happen with entity beans.

  

With client-controlled transactions, you do not need to worry about this sce-

nario, because the transaction is defined in the client code. If anything goes

wrong, the client will know about it. The downside to client-controlled trans-

actions is that for distributed applications, the chances of client-initiated trans-

action rollbacks are more due to the fact that the transaction is occurring over

a network and hence, network failures can cause the transaction to roll back

more often. Because of this, use client-transactions sparingly—especially if the

client is far away

## Gemini said

Bhai, ab hum sach mein EJB aur backend systems ke sabse core (aur tumhare DBMS background ke hisaab se sabse relatable) topic par aa gaye hain: **Transactions (Unit 5)**.

Database mein tumne ACID properties (Atomicity, Consistency, Isolation, Durability) padhi hongi. EJB mein ye sab apply hota hai, par architecture ke level par. Is chapter mein bataya gaya hai ki Transactions ko *control kaun karega* aur *kaise karega*.

Chalo isko bina kisi fluff ke, exam ke point of view se todte hain.

---

### **1\. Flat vs Nested Transactions (The Trip-Planning Problem)**

EJB Transactions ko samajhne se pehle book ne ek real-world problem di hai:

- **Flat Transaction (All-or-Nothing):** Tumne London se Paris ka balloon ticket liya, aur phir Paris se aage ki flight book ki. Agar flight cancel ho gayi, toh *poora* transaction roll back ho jayega (yaani balloon ticket bhi cancel ho jayega). Complex backend systems mein ye achhi approach nahi hai.
- **Nested Transaction (The Tree):** Isme ek "Main (Root) Transaction" hota hai, aur uske andar chhote "Sub-transactions" hote hain. Agar Paris wali flight (sub-transaction) fail hoti hai, toh sirf wahi roll back hogi. Main transaction zinda rahega aur kisi doosri flight ya train ka sub-transaction try kar lega. ** EXAM CATCH:** Book clear karti hai ki EJB specification formally **Nested Transactions support nahi karta**. EJB mein aamtaur par hum **Flat Transactions** hi use karte hain.

---

### **2\. The 3 Ways to Control Transactions in EJB**

EJB mein humein low-level resource manager (jaise raw JDBC commit/rollback) khud nahi likhna padta. EJB Container ek abstraction deta hai. Ise handle karne ke 3 tareeke (Demarcation boundaries) hote hain:

#### **A. Programmatic Transactions (Bean-Managed Transactions - BMT)**

- **Hinglish Logic:** Developer khud code ke andar transaction shuru aur khatam karta hai.
- **Kaise?** Tum bean class ke andar `begin()`, `commit()`, aur error aane par `abort()` (ya rollback) call karte ho.
- **Fayda:** Tumhare paas full control hota hai. Tum ek method ke andar chhote-chhote mini-transactions chala sakte ho. (Session Beans aur MDBs ise use kar sakte hain).

#### **B. Declarative Transactions (Container-Managed Transactions - CMT)**

- **Hinglish Logic:** Tum koi code nahi likhte! Tumhara Container tumhare liye transaction handle karta hai. \* **Kaise?** XML Deployment Descriptor (`ejb-jar.xml`) mein tum likh dete ho `<transaction-type>Container</transaction-type>`. Jab client method call karta hai, Container pehle transaction `begin` karta hai, method run karta hai, aur end mein khud `commit` kar deta hai.
- **Fayda:** Code ekdum saaf rehta hai aur client ajeeb tarike se method call karke tumhara database corrupt nahi kar sakta. (Ye CMP ki tarah hai, bas transactions ke liye).

#### **C. Client-Initiated Transactions**

- **Hinglish Logic:** Transaction ka remote-control EJB server ke paas nahi, balki Client (jaise JSP, Servlet, ya React frontend ke pichhe wale Controller) ke paas hota hai.
- **Fayda/Nuksan:** Agar network tut gaya, toh client ko exactly pata hoga ki transaction fail hua hai. Par distributed systems (internet) par network drops aam baat hai, isliye isko avoid karna chahiye, warna baar-baar faaltu rollbacks honge.

---

### **3\. THE GOLDEN RULE: Transactions and Entity Beans**

Ye book ka sabse misunderstood aur exams mein sabse zyada pucha jaane wala question hai (The Sidebar box in the text).

- **Question:** *Kya hum Entity Beans (BMP/CMP) mein Programmatic Transactions (BMT) use kar sakte hain?*
- **Answer:** **STRICTLY NO. It is illegal.**

**Kyun? (The Logical Proof):** Yaad karo Entity Bean ka life cycle (BMP wale chapter se):

1. Container `ejbLoad()` call karta hai (DB se data RAM mein aata hai).
2. Client business method (jaise `deposit()`) call karta hai.
3. Container `ejbStore()` call karta hai (RAM se data DB mein save hota hai).

Agar tum Programmatic transaction use karoge, toh tum shayad `ejbLoad()` mein `begin()` likh do aur sochoge ki `ejbStore()` mein `commit()` karunga. **Par `ejbLoad` aur `ejbStore` tum call nahi karte, Container call karta hai!** Tumhe pata hi nahi chalega ki transaction kab close karna hai. Isliye, Entity Beans **hamesha Declarative (Container-Managed) Transactions hi use karti hain.**

---

### **The Grand Connection (Putting Unit 3, 4, 5 Together)**

Bhai, apni ab tak ki saari EJB knowledge ko is table mein map kar lo. Tumhara backend architecture ka dimaag ekdum clear ho jayega:

| Component Type | Persistence Style | Transaction Style Allowed |
| --- | --- | --- |
| **Stateless Session Bean** | None (No DB data). | Programmatic OR Declarative. |
| **Message-Driven Bean (MDB)** | None (Takes from Queue). | Programmatic OR Declarative. |
| **Entity Bean (BMP)** | You write SQL (`ejbLoad`/`Store`). | **Declarative ONLY.** |
| **Entity Bean (CMP)** | Container writes SQL. | **Declarative ONLY.** |

**Summary for Exam:**

- BMT (Programmatic) = Code flexibility, manual `begin/commit`.
- CMT (Declarative) = XML flexibility, automatic, safe.
- Flat Transactions = Default in EJB.

Batao, BMT vs CMT ka ye logic tumhare DBMS concepts ke saath fit baith gaya? Unit 5 mein isi ka aage detail aayega ki "Transaction Attributes" (`Required`, `RequiresNew`) kya hote hain. Agar ye base clear hai toh hum aage badhein!

You said

  

1:1 Relationships

In a one-to-one relationship, each constituent can have at most one relation-

ship with the other constituent. Examples of one-to-one relationships include:

■■ Person:Address

■■ Car:Windshield

■■ Order:Shipment

One-to-one relationships are typically set up by a foreign key relationship in

the database. Figure 15.2 shows a possible database setup.

In Figure 15.2, the order has a relationship with a shipment. The order table

has a foreign key, which is the shipment table’s primary key. This foreign key

is the link between the two tables. Note that this isn’t the only way to set up a

one-to-one relationship. You could also have the shipment point to the order.

412 Chapter 15

IMPLEMENTING RELATIONSHIPS IN SESSION BEANS

Session beans can perform persistence that involves relationships, just like

CMP and BMP entity beans can. If you are familiar with traditional procedural

programming, programming on the Microsoft platform, or programming that

involves servlets or JSP technology talking to a database via JDBC, the session

bean approach is quite analogous.

You can use a stateful session bean just like an entity bean; the only

difference is that with a stateful session bean, you expose methods to a client

for loading and storing data, and the client controls when the bean is loaded

and stored by calling those methods. In this case, all of the best practices for

relationship persistence that apply to BMP entity beans apply to stateful

session beans that use JDBC.

You can also use a stateless session bean to perform persistence that

involves relationships. Stateless session beans do not hold state and therefore

do not have an identity, so you can’t treat a stateless session bean like an

entity bean. You need to use the stateless session bean as a service to read and

write rows to and from the database, marshaling the state back to the client on

each method call. In essence, the stateless session bean serves as a stateless

persistence engine, and the relationship code needs to be custom coded.

In general, if you have complex relationships, we do not recommend the

session bean approach, due to all the manual coding. The entity bean value

proposition really shines through when it comes to relationships.

  

Figure 15.2 A possible one-to-one cardinality database schema.

Implementing 1:1 Relationships Using BMP

The following code shows how to implement a one-to-one relationship using

BMP:

public class OrderBean implements EntityBean {

private String orderPK;

private String orderName;

private Shipment shipment; // EJB local object stub

public Shipment getShipment() { return shipment; }

public void setShipment(Shipment s) { this.shipment = s;}

...

public void ejbLoad() {

// 1: SQL SELECT Order. This also retrieves the

// shipment foreign key.

//

// 2: JNDI lookup of ShipmentHome

//

// 3: Call ShipmentHome.findByPrimaryKey(), passing

// in the shipment foreign key

}

public void ejbStore() {

// 1: Call shipment.getPrimaryKey() to retrieve

// the Shipment foreign key

//

// 2: SQL UPDATE Order. This also stores the

// Shipment foreign key.

}

}

1010112345 Software Order

78727Austin10101

OrderPK OrderName

ShipmentPK City ZipCode

Shipment

ForeignPK

BMP and CMP Relationships 413

  

As with all BMP entity beans, we must define our SQL statements in our

bean. See Chapter 6 for more on this. The special relationship management

code is in bold.

The relationship management code is necessary only at the instant we trans-

form our bean to and from relational data. It is necessary because we can’t just

persist a stub, as we can with our other fields (such as a String). If we did per-

sist a stub, and (by some miracle) that worked, it would look like a bit-blob in

the foreign key column. That bit-blob foreign key would not match up to the

primary key in the shipment table.

Here is an explanation for what’s happening in our bean:

■■ Our ejbLoad() method loads the database data of the order, and part of

that data is a foreign key to the shipment. We need to transform that

foreign key into a stub to a shipment bean. Therefore we need to per-

form a JNDI lookup of the shipment home and then call a finder

method, passing in the foreign key. This gives us a stub, and we can

then call business methods on the shipment.

■■ Our ejbStore() method stores the database data for the order, and part of

that data is a foreign key to the shipment. We need to transform the ship-

ment stub into a foreign key. Therefore, we need to call getPrimaryKey()

on the shipment stub. This gives us our foreign key, and we can then per-

form the SQL.

## Gemini said

Bhai, ab hum EJB ke ek advance topic par aaye hain: **Relationships (Unit 5 / EJB Design Patterns)**.

Jaise tum DBMS mein ER diagrams aur Foreign Keys padhte ho, EJB mein bhi same concepts apply hote hain. Par EJB mein hum tables ke beech nahi, **Beans ke beech** relation banate hain. EJB 2.x mein CMP (Container-Managed Persistence) ne isko handle karne ka naya tareeka diya tha (CMP 2.0 Relationships), jise **CMR (Container-Managed Relationships)** kehte hain.

Chalo is text ko ekdum simple Hinglish aur exam point of view se todte hain.

---

### **1\. 1:1 Relationships ka Concept (The Basics)**

- **Hinglish:** Ek-ka-Ek rishta. Jaise ek Order ka ek hi Shipment hota hai, aur us Shipment ka ek hi Order hota hai.
- **Database Logic (Figure 15.2):** Database mein isko banane ka standard tareeka Foreign Key hota hai.
	- `Order` Table: `[OrderPK, OrderName, ShipmentPK (Foreign Key)]`
		- `Shipment` Table: `[ShipmentPK, City, ZipCode]`
		- *Notice:* Order table ke andar Shipment ka ID hai taaki pata chale ki ye order kis dibbe (shipment) mein jayega.

---

### **2\. Sidebar: Relationships in Session Beans**

Book ka ye special box (sidebar) ek practically important point batata hai:

- **Session Beans aur DB:** Kya Session Beans relationships (jaise join queries) perform kar sakti hain?
	- **Stateful Session Bean:** Haan, par bilkul BMP Entity bean ki tarah sara code manually likhna padega.
		- **Stateless Session Bean:** Ye database se baat kar sakti hai, par iski apni koi 'identity' nahi hoti. Toh ye JDBC use karke ek "Persistence Engine" ki tarah kaam karegi jo raw data (SQL Joins ka result) client ko wapas fekegi.
- **The Verdict:** Book strictly suggest karti hai ki **"Complex relationships ke liye Session Beans use mat karo."** Agar data ke beech complex relations hain (1:N, M:N), toh uske liye **Entity Beans (especially CMP)** bani hain. Ye design pattern/architecture rule hai.

---

### **3\. Implementing 1:1 Relationships using BMP (The Manual Way)**

Ye is page ka sabse important code snippet hai. Agar tum BMP (Bean-Managed Persistence) use kar rahe ho, toh tum Foreign Keys ko objects mein kaise badloge?

**The Problem:** Java objects (Beans) database ki tarah ID's se baat nahi karte, wo ek doosre ke "Reference" (EJB Local Object Stubs) se baat karte hain. Database mein Foreign Key "10101" (String) hai, par Java code mein tum chahte ho `Shipment s` (Object).

**The Solution (Step-by-step from the code):**

- **`ejbLoad()` (DB 
	$$
	→
	$$
	 RAM):** 1. Bean apne liye `SELECT` query fire karti hai. Use `Order` ka data aur `ShipmentPK` (jaise "10101") mil jata hai. 2. Ab is "10101" ko object banana hai. Bean JNDI se `ShipmentHome` uthati hai. 3. Phir wo call karti hai `ShipmentHome.findByPrimaryKey("10101")`. Ye us foreign key ko ek asli **Shipment Stub (EJB Object)** mein badal deta hai. Ab ye stub RAM mein save ho gaya (`this.shipment = s`).
- **`ejbStore()` (RAM 
	$$
	→
	$$
	 DB):**
	1. Bean ke paas memory mein `Shipment` ka stub (object) hai. Par object ko sidhe database mein `UPDATE` nahi maar sakte (wo garbage/bit-blob ban jayega).
		2. Bean us stub se pucha hai: "Bhai tera ID kya hai?" 
		$$
		→
		$$
		 `shipment.getPrimaryKey()`.
		3. Ab us ID (String) ko use karke `UPDATE Order SET foreignPK=? ...` wali SQL query fire hoti hai.

---

### **Summary for Exams (GATE/Syllabus)**

- **BMP mein Relationships:** Developer ko **Primary Key (String) 
	$$
	↔
	$$
	 Object Reference (Stub)** ka conversion manually `ejbLoad` aur `ejbStore` mein JNDI aur Home methods use karke likhna padta hai.
- Ye bahut lamba aur thakane wala (tedious) process hai, isiliye EJB 2.0 ne CMP CMR (Container-Managed Relationships) introduce kiya (jo hum aage padhenge), jahan XML se sab automatically ho jata hai.

Bhai, ye translation Samajh aayi? Object-Oriented duniya aur Relational duniya (Database) ko jodne ka ye hi core funda hai. Agar clear hai, toh hum aage 1:N (One-to-Many) ya CMP Relationships ki taraf chalein!

You said

  

As you can see from the preceding deployment descriptor, we model our

fake many-to-many relationship as two many-to-one relationships (one for

each bean in the relationship). A many-to-one relationship is conceptually the

same as a one-to-many relationship, and we learned how to model a one-to-

many relationship with CMP earlier.

Implementing True M:N Relationships Using BMP

The following code shows how to implement a true many-to-many relation-

ship using BMP:

public class StudentBean implements EntityBean {

private String studentPK;

private String name;

private Vector courses; // EJB object stubs

public Collection getCourses() { return courses; }

public void setCourses(Collection c) { this.courses = c;}

...

public void ejbLoad() {

// 1: SQL SELECT Student

// 2: JNDI lookup of CourseHome

// 3: Call CourseHome.findByStudent(studentPK)

}

public void ejbStore() {

// SQL UPDATE Student

}

public class Course implements EntityBean {

private String coursePK;

private String name;

private Vector students; // EJB object stubs

public Collection getStudents() { return students; }

public void setStudents(Collection s) { this.students = s;}

...

public void ejbLoad() {

// 1: SQL SELECT Course

// 2: JNDI lookup of StudentHome

// 3: Call StudentHome.findByCourse(coursePK)

}

public void ejbStore() {

// SQL UPDATE Course

}

426 Chapter 15

  

The relationship code is in bold. As you can see, all we’ve done to model a

true many-to-many relationship is to code a one-to-many relationship for each

bean in the relationship. This code is similar to the code presented when we

discussed one-to-many relationships.

Implementing True M:N Relationships Using CMP

The following code shows how to implement a true many-to-many relation-

ship using CMP:

public abstract class StudentBean implements EntityBean {

// no fields

public abstract Collection getCourses();

public abstract void setCourses(Collection courses);

...

public void ejbLoad() { } // Empty

public void ejbStore() { } // Empty

}

public abstract class CourseBean implements EntityBean {

// no fields

public abstract Collection getStudents();

public abstract void setStudents(Collection students);

...

public void ejbLoad() { } // Empty

public void ejbStore() { } // Empty

}

Our ejbLoad() and ejbStore() methods are free of any scaffolding code. The

relationships are specified in the deployment descriptor as follows:

<ejb-jar xmlns=”http://java.sun.com/xml/ns/j2ee” version=”2.1”

xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance

xsi:schemaLocation=”http://java.sun.com/xml/ns/j2ee

http://java.sun.com/xml/ns/j2ee/ejb-jar\_2\_1.xsd”>

<enterprise-beans>

...

</enterprise-beans>

<relationships>

<ejb-relation>

<ejb-relation-name>Student-Course</ejb-relation-name>

BMP and CMP Relationships 427

  

<ejb-relationship-role>

<ejb-relationship-role-name>

Students-EnrollIn-Courses

</ejb-relationship-role-name>

<multiplicity>Many</multiplicity>

<relationship-role-source>

<ejb-name>Student</ejb-name>

</relationship-role-source>

<cmr-field>

<cmr-field-name>courses</cmr-field-name>

<cmr-field-type>java.util.Collection</cmr-field-type>

</cmr-field>

</ejb-relationship-role>

<ejb-relationship-role>

<ejb-relationship-role-name>

Courses-HaveEnrolled-Students

</ejb-relationship-role-name>

<multiplicity>Many</multiplicity>

<relationship-role-source>

<ejb-name>Course</ejb-name>

</relationship-role-source>

<cmr-field>

<cmr-field-name>students</cmr-field-name>

<cmr-field-type>java.util.Collection</cmr-field-type>

</cmr-field>

</ejb-relationship-role>

</ejb-relation>

</relationships>

</ejb-jar>

As you can see, modeling a true many-to-many relationship using CMP is

extremely straightforward. We just use the word many on each half of the rela-

tionship, and state that each half of the relationship has a collection of the other

half.

If you’ve made it this far, congratulations; this concludes our cardinality dis-

cussion! Let’s move on to directionality.

Directionality

The directionality of a relationship specifies the direction in which you can nav-

igate a relationship. There are two flavors of directionality.

■■ Bidirectional. You can get from entity A to entity B, and can also get

from entity B to entity A.

■■ Unidirectional. You can get from entity A to entity B, but cannot get

from entity B to entity A.

428 Chapter 15

  

Directionality applies to all cardinalities (1:1, 1:N, and M:N). Directionality

and cardinality are orthogonal and complementary concepts. You can mix and

match them any way you would like.

Let’s use our one-to-one relationship example of an order and a shipment to

help us figure out directionality.

Implementing Directionality with BMP

The following code is a bidirectional relationship, with the key information in

bold:

public class OrderBean implements EntityBean {

private String orderPK;

private String orderName;

// EJB local object stub, must be stored/loaded

private Shipment shipment;

public Shipment getShipment() { return shipment; }

public void setShipment(Shipment s) { this.shipment = s; }

...

}

public class ShipmentBean implements EntityBean {

private String shipmentPK;

private String shipmentName;

// EJB local object stub, must be stored/loaded

private Order order;

public Order getOrder() { return order; }

public void setOrder(Order o) { this.order = o; }

...

}

As you can see, in a bidirectional relationship, each bean in the relationship

has a field pointing to the other bean, along with a get/set method.

In comparison, with a unidirectional relationship, we don’t allow the user to

get from the second bean to the first bean.

public class OrderBean implements EntityBean {

private String orderPK;

private String orderName;

// EJB local object stub, must be stored/loaded

private Shipment shipment;

BMP and CMP Relationships 429

  

public Shipment getShipment() { return shipment; }

public void setShipment(Shipment s) { this.shipment = s; }

...

}

public class ShipmentBean implements EntityBean {

private String shipmentPK;

private String shipmentName;

// No Order stub, no Order get/set method

...

}

Implementing Directionality with CMP

The following is a bidirectional CMP relationship:

public abstract class OrderBean implements EntityBean {

// no fields

public abstract Shipment getShipment();

public abstract void setShipment(Shipment s);

...

public void ejbLoad() { } // Empty

public void ejbStore() { } // Empty

}

public abstract class ShipmentBean implements EntityBean {

// no fields

public abstract Order getOrder();

public abstract void setOrder(Order o);

...

public void ejbLoad() { } // Empty

public void ejbStore() { } // Empty

}

As you can see, in a bidirectional CMP relationship, each bean in the rela-

tionship has a pair of abstract get/set methods pointing to the other bean. We

need to tell the container that these get/set methods are special relationship

methods so that the container can generate relationship code. Here is the

deployment descriptor that achieves this.

430 Chapter 15

  

<ejb-jar xmlns=”http://java.sun.com/xml/ns/j2ee” version=”2.1”

xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance

xsi:schemaLocation=”http://java.sun.com/xml/ns/j2ee

http://java.sun.com/xml/ns/j2ee/ejb-jar\_2\_1.xsd”>

<enterprise-beans>

...

</enterprise-beans>

<relationships>

<ejb-relation>

<ejb-relation-name>Order-Shipment</ejb-relation-name>

<ejb-relationship-role>

<ejb-relationship-role-name>

order-spawns-shipment

</ejb-relationship-role-name>

<multiplicity>One</multiplicity>

<relationship-role-source>

<ejb-name>Order</ejb-name>

</relationship-role-source>

<cmr-field><cmr-field-name>shipment</cmr-field-name></cmr-field>

</ejb-relationship-role>

<ejb-relationship-role>

<ejb-relationship-role-name>

shipment-fulfills-order

</ejb-relationship-role-name>

<multiplicity>One</multiplicity>

<relationship-role-source>

<ejb-name>Shipment</ejb-name>

</relationship-role-source>

<cmr-field><cmr-field-name>order</cmr-field-name></cmr-field>

</ejb-relationship-role>

</ejb-relation>

</relationships>

</ejb-jar>

In the deployment descriptor, we set up two container-managed relation-

ship (CMR) fields: one for each bean’s abstract get/set method pair that points

to the other bean.

To make this into a unidirectional relationship, we simply get rid of an

abstract get/set method pair, along with its corresponding CMR field.

Directionality May Not Map to Database Schemas

Note that directionality in entity beans may not correspond to the inherent

directionality of the database schema. An entity bean can provide for direc-

tionality even though the database does not do so easily, and vice versa. For

BMP and CMP Relationships 431

  

example, Figure 15.6 is a normalized database schema for a Person:Address

relationship. Figure 15.7 is a denormalized schema.

Both of these schemas give us enough information to derive relationship

information. You can, if you choose to do so, map entity beans to both these

schemas and use bidirectional relationships. The difference is that the denor-

malized schema allows for more efficient SQL. That is the classic computer sci-

ence space-time tradeoff. If you denormalize the database, you waste space

and increase maintenance problems, but you gain speed.

Figure 15.6 A normalized schema.

Figure 15.7 A denormalized schem

## Gemini said

Bhai, ab EJB Relationships ke do sabse bade pillars aa gaye hain: **M:N (Many-to-Many) Relationships** aur **Directionality (Bidirectional vs Unidirectional)**.

Tumhara DBMS ka base strong hai (MySQL, PostgreSQL experience hai), toh ye concepts samajhne mein bilkul time nahi lagega. Chalo is text ko quickly aur clearly todte hain!

---

### **1\. M:N (Many-to-Many) Relationships**

- **The Concept:** Ek Student kai saare Courses le sakta hai, aur ek Course mein kai saare Students ho sakte hain. (Classroom example).
- **BMP vs CMP implementation:**
	- **BMP:** Developer ko har Student ke paas `Vector courses` aur har Course ke paas `Vector students` rakhna padta hai. `ejbLoad` aur `ejbStore` mein JNDI lookup marke manually sabhi keys fetch karni padti hain. Ye code bahut messy hota hai.
		- **CMP (The Magic):** Developer sirf `abstract Collection getCourses()` aur `abstract Collection getStudents()` define karta hai. EJB container baaki ka saara database join (junction table create karna aur data lana) XML (Deployment Descriptor) ke through khud handle kar leta hai.
		- **XML Code Logic:** `<multiplicity>Many</multiplicity>` dono taraf define kiya jata hai, aur `<cmr-field>` batata hai ki kon sa abstract method is relation ko point karta hai.

---

### **2\. Directionality (Navigation of Relationships)**

Database tables mein relation exist karta hai, lekin *Programming Objects* (Beans) mein ye depend karta hai ki tumne class design kaise ki hai.

#### **A. Bidirectional (Two-Way Street)**

- **Hinglish Logic:** Tum Order se Shipment par jaa sakte ho, aur Shipment se wapas Order par aa sakte ho.
- **Code Logic:** Dono Beans ek doosre ka reference rakhte hain.
	- `OrderBean` has `getShipment()`.
		- `ShipmentBean` has `getOrder()`.
- **CMP XML Setup:** Dono Beans ke paas ek `<cmr-field>` tag hoga (XML snippet mein dekho, dono taraf CMR field define kiya gaya hai).

#### **B. Unidirectional (One-Way Street)**

- **Hinglish Logic:** Tum Order se Shipment par jaa sakte ho, par Shipment object se kabhi pata nahi chalega ki uska Order kon sa hai.
- **Code Logic:** Sirf ek Bean dusre ka reference rakhti hai.
	- `OrderBean` has `getShipment()`.
		- `ShipmentBean` does **NOT** have `getOrder()`.
- **Why use this?** Agar tumhe lagta hai ki business logic mein kabhi aisi zarurat hi nahi padegi ki Shipment se Order find karna pade, toh Unidirectional rakho. Isse memory aur database performance better hoti hai.
- **CMP XML Setup:** XML mein se ek bean ka `<cmr-field>` delete kar do. Container samajh jayega ki relation sirf ek taraf chalega.

---

### **3\. Directionality vs Database Schema (The Computer Science Space-Time Tradeoff)**

Ye aakhiri section kaafi theoretical par important point uthata hai:

- **Object Model 
	$$
	=
	$$
	 Database Model:** Bean class ki directionality is baat pe depend nahi karti ki underlying database schema kaisa hai.
- **Normalized vs Denormalized Database (Figures 15.6 & 15.7 - implied):**
	- *Normalized Schema:* Data redundancy (duplicacy) kam hoti hai. Par bidirectional navigation ke liye complex SQL `JOIN` queries chalani padti hain, jo slow ho sakti hain.
		- *Denormalized Schema:* Data duplicacy hoti hai (space zyada leta hai), par SQL queries bahut fast execute hoti hain (time bachta hai).
		- EJB Container itna smart hota hai ki tumhare Java Code (Bidirectional relationship) ko dono type ke schema par map kar sake. Tumhe bas O/R (Object-Relational) mapping tools ko batana hota hai ki table ka structure kaisa hai.

### **Summary for Exams:**

- **M:N using CMP:** Very simple! Just use `abstract Collection` getters/setters and set `<multiplicity>Many</multiplicity>` in the `ejb-jar.xml`.
- **Bidirectional:** Both Beans have getters/setters for each other.
- **Unidirectional:** Only one Bean has a getter/setter for the other.
- **Database mapping:** EJB abstracts the relationship, meaning you can have a bidirectional Java object relationship even if the underlying database schema is complex.

Bhai, Directionality aur Cardinality ka ye intersection clear hai? Agar DBMS mapping wale is concept mein koi doubt nahi hai, toh hum EJB Relationships ke aur advance parts (jaise Cascading Deletes) ki taraf badh sakte hain!

You said

  

Figure A.3 The Java serialization API.

Rules for Serialization

Java serialization has the following rules for member variables held in serial-

ized objects:

■■ Any basic primitive type (int, char, and so on) is serializable and will be

serialized with the object, unless marked with the transient keyword. If

serialized, the values of these types are available again after deserializa-

tion.

■■ Java objects can be included with the serialized bit-blob or not; it’s your

choice. The way you make your choice is as follows:

■■ Objects marked with the transient keyword are not serialized with

the object and are not available when deserialized.

■■ Any object that is not marked with the transient keyword must

implement java.lang.Serializable. These objects are converted to the

bit-blob format along with the original object. If your Java objects

aren’t transient and don’t implement java.lang.Serializable, a NotSeri-

alizable exception is thrown when writeObject() is called.

Thus, when you serialize an object, you also serialize all nontransient sub-

objects as well. This means you also serialize all nontransient sub-subobjects

(the objects referenced from the subobjects). This is repeated recursively for

every object until the entire reference graph of objects is serialized. This recur-

sion is handled automatically by Java serialization (see Figure A.4). You sim-

ply need to make sure that each of your member objects implements the

java.lang.Serializable interface. When serializing MyClass, object serialization

will recurse through the dependencies shown, packaging the entire graph of

objects as a stream. In Figure A.4, everything will get serialized except for tran-

sient long b, since it is marked as transient.

java.io.Serializable

writeObject()

readObject()

MyClass

RMI-IIOP and JNDI Tutorial 663

  

Figure A.4 Object serialization recursion.

What Should You Make Transient?

How do you know which member variables should be marked transient and

which should not? Here are some good reasons to mark an object as transient:

■■ The object is large. Large objects may not be suitable for serialization

because operations you do with the serialized blob may be very inten-

sive. Examples here include saving the blob to disk or transporting the

blob across the network.

■■ The object represents a local resource that cannot be reconstructed on

the target machine. Some examples of such resources are thread objects,

database connections, and sockets.

■■ The object represents sensitive information that you do not want to pass

in a serialized stream.

Note that object serialization is not free—it is a heavyweight operation for

large graphs of objects. Make sure you take this into account when designing

your distributed object application.

Object Serialization and RMI-IIOP

Java RMI-IIOP relies on object serialization for passing parameters via remote

method invocations. Figure A.5 shows what the MyObject object graph could

look like. Notice that every field and subfield is a valid type for Java serialization.

int a

transient long b

String s

Class2 c

MyClass

java.io.Serializable

Class3 c

Class2

Class3

java.lang.String

java.io.Serializable java.io.Serializable

java.io.Serializable

664 Appendix A

  

Figure A.5 Java RMI-IIOP and object serialization.

Figure A.5 shows how RMI-IIOP handles pass-by-value, where an entire

graph of objects is serialized into a bit-blob, sent across the network, and then

deserialized on the target machine. But passing parameters by value can lead

to inefficiencies. What if your referenced graph of objects is very large? What if

you have lots of state to send across the network? The ensuing network lag

from performing the invocation may be unacceptable.

There is another way to pass arguments. RMI-IIOP simulates a pass-by-refer-

ence convention, which means the arguments are not copied over. Rather, the

server modifies the client’s copy of the parameter.

If you want to pass a parameter by reference, the parameter must itself be a

remote object. The parameter is thus an object that is callable remotely. When

the client calls the server, the RMI-IIOP runtime sends a stub to that remote

java.io.Serializable

java.io.Serializable

java.io.Serializable

java.io.Serializable

int a = 5

transient long b = 3

String s = "Hello, World!"

Class2 Obj2 = new Class2();

MyObject : MyClass

Class3 Obj3 = new Class3();

Obj2 : Class2

Obj3 : Class3

s : java.lang.String

RMI Client

1: invoke(MyObject)

Remote Object

Stub

2: Since the MyObject parameter

implements Serializable, serialize

MyObject's object graph.

Network

Remote Object

Skeleton

Remote Object

Implementation

3: Deserialize the parameter. The deserialized

parameter, MyObject2, contains the same state

as MyObject, except the field

b does not have

the value 3 since

b is transient.

4: invoke(MyObject2)

This is the process that

occurs when MyObject is

sent over the network

through Java RMI-IIOP.

RMI-IIOP and JNDI Tutorial 665

  

object to the server. The server can perform a callback on that stub, which con-

nects the server to the remote object living on the client machine. Figure A.6

shows the process that occurs when MyRemoteObject, an instance of MyRe-

moteClass, is sent over the network through Java RMI-IIOP.

The best way to understand this paradigm is by analogy. In the Java pro-

gramming language, when you pass an object as a parameter, the object refer-

ence is copied. In RMI-IIOP, when you pass an object as a parameter, the stub

is copied. Both of these strategies achieve pass-by-reference because they are

cloning the thing that points to the object, rather than the object itself.

Because Java RMI-IIOP stubs are also serializable, they are passable over the

network as a bit-blob. This is why earlier we said that all parameters in Java

RMI-IIOP are passed by value. Thus, Java RMI-IIOP only simulates pass-by-ref-

erence by passing a serializable stub, rather than serializing the original object.

By making your parameters remote objects, you can effectively avoid the net-

work lag in passing large objects.

Figure A.6 Pass-by-reference with Java RMI-IIOP.

RMI-IIOP Client

1: invoke(MyRemoteObject)

Remote Object

Stub

2: Since the MyRemoteObject parameter

is a remote object, serialize a

stub to MyRemoteObject.

Network

Remote Object

Skeleton

Remote Object

Implementation

3: Deserialize the parameter. The deserialized

parameter is a stub back to the original

MyRemoteObject.

4: invoke(stub to MyRemoteObject)

MyRemoteClass

java.rmi.Remote

666 Appendix A

  

In summary, we have the following rules for passing objects using Java

RMI-IIOP:

■■ All Java basic primitives are passed by value when calling methods

remotely. This means copies are made of the parameters. Any changes

to the data on the remote host are not reflected in the original data.

■■ If you want to pass an object over the network by value, it must imple-

ment java.lang.Serializable. Anything referenced from within that object

must follow the rules for Java serialization. Again, any changes to the

data on the remote host are not reflected in the original data.

■■ If you want to pass an object over the network by-reference, it must be a

remote object, and it must implement java.rmi.Remote. A stub for the

remote object is serialized and passed to the remote host. The remote

host can then use that stub to invoke callbacks on your remote object.

There is only one copy of the object at any time, which means that all

hosts are calling the same object.

Now that you understand parameter passing, let’s move on. For us to com-

plete our RMI-IIOP sample application, we need some way to publish the

server and have the client locate that server. This process, called bootstrapping,

is achieved via the JNDI. Let’s put our RMI-IIOP example on hold while we

learn about JNDI. We’ll return later to complete the example.

The Java Naming and Directory Interface

The Java Naming and Directory Interface (JNDI) is a J2EE API that provides a

standard interface for locating users, machines, networks, objects, and services

by name. For example, you can use JNDI to locate a printer on your corporate

intranet. You can also use it to locate a Java object or connect with a database.

JNDI is used in EJB, RMI-IIOP, JDBC, and more. It is the standard J2EE way of

looking up things by name over the network.

Naming and Directory Services

To understand JNDI, we must first understand the concept of naming and

directory services.

A name is like a reference in that it denotes an entity, for example an object or

a person. The name is not the same as the referenced thing and has no mean-

ing by itself (“What’s in a name?”). Names are often preferred over other kinds

of references because they are easier to use and remember than unwieldy ref-

erences like phone numbers, SSNs, IP addresses, or remote object references.

RMI-IIOP and JNDI Tutorial 667

  

A naming service is analogous to a telephone operator. When you want to call

someone over the phone and you don’t know that person’s phone number,

you can call your telephone company’s information service operator to look up

the person you want to talk with. You supply the telephone operator with the

name of the person. The operator then looks up the phone number of the per-

son you want to speak with and returns it to you. (The operator can even dial

the number for you, connecting you to that person, but that is beyond what a

pure naming service will do for you.)

A naming service is an entity that performs the following tasks:

■■ It associates names with objects. We call this binding names to objects.

This is similar to a telephone company’s associating a person’s name

with a specific residence’s telephone number.

■■ It provides a facility to find an object based on a name. We call this

looking up an object, or resolving a name. This is similar to a telephone

operator finding a person’s telephone number based on that person’s

name.

Naming services are everywhere in computing. When you want to locate a

machine on the network, the Domain Name System (DNS) is used to translate a

machine name to an IP address. If you look up www.wiley.com on the Internet,

the name www.wiley.com is translated into the object (which happens to be a

String) 208.215.179.146 by the DNS.

Another example of naming occurs in file systems. When you access a file

on your hard disk, you supply a name for the file such as c:\\autoexec.bat or

/etc/fstab. How is this name translated into an actual file of data? A file sys-

tem naming service can be consulted to provide this functionality.

In general, a naming service can be used to find any kind of generic object

by name, like a file handle on your hard drive or a printer located across the

network. But one type of object is of particular importance: a directory object (or

directory entry). A directory object differs from a generic object because you can

store attributes with directory objects. These attributes can be used for a wide

variety of purposes.

For example, you can use a directory object to represent a user in your com-

pany. You can store information about that user, like the user’s password, as

attributes in the directory object. If you have an application that requires

authentication, you can store a user’s login name and password in directory

object attributes. When a client connects to your application, the client sup-

plies a login name and password, which you can compare with the login name

and password that are stored as a directory object’s attributes. If the data

matches, the user is authenticated. If the data doesn’t match, your application

can return an error. You can store other attributes besides a login name and

password, including a user’s e-mail address, phone number, and postal

address.

668 Appendix A

  

A directory service is a naming service that has been extended and enhanced

to provide directory object operations for manipulating attributes. A directory

is a system of directory objects that are all connected. Some examples of direc-

tory products are Netscape Directory Server and Microsoft Active Directory.

Your company probably uses a directory to store internal company informa-

tion (locations of computers, current printer status, personnel data, and so on).

What does a directory look like internally? The directory’s contents—the set

of connected directory objects—usually forms a hierarchical tree-like struc-

ture. Why would you want a tree-like structure? A tree’s form suggests the

way a real-world company is organized. For example, the root (or top node) of

your directory tree can represent your entire company. One branch off the root

could represent people in the company, while another branch could represent

network services. Each branch could have subtrees that decrease in granular-

ity more and more, until you are at individual user objects, printer objects,

machine objects, and the like. This is illustrated in Figure A.7.

Figure A.7 A hierarchical directory structure.

My Company

People

Network

Services

Person 1

Printers

Computers

Fax Machines

Person 2

Printer 1

Computer 1

Computer 2

Fax Machine 1

RMI-IIOP and JNDI Tutorial 669

  

All in all, directories are not very different from databases. A database can

store arbitrary data, just like a directory can. Databases provide query opera-

tions to look up items in a database, just like directories do. You can think of a

directory as a scaled-down, simplified database. In fact, most directories are

implemented by a database behind the scenes.

Problems with Naming and Directories

There are many popular naming and directory products out today. Directory

vendors differentiate their product lines by offering different types of services.

Unfortunately, this leads to different naming and directory standards. And

each directory standard has a different protocol for accessing the directory. For

example, directories based on the Lightweight Directory Access Protocol (LDAP)

are accessed differently than those based on the Network Information System

(NIS) or Novell’s Network Directory System (NDS).

This means that if you want to switch directory vendors, you need to rewrite

all your client code that accesses the directory. It also means you need to

download a new library, learn a new API, and test new code each time you use

a different directory.

Initially, LDAP was meant to resolve this problem by becoming the ubiqui-

tous protocol for directories. LDAP is straightforward and is being adopted

quickly by the industry—IBM’s Lotus Notes and Microsoft’s Active Directory

both are LDAP-based. However, not all directory products are LDAP-base

  

  

Explain to me in depth diagrams in this too

## Gemini said

Bhai, ye Appendix A ka hissa hai jo **EJB ke pichhe ke mechanics** (RMI-IIOP aur JNDI) ko explain karta hai. Distributed systems (jahan client ek computer pe ho aur server doosre pe) mein data kaise transfer hota hai, ye samajhna bahut zaroori hai.

Yahan 4 main diagrams/concepts discuss hue hain. Main inko ekdum deeply aur simple logic ke sath explain karta hoon:

### **1\. Figure A.4: Object Serialization Recursion (The Domino Effect)**

- **Concept:** Serialization ka matlab hai kisi Java Object ko RAM se uthakar "0s aur 1s" ki ek ladi (bit-blob ya stream) mein convert karna taaki use network ke through bheja ja sake.
- **The Diagram Logic:** Jab tum ek main object (jaise `MyClass`) ko serialize karte ho, toh Java sirf uske direct variables ko nahi dekhta. Agar `MyClass` ke andar ek `Class2` ka object hai, aur `Class2` ke andar `Class3` ka object hai, toh Java un sabko **recursively** (ek ke baad ek andar ghus ke) serialize karega.
- **The "Stop Sign" (`transient`):** Agar tum kisi variable ke aage `transient` likh do (jaise `transient long b`), toh Java samajh jata hai ki "Is variable ko network pe nahi bhejna hai." Jab ye object doosri taraf (server par) pahuchega aur wapas Java object banega (deserialize hoga), toh `b` ki value gayab hogi (usme default `0` ya `null` hoga). Ye passwords, ya local file handles bachane ke kaam aata hai.

### **2\. Figure A.5: RMI Pass-by-Value (Sending the Heavy "Clone")**

- **Concept:** Agar tumhara object `java.io.Serializable` implement karta hai, toh RMI usey **Pass-by-Value** ki tarah bhejta hai.
- **The Diagram Logic:** RMI poore ke poore object graph (MyClass + Class2 + Class3) ka ek bit-blob banata hai, usko network wire ke through bhejta hai, aur Server par uska ek **Duplicate (Clone)** banata hai.
- **The Catch:** Server aur Client ab alag-alag objects par kaam kar rahe hain. Agar server duplicate object mein kuch change karta hai, toh tumhare client wale original object mein koi change nahi aayega. Ye network ke liye "heavy" ho sakta hai agar object bahut bada ho.

### **3\. Figure A.6: RMI Pass-by-Reference (Sending the "Remote Control")**

- **Concept:** Agar object bahut bada hai aur tum nahi chahte ki uski duplicate copy network pe jaye, toh tum usey `java.rmi.Remote` banate ho.
- **The Diagram Logic:** Is case mein, RMI original data (object) ko client ki machine par hi chhod deta hai. Wo us object ka ek chota sa **"Stub" (Proxy/Remote Control)** serialize karke Server ko bhej deta hai.
- **The Catch:** Jab server us parameter par koi method call karta hai, toh wo darasal us Stub ko dabata hai, aur Stub network ke raste wapas Client ke paas aakar original object par method chala deta hai. Isko **Pass-by-Reference** simulate karna kehte hain.

### **4\. Figure A.7: The JNDI Hierarchical Directory Tree**

- **Concept:** Ab ye RMI stubs milenge kahan se? Uske liye humein ek Naming Service chahiye. JNDI bilkul tumhare computer ke File System (folders) jaisa hota hai.
- **The Diagram Logic:** Ek tree structure hota hai. Root (Top) pe tumhari company ka naam hota hai, uske andar folders hote hain "People", "Network", "Printers". Uske andar specific cheezein hoti hain. JNDI ka use karke tumhara code network pe aaram se `Lookup("Printers/Printer1")` karke us network printer ka remote object (stub) nikaal sakta hai.

Niche maine ek Interactive Widget banaya hai. Ise use karke dekho ki **Transient** variables aur **Serializable vs Remote** interfaces network transfer ko kaise affect karte hain. Ye tumhe Pass-by-Value aur Pass-by-Reference ka difference ek second mein clear kar dega!

You said

does this cover the entire stuff I gave you, all the important concept and everything else

## Gemini said

Bhai, humne jo pichla discussion kiya usme saare **Major Diagrams aur Core Concepts** cover ho gaye the jo exams mein direct pooche jaate hain (Pass-by-Value vs Pass-by-Reference, aur Serialization ka working).

Lekin, agar hum us text ko line-by-line dekhein, toh **2 theoretical details** hain jo maine short mein batai thi, par book ne unko deeply list kiya hai. Exam mein inpar short notes aa sakte hain, toh inko bhi dimaag mein baitha lo:

### **1\. What Should You Make Transient? (3 Golden Rules)**

Book ne clearly 3 reasons diye hain ki kis variable ko `transient` mark karna chahiye (jisse wo network pe serialize na ho):

- **Large Objects:** Agar koi object bohot heavy hai (jaise koi badi image ya bada data array) jisko bhejne se network slow ho jayega.
- **Local Resources:** Aisi cheezein jo sirf usi machine par exist karti hain aur doosri machine pe unka koi matlab nahi hai. **Examples:** Thread objects, Database connections, aur Network Sockets. (Ye sabse important point hai).
- **Sensitive Information:** Passwords, security keys, ya private data jo tum nahi chahte ki network wire pe kisi ko dikhe.

### **2\. Naming Service vs Directory Service (JNDI ka Deep Concept)**

Maine tumhe JNDI ko ek "Directory Tree" banakar samjhaya tha, par book ek distinction banati hai:

- **Naming Service:** Ye simple "Telephone Operator" ki tarah hai. Ye sirf ek Naam ko ek Object se jodata hai. *(e.g., "Printer1" = Network IP).*
- **Directory Service:** Ye Naming service ka advanced version hai. Isme tum object ke saath **"Attributes" (Properties)** bhi save kar sakte ho. *(e.g., User object ke saath uska password, email, aur phone number save karna).* Active Directory aur LDAP iske examples hain.
- **The Problem (Vendor Lock-in):** Book end mein batati hai ki market mein bohot saare directories hain (LDAP, NIS, NDS) aur sabka apna alag code hota tha. **JNDI ka main fayda** yahi hai ki ye developer ko ek single API (Java Standard) deta hai, taaki pichhe koi bhi directory ho, tumhara Java code same rahe.

**Conclusion:** In do points ko add karne ke baad, tumhara diya hua saara material **100% comprehensively cover** ho gaya hai! RMI-IIOP ka networking aur JNDI ka lookup system dono tumhari mutthi mein hain.

Aage kisi aur Unit ya Chapter ka text hai jo decode karna hai?

You said

Enter JNDI

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

![profile picture](https://lh3.googleusercontent.com/a/ACg8ocJSbrymPAig6ktA4qirs1QwiTnjEDWTP6qg_yooFnbcT4p9_mD6=s64-c-v1-rj)