---
title: "EJb"
created: 2026-04-11
description: "convo with llm"
tags:
  - "ejb"
  - "system design"
---
**You**

79

A session bean represents work being performed for client code that is calling it.

Session beans are business process objects that implement business logic, busi-

ness rules, algorithms, and workflow. For example, a session bean can perform

price quoting, order entry, video compression, banking transactions, stock

trades, database operations, complex calculations, and more. They are

reusable components that contain logic for business processes.

Let’s examine the characteristics of session beans in detail and then code up

a stateful session bean.

Session Bean Lifetime

A key difference between session beans and other bean types is the scope of

their lives. A session bean instance is a relatively short-lived object. It has

roughly the lifetime equivalent of a session or of the client code that is calling

the session bean. Session bean instances are not shared between multiple

clients.

For example, if the client code contacted a session bean to perform order

entry logic, the EJB container is responsible for creating an instance of that ses-

sion bean component. When the client later disconnects, the application server

may destroy the session bean instance.

Introduction to Session Beans

C H A P T E R

4

A client’s session duration could be as long as a browser window is open,

perhaps connecting to an e-commerce site with deployed session beans. It

could also be as long as your Java applet is running, as long as a standalone

application is open, or as long as another bean is using your bean.

The length of the client’s session generally determines how long a session

bean is in use—that is where the term session bean originated. The EJB con-

tainer is empowered to destroy session beans if clients time out. If your client

code is using your beans for 10 minutes, your session beans might live for min-

utes or hours, but probably not weeks, months, or years. Typically session

beans do not survive application server crashes, nor do they survive machine

crashes. They are in-memory objects that live and die with their surrounding

environments.

In contrast, entity beans can live for months or even years because entity

beans are persistent objects. Entity beans are part of a durable, permanent stor-

age, such as a database. Entity beans can be constructed in memory from data-

base data, and they can survive for long periods of time.

Session beans are nonpersistent. This means that session beans are not saved

to permanent storage, whereas entity beans are. Note that session beans can

perform database operations, but the session bean itself is not a persistent

object.

Session Bean Subtypes

All enterprise beans hold conversations with clients at some level. A conversa-

tion is an interaction between a client and a bean, and it is composed of a num-

ber of method calls between the client and the bean. A conversation spans a

business process for the client, such as configuring a frame-relay switch, pur-

chasing goods over the Internet, or entering information about a new customer.

The two subtypes of session beans are stateful session beans and stateless ses-

sion beans. Each is used to model different types of these conversations.

Stateful Session Beans

Some business processes are naturally drawn-out conversations over several

requests. An example is an e-commerce Web store. As a user peruses an online

e-commerce Web site, the user can add products to the online shopping cart.

Each time the user adds a product, we perform another request. The conse-

quence of such a business process is that the components must track the user’s

state (such as a shopping cart state) from request to request.

80 Chapter 4

Another example of a drawn-out business process is a banking application.

You may have code representing a bank teller who deals with a particular

client for a long period of time. That teller may perform a number of banking

transactions on behalf of the client, such as checking the account balance,

depositing funds, and making a withdrawal.

A stateful session bean is a bean that is designed to service business processes

that span multiple method requests or transactions. To accomplish this, state-

ful session beans retain state on behalf of an individual client. If a stateful ses-

sion bean’s state is changed during a method invocation, that same state will

be available to that same client upon the following invocation.

Stateless Session Beans

Some business processes naturally lend themselves to a single request conver-

sation. A single request business process is one that does not require state to be

maintained across method invocations.

A stateless session bean is a bean that holds conversations that span a single

method call. They are stateless because they do not hold multimethod conver-

sations with their clients. After each method call, the container may choose to

destroy a stateless session bean, or recreate it, clearing itself out of all informa-

tion pertaining to past invocations. It also may choose to keep your instance

around, perhaps reusing it for all clients who want to use the same session

bean class. The exact algorithm is container specific. The takeaway point is

this: Expect your bean to forget everything after each method call, and thus

retain no conversational state from method to method. If your bean happens to

hang around longer, then great—but that’s your container’s decision, and you

shouldn’t rely on it.

For a stateless session bean to be useful to a client, the client must pass all

client data that the bean needs as parameters to business logic methods. Alter-

natively, the bean can retrieve the data it needs from an external source, such

as a database.

Stateless really means no conversational state. Stateless session beans can

contain state that is not specific to any one client, such as a database

connection factory that all clients would use. You can keep this around in a

private variable. So long as you’re willing to lose the data in your private

variable at any time, you’ll be fine.

An example of a stateless session bean is a high-performance engine that

solves complex mathematical operations on a given input, such as compression

of audio or video data. The client could pass in a buffer of uncompressed data,

as well as a compression factor. The bean returns a compressed buffer and is

Introduction to Session Beans 81

then available to service a different client. The business process spanned one

method request. The bean does not retain any state from previous requests.

Another example of a stateless session bean is a credit card verification com-

ponent. The verifier bean takes a credit card number, expiration date, card-

holder’s name, and dollar amount as input. The verifier then returns a yes or

no answer, depending on whether the card holder’s credit is valid. Once the

bean completes this task, it is available to service a different client and retains

no past knowledge from the original client.

Because stateless session beans hold no conversational state, all instances of

the same stateless session bean class are equivalent and indistinguishable to a

client. It does not matter who has called a stateless session bean in the past,

since a stateless session bean retains no state knowledge about its history. This

means that any stateless session bean can service any client request because

they are all exactly the same. In fact, stateless session beans can be pooled,

reused, and swapped from one client to another client on each method call! We

show this in Figure 4.1.

Since EJB 2.1, stateless session beans can also provide Web Services inter-

faces to clients. We will examine this important new option in details in Chap-

ter 5

explain this from starting and covering every point,

this is starting of chapter 4 the figure 4.1 is stateless session bean pooling

---

**Gemini**

Bhai, ye Chapter 4 ki aakhiri baazi hai jisme EJB ka dil— **Session Beans** aur unki Types (Stateless vs Stateful) sikhne ko milengi.

Book ki theory bahut lambi hai, lekin iska nichod (summary) bahut clear aur simple hai. Chalo shuru karte hain point-by-point bina koi faltu gyan diye.

---

### 1\. Session Bean Hota Kya Hai? (The Basics)

- **Hinglish:** Session bean tumhara backend **Worker** hai. Ye calculations karta hai, database ko update karta hai, aur business rules (logic) chalata hai.
- **Examples in Book:** Video compression, online shopping logic, bank transactions, credit card verification.
- **Non-Persistent:** Session beans RAM mein rehte hain (in-memory). Ye khud database mein save nahi hote. Inka kaam data le kar database ko dena hai, par khud Session Bean koi data table mein bankar save nahi hoti. (Ye kaam Entity Bean ka hai).

### 2\. Session Bean Lifetime (Inki Umar Kitni Hoti Hai?)

- **Hinglish:** Ek session bean ki life **short** hoti hai. Ye client ke "Session" tak zinda rehti hai.
- Agar client ek applet ya browser close kar de, ya server timeout de de (e.g., 10 minutes idle), toh EJB Container bean ko maar (destroy) deta hai.
- Agar server crash hua, toh saari Session Beans khatam. Ye saalo-saal zinda nahi rehti (unlike Entity beans).

---

### 3\. The Two Subtypes of Session Beans (Sabse Bada Exam Question)

EJB mein client aur bean ke beech ki baatchit ko **Conversation** kehte hain. Is conversation ke style ke basis par do type ki beans hoti hain:

#### A. Stateful Session Beans (The Conversation Bean)

- **Concept:** Ye bean ek hi client ke sath lambi baatchit (multiple method calls) yaad rakhti hai. Ye client ki *State* (Memory) ko retain karti hai har request ke baad.
- **Examples:**
	- **E-Commerce Shopping Cart:** Jab tum Amazon par pehle item add karte ho, fir doosra, fir teesra... Server ko yaad rakhna padta hai ki ye same banda hai aur iske cart mein purane items pade hain. Stateful bean ye memory maintain karti hai.
		- **Bank Teller:** Jaise tum bank gaye aur ek teller (clerk) se bola pehle balance check karo, fir withdraw karo. Teller yaad rakhta hai ki tum kaun ho aur tumhara balance abhi kya update hua.
- **Key Point:** Har naye client ko server ek apni **personal, dedicated Stateful Bean** deta hai jo sirf usi se baat karti hai jab tak session khatam na ho.

#### B. Stateless Session Beans (The "Ghajini" Bean)

- **Concept:** Ye bean sirf **ek request** tak memory rakhti hai. Ek method call khatam hua, aur ye pichla sab bhool jayegi. Doosri request aayegi, usse pehli ka kuch yaad nahi hoga.
- **Fayda:** Kyunki ise kuch yaad nahi rakhna padta, EJB Container ek **Pool (Group)** bana kar rakhta hai inka. Agar 100 log aate hain, toh server 100 alag beans nahi banayega, wo pool mein padi kuch beans ko sabke beech baant dega. (Ye **Figure 4.1 - Stateless Pooling** ka reference hai).
- **Examples:**
	- **Credit Card Verification:** Tum card number daalte ho, bean "Yes/No" batati hai, kaam khatam. Use yaad rakhne ki zaroorat nahi ki 5 minute pehle kisne check kiya tha.
		- **Video Compression:** Raw video daalo, compressed video le lo. Ek method, no history needed.
- **The "Stateless" Rule:** Stateless ka matlab ye nahi ki uske andar koi variable nahi ho sakta. Uske andar variables ho sakte hain (like Database Connection Factory), par wo client-specific (personal) data nahi rakhti. Har stateless bean instance ek doosre ke exactly identical hoti hai.

---

### Summary Table (Exam ke liye Ratta)

| Feature | Stateful Session Bean | Stateless Session Bean |
| --- | --- | --- |
| **Memory** | Client ki history yaad rakhti hai. | Puraani baatein bhool jati hai (No conversational state). |
| **Duration** | Multiple method calls. | Single method call. |
| **Usage** | Shopping Carts, Multi-step forms. | Calculations, Verifications, High-performance tasks. |
| **Pooling** | Dedicated for one client. No pooling. | Shared among clients. Highly pooled. |
| **Scalability** | Heavy. Takes more RAM. | Very lightweight and highly scalable. |

Bhai, ye distinction samajh aa gaya? Agar Stateless vs Stateful mein koi doubt nahi hai, toh batao, iske aage Activation aur Passivation (Stateful beans ka RAM bachaane ka tareeka) aayega.

---

**You**

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

Life Cycle Diagrams for Session Beans

Now that we’ve written a complete stateless session bean (in Chapter 3) and a

complete stateful session bean (in this chapter), let’s see what’s happening

behind the scenes.

Figure 4.4 shows the life cycle of a stateless session bean inside the container.

Note that in this diagram, the client is not calling methods on the bean, since

the client never accesses a bean directly. (The client always goes through the

container.) In the diagram, the container (that is, the home object and EJB

objects) is calling methods on our bean.

Let’s walk through this diagram.

1\. At first, the bean instance does not exist. Perhaps the application

server has just started up.

2\. The container decides it wants to instantiate a new bean. When does

the container decide it wants to instantiate a new bean? It depends on

the container’s policy for pooling beans. The container may decide to

instantiate 10 beans all at once when the application server first starts

because you told the container to do so using the vendor-specific files

that you ship with your bean. Each of those beans are equivalent

(because they are stateless) and they can be reused for many different

clients.

98 Chapter 4

Figure 4.4 The life cycle of a stateless session bean.

3\. The container instantiates your bean. The container calls Class.newIn-

stance(“HelloBean.class”) on your session bean class, which is the

dynamic equivalent of calling new HelloBean(). The container does this

so that the container is not hard-coded to any specific bean name; the

container is generic and works with any bean. This action calls your

bean’s default constructor, which can do any necessary initialization.

4\. The container calls setSessionContext(). This associates you with a

context object, which enables you to make callbacks to the container

(see Chapter 9 for some examples of these callbacks).

5\. The container calls ejbCreate(). This initializes your bean. Note that

because stateless session beans’ ejbCreate() methods take no parameters,

clients never supply any critical information that bean instances need to

start up. EJB containers can exploit this and pre-create instances of your

stateless session beans. In general when a client creates or destroys a

bean using the home object, that action might not necessarily corre-

spond with literally creating or destroying in-memory bean objects,

because the EJB container controls their life cycles to allow for pooling

between heterogeneous clients.

Bean Instance Does Not

Exist

Pool of Equivalent

Method-Ready Instances

1: Class.newInstance()

2: setSessionContext()

3: ejbCreate()

1: ejbRemove()

Business Method

Container decided it

needs more instances

in the pool to service

clients.

Any client calls a

business method on

any EJB object.

Container decided it

doesn't need so

many instances

anymore.

Introduction to Session Beans 99

6\. The container can call business methods on your bean. The container

can call as many business methods as it wants to call. Each business

method could originate from a completely different client because all

bean instances are treated exactly the same. All stateless session beans

think they are in the same state after a method call; they are effectively

unaware that previous method calls happened. Therefore the container

can dynamically reassign beans to client requests at the per-method level.

A different stateless session bean can service each method call from a

client. Of course, the actual implementation of reassigning beans to

clients is container-specific.

7\. Finally, the container calls ejbRemove(). When the container is about to

remove your session bean instance, it calls your bean’s ejbRemove() call-

back method. ejbRemove() is a clean-up method, alerting your bean that

it is about to be destroyed and allowing it to end its life gracefully.

ejbRemove() is a required method of all beans, and it takes no parame-

ters. Therefore there is only one ejbRemove() method per bean. This is in

stark contrast to ejbCreate(), which has many forms. This makes perfect

sense: Why should a destructive method be personalized for each

client? (This is an analogous concept to destructors in C11.) Your imple-

mentation of ejbRemove() should prepare your bean for destruction. This

means you need to free all resources you may have allocated.

Figure 4.5 shows the life cycle of a stateful session bean. Remember that in

the diagram, the container (not the client) is calling methods on our bean

instance.

The life cycle for stateful session beans is similar to that of stateless session

beans. The big differences are as follows:

■■ There is no pool of equivalent instances because each instance contains

state.

■■ There are transitions for passivating and activating conversational state.

100 Chapter 4

Figure 4.5 Life cycle of a stateful session bean.

Bean Instance Does

Not Exist

Ready

1: Class.newInstance()

2: setSessionContext()

3: ejbCreate(...)

ejbRemove()

ejbPassivate()

ejbActivate()

Passive

Client Times Out

Business Method

Client called

create(...) on the

home interface.

Client called a

business method

on the EJB object.

Container's limit of

instantiated beans is

reached, so it must

swap your bean out.

Client called a method

on a passivated bean,

so container must

swap your bean back

in.

Client called remove() on

the EJB object or client

times out.

Introduction to Session Beans 101

DON’T RELY ON EJBREMOVE()

Your container can call ejbRemove() at any time, even if the container decides

that the bean’s life has expired (perhaps due to a very long timeout). Note that

the container may never call your bean’s ejbRemove() method, for example if

the container crashes or if a critical exception occurs. You must be prepared for

this contingency. For example, if your bean performs shopping cart operations,

it might store temporary shopping cart data in a database. Your application

should provide a utility that runs periodically to remove any abandoned

shopping carts from the database because otherwise the database resources

associated with the abandoned shopping carts will never be freed.

Summary

In this chapter, you learned the theoretical concepts behind session beans. You

learned about achieving instance pooling and caching with session beans, acti-

vation, and passivation. You wrote a stateful session bean that counted up and

touched on session beans’ life cycle.

lots and lots of diagrams,

4.2 passivation of stateful bean

4.3 activation of stateful bean

4.4 lifecycle of a stateless session bean.

45 lifecycle of a stateful session bean

---

**Gemini**

Bhai, ye Chapter 4 ka "Grand Finale" hai aur exam ke liye sabse zyada marks score karne wala section hai. Isme jo **Lifecycle Diagrams** hain (Figure 4.4 aur 4.5), wo confirm exam mein pooche jaate hain.

Let's break down the whole flow step-by-step.

---

### 1\. Activation & Passivation (Sirf Stateful Beans ke liye)

Tumhare count wale code example ka main funda ye dikhana tha ki **Server RAM kaise bachata hai**.

- **The Problem:** Agar 10,000 users Amazon par shopping kar rahe hain, toh kya server 10,000 Stateful Session Beans ko ek sath RAM (Memory) mein rakhega? Nahi, RAM full ho jayegi.
- **The Solution (Passivation):** Server check karta hai ki kaunse users idle (khali) baithe hain. Wo unki Stateful beans ko uthata hai, unki memory (shopping cart data) ko hard drive pe save karta hai, aur RAM se us bean ko hata deta hai. Ise **Passivation** kehte hain. (Is waqt server `ejbPassivate()` method call karta hai taaki bean khud ko save karne ke liye ready kar le).
- **The Comeback (Activation):** Jab wo idle user wapas aake "Checkout" pe click karta hai, toh server hard drive se wo data wapas RAM mein laata hai. Ise **Activation** kehte hain. (Is waqt server `ejbActivate()` call karta hai).

---

### 2\. Lifecycle of a Stateless Session Bean (Figure 4.4)

Stateless bean bahut simple zindagi jeeti hai kyunki isme "Memory" ka tension nahi hota. Exam mein ye steps zaroor likhna:

1. **Does Not Exist:** Abhi tak kuch nahi bana hai.
2. **Creation (Entering the Pool):** Server automatically `newInstance()` call karke object banata hai, usko Context deta hai (`setSessionContext()`), aur `ejbCreate()` call karke usko "Pool" mein daal deta hai.
3. **Method Ready (In the Pool):** Bean ab ready hai. Client aate hain, proxy ke through method call karte hain (`hello()`), aur chale jaate hain. Ek bean hazaron clients ke methods handle kar sakti hai baari-baari se.
4. **Destruction:** Jab server ko lagta hai ki ab is bean ki zaroorat nahi (ya server band ho raha hai), toh wo `ejbRemove()` call karke bean ko hamesha ke liye delete kar deta hai.

*(Notice karo: Isme Activation ya Passivation nahi hai kyunki Stateless mein bachane ke liye koi data hi nahi hota!)*

---

### 3\. Lifecycle of a Stateful Session Bean (Figure 4.5)

Ye diagram thoda complex hai kyunki isme client ka state yaad rakhna hota hai.

1. **Does Not Exist:** Abhi bean paida nahi hui hai.
2. **Creation:** Client JNDI se `create()` call karta hai. Server naya bean banata hai (`newInstance()`, `setSessionContext()`, aur `ejbCreate()`). Ab ye bean sirf isi client ke liye reserve ho gayi.
3. **Ready State:** Client is bean par apne business methods (e.g., `addItemsToCart()`) call karta hai.
4. **The Sleep Cycle (Passive State):**
	- Agar client bahut der tak kuch nahi karta, toh Server `ejbPassivate()` call karke bean ko hard drive pe sula deta hai. (Bean is now in *Passive* state).
		- Agar client wapas aa ke method call karta hai, toh Server `ejbActivate()` call karke use wapas jaga deta hai. (Bean is back to *Ready* state).
5. **Destruction:** Jab client `remove()` call karta hai (e.g., Logout kar diya), ya fir client bahut zyada timeout ho jata hai, toh server `ejbRemove()` call karke bean ko khatam kar deta hai.

---

### 4\. "Don't Rely on ejbRemove()" (Pro Tip)

Book mein end mein ek warning hai jo bahut baar interview ya exam trick question ban kar aati hai:

- **The Trap:** Developer log sochte hain ki jab bean khatam hogi, toh wo `ejbRemove()` mein code likh kar database close kar denge ya carts khali kar denge.
- **The Reality:** Agar server achanak light jaane se crash ho gaya, toh `ejbRemove()` **kabhi call hi nahi hoga!** Isliye critical cleanup ke liye is method pe bharosa mat karo.

---

### Summary of the Entire Chapter 4

- **Stateless:** Ek request, no memory. Client A aur Client B dono same pool se bean uthayenge. Lifecycle is just Create Pool Destroy.
- **Stateful:** Lamba session, full memory. Client A ki apni bean, Client B ki apni bean. Lifecycle mein Create Ready (Passivate/Activate ) Destroy aayega.

Bhai, isme se kisi bhi lifecycle diagram (4.4 ya 4.5) ko draw karne ya explain karne mein dikkat lag rahi hai? Ye pura chapter khatam ho gaya. Tumhara EJB fundamentals aur Unit 4 solid cover ho chuka hai!

---

**You**

ok next chapter now

119

One of the key benefits of EJB is that it gives you the power to create entity

beans. Entity beans are persistent objects that you place in permanent storage.

This means you can model your business’s fundamental, underlying data as

entity beans.

In this chapter, we’ll cover the basic concepts of persistence. We’ll give you

a definition of entity beans from a programmer’s perspective. You’ll learn the

features that entity beans offer and entity bean programming concepts.

This chapter is relatively theoretical, and it is meant to give you a solid foun-

dation in entity bean programming concepts. Make sure you’ve read and

understood the previous chapters in this book; our discussion of entity beans

will build on the knowledge you’ve acquired so far. We’ll use these concepts

with hands-on code in later chapters.

Persistence Concepts

Because entity beans are persistent objects, our discussion begins with a quick

look at popular ways to persist objects.

Introduction to Entity Beans

C H A P T E R

6

Object-Relational Mapping

Another popular way to store Java objects is to use a traditional relational

database, such as Oracle, Microsoft SQL Server, or MySQL. Rather than serial-

ize each object, we could decompose each object into its constituent parts and

store each part separately. For example, for a bank account object, the bank

account number could be stored in one relational database field and the bank

account balance in another field. When you save your Java objects, you would

use JDBC to map the object data into a relational database. When you want to

load your objects from the database, you would instantiate an object from that

class, read the data in from the database, and then populate that object

instance’s fields with the relational data read in. This is shown in Figure 6.1.

Figure 6.1 Object-relational mapping.

Relational Database

Bank Account

Table

String accountID

String ownerName

double balance

Bank Account

Database API

Such as JDBC or

SQLJ

120 Chapter 6

This mapping of objects to relational databases is a technology called object-

relational mapping. It is the act of converting and unconverting in-memory

objects to relational data. An object-relational (O/R) mapper may map your

objects to any kind of relational database schema. For example, a simple

object-relational mapping engine might map a Java class to a SQL table defini-

tion. An instance of that class would map to a row in that table, while fields in

that instance would map to individual cells in that row. This is shown in Fig-

ure 6.2. You’ll see more advanced cases of mapping data with relationships to

other data in Chapter 11.

Object-relational mapping is a much more sophisticated mechanism of per-

sisting objects than the simple object serialization offered by the Java language.

By decomposing your Java objects as relational data, you can issue arbitrary

queries for information. For example, you can search through all the database

records that have an account balance entry greater than $1,000 and load only

the objects that fulfill this query. More advanced queries are also possible. You

can also visually inspect the database data because it is not stored as bit-blobs,

which is great for debugging or auditing.

Figure 6.2 An example of object-relational mapping.

String accountID

String ownerName

double balance

Account Class

Relational Database

Ray Combs

accountID ownerName balance

1 1000

Bob Barker2 1500

Monty Haul3 2750

Account Table

accountID = 1

ownerName = Ray Combs

balance = 1000

Account Instance

Introduction to Entity Beans 121

Mapping objects to relational data can be done in two ways. You can either

handcraft this mapping in your code or use an object-relational mapping prod-

uct, such as Oracle TopLink, or open source tools, such as Hibernate, to auto-

mate or facilitate this mapping. These tools have become increasingly popular.

Handcrafted mappings using a database access API such as JDBC are becom-

ing less frequently used because the cost of developing and maintaining an

object-relational mapping layer is significant.

The Sun Java Data Objects (JDO) specification, available as JSR 12 from the

Java Community Process (JCP) Web site at www.jcp.org, defines portable APIs to

a persistence layer that is conceptually neutral to the database technology used

to support it. It can thus be implemented by vendors of relational and object-

oriented databases. According to recent announcements, future versions of the

EJB specification are going to be more closely aligned with container-indepen-

dent persistence mechanisms, such as Hibernate, TopLink, and JDO.

Now that we’ve whetted your appetite with persistence mechanisms, let’s

take a look at how entity bean persistent objects are used in an EJB multitier

environment.

What Is an Entity Bean?

In any sophisticated, object-oriented multitier deployment, we can draw a

clear distinction between two different kinds of components deployed.

■■ Application logic components. These components are method

providers that perform common tasks. Their tasks might include the

following:

■■ Computing the price of an order

■■ Billing a customer’s credit card

■■ Computing the inverse of a matrix

Note that these components represent actions (they’re verbs). They are

well suited to handling business processes.

Session beans model these application logic components very well.

They often contain interesting algorithms and logic to perform applica-

tion tasks. Session beans represent work being performed for a user.

They represent the user session, which includes any workflow logic.

■■ Persistent data components. These are objects (perhaps written in Java)

that know how to render themselves into persistent storage. They use

some persistence mechanism, such as serialization, O/R mapping to a

relational database, or an object database. These kinds of objects repre-

sent data—simple or complex information that you’d like saved. Exam-

ples here include:

122 Chapter 6

■■ Bank account information, such as account number and balance

■■ Human resources data, such as names, departments, and salaries of

employees

■■ Lead tracking information, such as names, addresses, and phone

numbers of prospective customers that you want to keep track of

over time

Note that these components represent people, places, and things

(they’re nouns). They are well suited to handling business data.

The big difference between session beans and entity beans is that entity

beans have an identity and client-visible state, and that their lifetime may be

completely independent of the client application’s lifetime. For entity beans,

having an identity means that different entity beans can be distinguished by

comparing their identities. It also means that clients can refer to individual

entity bean instances by using that identity, pass handles to other applications,

and actually share common entities with other clients. All this is not possible

with session beans.

You might question the need for such persistent data components. Why

should we deal with our business data as objects, rather than deal with raw

database data, such as relational rows? It is handy to treat data as objects

because they can be easily handled and managed and because they are repre-

sented in a compact manner. We can group related data in a unified object. We

associate some simple methods with that data, such as compression or other

data-related activities. We can also use implicit middleware services from an

application server, such as relationships, transactions, network accessibility,

and security. We can also cache that data for performance.

Entity beans are these persistent data components. Entity beans are enter-

prise beans that know how to persist themselves permanently to a durable

storage, such as a database or legacy system. They are physical, storable parts

of an enterprise. Entity beans store data as fields, such as bank account num-

bers and bank account balances. They also have methods associated with

them, such as getBankAccountNumber() and getAccountBalance(). For a full dis-

cussion of when to (and when not to) use entity beans, see Chapter 16.

In some ways, entity beans are analogous to serializable Java objects. Serial-

izable objects can be rendered into a bit-blob and then saved into a persistent

store; entity beans can persist themselves in many ways, including Java serial-

ization, O/R mapping, or even an object database persistence. Nothing in the

EJB 2.x specification dictates any particular persistence mechanism, although

O/R mappings are the most frequently used mechanism in practice.

Entity beans are different from session beans. Session beans model a process

or workflow (actions that are started by the user and that go away when the

user goes away). Entity beans, on the other hand, contain core business data—

product information, bank accounts, orders, lead tracking information,

Introduction to Entity Beans 123

customer information, and more. An entity bean does not perform complex

tasks or workflow logic, such as billing a customer. Rather, an entity bean is the

customer itself. Entity beans represent persistent state objects (things that

don’t go away when the user goes away).

For example, you might want to read a bank account data into an entity

bean instance, thus loading the stored database information into the in-mem-

ory entity bean instance’s fields. You can then play with the Java object and

modify its representation in memory because you’re working with convenient

Java objects, rather than bunches of database records. You can increase the

bank account balance in-memory, thus updating the entity bean’s in-memory

bank account balance field. Then you can save the Java object, pushing the

data back into the underlying store. This would effectively deposit money into

the bank account.

The term entity bean is not always used stringently. Sometimes it refers to

an in-memory Java object instance of an entity bean class, and sometimes it

refers to database data that an in-memory Java object instance represents.

To make the distinction clear, we will use the following two terms:

The entity bean instance is the in-memory view into the database. It is an

instance of your entity bean class.

The entity bean data (or data instance) is the physical set of data, such as a

bank account record, stored in the database.

In summary, you should think of an entity bean instance as the following:

■■ An in-memory Java representation of persistent data that knows how to

read itself from storage and populate its fields with the stored data

■■ An object that can then be modified in-memory to change the values of

data

■■ Persistable, so that it can be saved back into storage again, thus updat-

ing the database data

lets understand all the topics in depth without missing everrything

has 2 figures

6.1 object relational mapping

6.2 example of object relational mapping

---

**Gemini**

Bhai, ab tum EJB ke sabse important aur data-driven part par aa gaye ho: **Entity Beans**. Abhi tak hum jo padh rahe the (Session Beans) wo "Kaam" (Actions) karte the. Ab hum un beans ko padhenge jo "Data" (Information) store karte hain.

Chalo is chapter ko ekdum in-depth aur asaan Hinglish mein decode karte hain.

---

### 1\. Persistence Concepts & Object-Relational Mapping (O/R Mapping)

"Persistence" ka matlab hota hai data ko hamesha ke liye save karna (RAM se nikal kar Hard Drive/Database mein daalna). Java mein data ko save karne ke do tareeke the:

1. **Serialization:** Pure object ko ek "Blob" (kachre ka dher ya zip file) bana kar save kar do. Iska nuksan ye hai ki tum is data ko search ya filter nahi kar sakte.
2. **Object-Relational Mapping (ORM):** EJB isko use karta hai. Isme hum object ke tukde karte hain aur use SQL database (jaise Oracle, MySQL) ki Table mein save karte hain.

**Figure 6.1 aur 6.2 ka Explanation:**

- **Figure 6.1 (The Concept):** Socho tumhare paas ek `BankAccount` naam ka Java Object hai jisme `accountID` aur `balance` variables hain. ORM ke through, ek "Database API" (jaise JDBC) is object ko todta hai, aur database ki "Bank Account Table" ke alag-alag columns mein save kar deta hai.
- **Figure 6.2 (The Example):** Ye map kuch is tarah banta hai:
	- **Java Class (`Account`) Database Table (`Account Table`)**
		- **Class Variables (`accountID`, `balance`) Table Columns (Fields)**
		- **Java Object Instance (Ek specific customer ka object) Table Row (Ek specific record)**
		- *Example:* Agar memory mein ek object hai jisme "Ray Combs" ka data hai, toh wo database table ki us Row ko represent karta hai jahan account ID 1 aur balance 1000 hai.

**ORM ke Fayde:** Kyunki data proper rows aur columns mein save hota hai, tum asani se SQL queries chala sakte ho. Jaise: *"Mujhe wo saare objects laa kar do jinka balance $1000 se zyada hai."* Serialization mein ye possible nahi tha.

**Tools:** Pehle log `JDBC` use karke khud SQL queries (`INSERT`, `UPDATE`) likhte the. Lekin ye bahut lamba aur thakane wala kaam tha. Aaj kal **Hibernate** ya **TopLink** (jo aajkal ke Django ORM ya Prisma ki tarah hain) use hote hain jo Java Object ko apne aap Database table se sync kar dete hain.

---

### 2\. What is an Entity Bean? (Nouns vs Verbs)

Is section mein author ne EJB ke architecture ka sabse bada logic bataya hai. Ek bade system mein 2 tarah ke components hote hain:

- **Application Logic Components (The Verbs/Actions):** \* Ye wo code hai jo koi *Kaam* karta hai. Jaise: Bill generate karna, discount calculate karna.
	- Ye **Session Beans** hote hain. Ye "User Session" represent karte hain aur user ke jate hi khatam ho jate hain.
- **Persistent Data Components (The Nouns/Things):**
	- Ye wo code hai jo *Data* hold karta hai. Jaise: Bank Account, Employee, Customer.
		- Ye **Entity Beans** hote hain. Inka kaam logic chalana nahi, balki data ko safe rakhna hai.

---

### 3\. Entity Beans ki Khaasiyat (Differences from Session Beans)

Exam ke liye ye 3 points sabse crucial hain:

1. **Identity (Pehchaan):** Har Entity Bean ki ek Primary Key hoti hai (jaise Account Number). Tum do Entity Beans ko compare kar sakte ho. Session beans sab ek jaisi hoti hain (Stateless pool yaad hai?), unki koi identity nahi hoti.
2. **Shared by Clients:** Ek hi "Ray Combs ke Bank Account" wali Entity Bean ko 10 alag-alag clients ek sath read ya update kar sakte hain. Session bean ek baar mein sirf ek client se baat karti hai.
3. **Independent Lifetime:** Session bean tab marti hai jab client browser band karta hai ya server crash hota hai. Entity bean **Hamesha zinda rehti hai**. Agar server crash ho gaya, toh server restart hone par wo database se data padh kar wapas zinda (re-instantiate) ho jayegi.

---

### 4\. Entity Beans hi kyun? Direct raw database rows kyun nahi?

Tum sochoge, *"Bhai jab data database mein hi pada hai, toh Java code mein itna bada Entity Bean kyun banau? Direct SQL kyu na likhu?"*

- **Easier Management:** Data ko object (Entity Bean) ke roop mein handle karna aasan hai. Tum us object mein chhote functions daal sakte ho, jaise `getAccountBalance()`.
- **Implicit Middleware Services:** Jab tum Entity Bean banate ho, toh EJB Server tumhe **Security**, **Network Accessibility**, aur **Transactions** free mein deta hai. Agar koi transaction fail hua, toh server khud rollback kar dega, tumhe SQL mein rollback nahi likhna padega.

---

### 5\. The Terminology (Sabse zyada confuse karne wala point)

Book ke end mein author clear karta hai ki "Entity Bean" word do cheezon ke liye use hota hai. Tumhe inme difference pata hona chahiye:

1. **Entity Bean Data (Data Instance):** Ye wo asli data hai jo **Hard Drive / Database Table** mein permanently save hai. (e.g., Row #1 in MySQL).
2. **Entity Bean Instance:** Ye us data ka **RAM (Memory) ke andar ek Java Object / View** hai.

**Workflow:**

- Jab client ko data chahiye, server *Entity Bean Data* (Database) ko padhta hai aur usko ek *Entity Bean Instance* (RAM) mein daal deta hai.
- Client memory wale Instance ko modify karta hai (jaise balance badhana).
- Kaam khatam hone par, EJB Server memory wale Instance ke changes ko wapas Database (Entity Bean Data) mein save kar deta hai.

Bhai, Chapter 6 ka ye core foundation tha. Ye Object-Relational Mapping (ORM) ka concept modern backend development ki jaan hai! Sab clear hai? Aage **Chapter 7 (Bean-Managed Persistence)** pe badhein jahan hum literally inko code karenge?

---

**You**

EJB offers an alternative to bean-managed persistence: You can have your

EJB container perform your persistence for you. This is called container-man-

aged persistence. In this case, you would usually strip your bean of any persis-

tence logic. Then, you inform the container about how you’d like to be

persisted by using the container’s tools. The container then generates the data

access code for you. For example, if you’re using a relational database, the con-

tainer may automatically perform SQL INSERT statements to create database

data. Similarly, it will automatically perform SQL DELETE statements to

remove database data, and it will handle any other necessary persistent oper-

ations. Even if you are not working with a relational database, you can have

your container persist for you. If your container supports a nonrelational per-

sistent store, such as an object database or a VSAM file, the container will gen-

erate the appropriate logic as necessary. In fact, you can wait until deployment

time before you set up the O/R mapping, which is great because you can write

storage-independent data objects and reuse them in a variety of enterprise

environments.

Container-managed persistence reduces the size of your beans tremen-

dously because you don’t need to write JDBC code—the container handles all

the persistence for you. This is a huge value-add feature of EJB. Of course, it is

still evolving technology. Once we’ve written a few entity beans, we’ll review

the trade-offs of bean-managed versus container-managed persistence (see

Chapter 16).

Creation and Removal of Entity Beans

As we mentioned earlier, entity beans are a view into a database, and you

should think of an entity bean instance and the underlying database as one

and the same (they are routinely synchronized). Because they are one and the

same, the initialization of an entity bean instance should entail initialization of

database data. Thus, when an entity bean is initialized in memory during

ejbCreate(), it makes sense to create some data in an underlying database that

correlates with the in-memory instance. That is exactly what happens with

entity beans. When a bean-managed persistent entity bean’s ejbCreate()

132 Chapter 6

method is called, the ejbCreate() method is responsible for creating database

data. Similarly, when a bean-managed persistent entity bean’s ejbRemove()

method is called, the ejbRemove() method is responsible for removing database

data. If container-managed persistence is used, the container will modify the

database for you, and you can leave these methods empty of data access logic.

Let’s look at this in more detail.

Understanding How Entity Beans Are Created and Destroyed

In EJB, remember that clients do not directly invoke beans—they invoke an

EJB object proxy. The EJB object is generated through the home object. There-

fore, for each ejbCreate() method signature you define in your bean, you must

define a corresponding create() method in the home interface. The client calls

the home object’s create() method, which delegates to your bean’s ejbCreate()

method.

For example, let’s say you have a bank account entity bean class called

AccountBean, with a remote interface Account, home interface AccountHome,

and primary key class AccountPK. Given the following ejbCreate() method in

AccountBean:

public AccountPK ejbCreate(String accountID, String owner) throws...

you must have this create() method in your home interface (notice there is no

“ejb” prefix):

public Account create(String accountID, String owner) throws...

Notice that there are two different return values here. The bean instance

returns a primary key (AccountPK), while the home object returns an EJB object

(Account). This makes sense—the bean returns a primary key to the container

(that is, to the home object) so that the container can identify the bean. Once

the home object has this primary key, it can generate an EJB object and return

that to the client. We show this process more rigorously with the sequence dia-

gram in Figure 6.6.

Introduction to Entity Beans 133

Figure 6.6 Creating an entity bean and EJB object.

To destroy an entity bean’s data in a database, the client must call remove() on

the EJB object or home object. This method causes the container to issue an

ejbRemove() call on the bean. Figure 6.7 shows the relationship between remove()

and ejbRemove(). Note that remove() can be called on either the home object or

the EJB object. Figure 6.7 happens to assume bean-managed persistence.

EJB Container/Server

Entity Bean

Instance

Home Object

EJB Object

Client Code

1: create()

2: ejbCreate()

Relationship between create()

and ejbCreate().

(Diagram leaves out a few minor

steps and happens to assume

bean-managed persistence.)

Database

Entity Bean Data

3: Create Database Data

5: Create EJB Object

6: Return EJB Object 4: Return Primary Key

134 Chapter 6

Figure 6.7 Destroying an entity bean’s data representation.

Note that ejbRemove() does not mean the in-memory entity bean instance is

actually going to be destroyed; ejbRemove() destroys only database data and

makes the entity bean inaccessible to the client. The bean instance can be recy-

cled by the container to handle a different database data instance, such as a

bank account bean representing different bank accounts.

ejbRemove() is a required method of all entity beans, and it takes no parame-

ters. There is only one form of ejbRemove(). With entity beans, ejbRemove() is not

called if the client times out because the lifetime of an entity bean is longer

than the client’s session.

EJB Container/Server

Entity Bean

Instance

Home Object

EJB Object

Client Code

1: remove()

2: ejbRemove()

Database

Entity Bean Data

3: Remove Database Data

1: remove() 2: ejbRemove()

Relationship between remove()

and ejbRemove().

Note that remove() can be

called on either the home

object or the EJB object.

(Diagram happens to assume

bean-managed persistence.)

Introduction to Entity Beans 135

Entity Beans Can Be Found

Because entity bean data is uniquely identified in an underlying storage, entity

beans can also be found rather than created. Finding an entity bean is analo-

gous to performing a SELECT statement in SQL. With a SELECT statement,

you’re searching for data from a relational database store. When you find an

entity bean, you’re searching a persistent store for some entity bean data. This

differs from session beans because session beans cannot be found: They are not

permanent objects, and they live and die with the client’s session.

You can define many ways to find an entity bean. You list these ways as

methods in your entity bean home interface. These are called finder methods.

Your home interface exposes finder methods in addition to methods for creat-

ing and destroying entity beans. This is the one big difference between an

entity bean’s home interface and other types of beans; the other bean types do

not have finder methods.

You Can Modify Entity Bean Data without Using EJB

Usually you will create, destroy, and find entity bean data by using the entity

bean’s home object. But you can interact with entity beans another way, too: by

directly modifying the underlying database where the bean data is stored. For

example, if your entity bean instances are being mapped to a relational data-

base, you can simply delete the rows of the database corresponding to an

entity bean instance (see Figure 6.8). You can also create new entity bean data

and modify existing data by directly touching the database. This may be nec-

essary if you have an investment in an existing system that touches a database

directly.

These external database updates could raise cache consistency issues if

you’re choosing to cache your entity beans. See Chapter 19 for more details.

136 Chapter 6

Figure 6.8 Modifying an entity bean’s database representation manually.

Entity Contexts

As you learned in Chapter 3, all enterprise beans have a context object that iden-

tifies the environment of the bean. These context objects contain environment

information that the EJB container sets. Your beans can access the context to

retrieve all sorts of information, such as transaction and security information.

For entity beans, the interface is javax.ejb.EntityContext.

We provide a refresher of the javax.ejb.EJBContext methods in Source 6.1.

Appendix E explains the meaning of each method.

Entity contexts add the methods in Source 6.2 on top of the generic EJB context.

Relational Database

Entity Bean

Data

Existing App

Direct Database Modifications

EJB Container/Server

Entity Beans

O/R Mapping

Introduction to Entity Beans 137

public interface javax.ejb.EJBContext {

public javax.ejb.EJBHome getEJBHome();

public javax.ejb.EJBLocalHome getEJBLocalHome();

public java.security.Principal getCallerPrincipal();

public boolean isCallerInRole(java.lang.String);

public void setRollbackOnly();

public boolean getRollbackOnly();

}

Source 6.1 The javax.ejb.EJBContext interface.

public interface javax.ejb.EntityContext

extends javax.ejb.EJBContext {

public javax.ejb.EJBLocalObject getEJBLocalObject();

public javax.ejb.EJBObject getEJBObject();

public java.lang.Object getPrimaryKey();

}

Source 6.2 The javax.ejb.EntityContext interface.

Let’s look at each of these methods in more detail.

getEJBLocalObject() / getEJBObject()

Call the getEJBObject() method to retrieve the current, client-specific EJB object

that is associated with the entity bean. Remember that clients invoke on EJB

objects, not on entity beans directly. Therefore, you can use the returned EJB

object as a way to pass a reference to yourself, simulating the this argument in

Java. getEJBLocalObject() is the same, except it gets the more optimized EJB

local object.

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

resenting.

Summary

In this chapter, we’ve taken the first steps toward developing with entity

beans. We started by discussing various persistence mechanisms, including

object serialization, object/relational mapping, and persistence to pure object

databases. We then looked at what an entity bean is, and we listed the files

included with an entity bean component. After surveying their features, we

took a look at entity contexts.

6.8 is modifyinf an entity bean db representation manually

6.7 is destroying an entity bean db representation

6.6 is creating an entity bean and ejb object

6.5 is passivation of entity beans entails a state save and activation entials a state load

6.4 ejb container pooling of entity beans

6.3 is loading and storing of entity beans.

lets understand the book language in depth and get the concepts

---

**Gemini**

Bhai, ye Chapter 6 ka concluding part hai aur Entity Beans ke mechanics ka core hai. Isko directly EJB ke flow se map karte hain, specifically focusing on creation, deletion, finding, and context.

Here's a breakdown of the textbook concepts in clear Hinglish.

---

### 1\. Container-Managed Persistence (CMP) vs Bean-Managed Persistence (BMP)

- **The Core Difference:**
	- **BMP (Bean-Managed Persistence):** Developer (Tum) bean class ke andar khud raw JDBC code (`INSERT INTO Account...`) likhta hai.
		- **CMP (Container-Managed Persistence):** EJB Container (Server) tumhare liye SQL code generate karta hai aur execute karta hai. Tum apni bean se saari persistence logic (SQL queries) hata dete ho aur sirf O/R Mapping tool ko use karte ho.
- **Why CMP?** CMP tumhari bean ka size chota karta hai aur database porting (MySQL se Oracle jaana) aasan karta hai, kyunki SQL server handle kar raha hai, tum nahi.

---

### 2\. Creation and Removal (Figures 6.6 & 6.7)

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

### 3\. Finder Methods (The "SELECT" statement of EJB)

- **The Concept:** Entity Beans ko sirf create nahi kiya jata, purane data ko *dhoondha* bhi jata hai. Ye Session Beans mein nahi hota.
- **How it works:** Home Interface mein `findByPrimaryKey(String id)` jaise methods hote hain. Ye SQL ke `SELECT * FROM table WHERE id = ?` ke barabar hote hain.

---

### 4\. Modifying Data Externally (Figure 6.8)

- **The Reality:** Har application EJB ke through database touch nahi karti. Kuch purane (legacy) systems direct database query chala kar row update kar sakte hain.
- **The Danger:** Agar ek direct script ne database mein account balance update kar diya, par EJB Server ki RAM (Cache) mein abhi bhi purana balance loaded hai, toh "Cache Inconsistency" (data mismatch) ho jayega. (Ye Chapter 19 ka topic hai, par architecture mein yaad rakhna zaroori hai).

---

### 5\. Entity Context (EntityContext Interface)

Jaise Session Context tha, waise hi Entity Context bean ka server se baat karne ka tareeka hai. Isme do sabse important naye methods aate hain:

1. **`getEJBLocalObject()` / `getEJBObject()`:** Agar bean ko apna hi proxy (bodyguard) kisi aur ko pass karna hai, toh wo `this` keyword use nahi karegi. Wo context se apna EJB Object mangegi aur wo pass karegi.
2. **`getPrimaryKey()` (SUPER IMPORTANT FOR EXAM):**
	- **The Problem:** Entity beans pooled hoti hain. Ek hi memory object kabhi Account ID 1 handle karta hai, kabhi ID 2.
		- **The Solution:** Jab container `ejbLoad()` (data RAM mein laao) ya `ejbRemove()` (data delete karo) call karta hai, toh bean ko kaise pata chalega ki *kaunse* customer ka data load/delete karna hai?
		- Bean `ctx.getPrimaryKey()` call karti hai, jo use batata hai: "Abhi tum Account ID 5 ko represent kar rahi ho, jao 5 number ka data load karo."

---

### Visualizing the Flow (Mind Map)

1. **Client:** Mujhe Ray ka account dikhao.
2. **Home Object:** `findByPrimaryKey("Ray123")` call karta hai.
3. **Container:** Pool se ek khaali Entity Bean uthata hai.
4. **Context Action:** Container us bean ka `EntityContext` set karta hai aur usme Primary Key "Ray123" daal deta hai.
5. **Activation:** Container `ejbLoad()` call karta hai. Bean context se "Ray123" padhti hai aur Database se `SELECT` query marke data RAM mein bhar leti hai.
6. **Proxy:** Container client ko EJB Object (Proxy) de deta hai jisse client baat karega.

Bhai, Chapter 6 yahan khatam hota hai. Isne BMP aur CMP ka theoretical ground clear kar diya hai. Ab batao, kya main directly Chapter 7 (Writing BMP Entity Beans) pe jaau, ya isme ORM/Context mein koi deep doubt hai?

---

**You**

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

---

**Gemini**

Bhai, ye specific page EJB ke sabse tricky concept— **"The Identity Crisis of Entity Beans"** —ko explain karta hai. Exam mein BMP (Bean-Managed Persistence) par question aaye, toh ye `getPrimaryKey()` ka logic likhna full marks dilaiga.

Isko direct aur simple Hinglish mein samajhte hain:

### 1\. The Problem: Bean ko "Identity Crisis" hota hai

- **Context:** Session Beans ki tarah, Entity Beans bhi RAM mein **Pooled** (ek group mein) hoti hain.
- **The Issue:** Server RAM bachane ke liye ek hi Entity Bean instance ko reuse karta hai. Abhi ye bean 'Account 101' ka data handle kar rahi thi, 5 minute baad server isse 'Account 505' ka data handle karne ko de dega.
- **The Crisis:** Jab server is bean ko wapas jagata hai (activate karta hai), toh bean ko **khud nahi pata hota** ki wo abhi kis customer ka data represent kar rahi hai!

### 2\. The Solution: getPrimaryKey()

Is identity crisis ka ek hi ilaaj hai: `getPrimaryKey()` method. Bean apne EJB Context (Server) se puchti hai: *"Bhai, meri current identity kya hai?"* Server use ek Primary Key (jaise ID = 505) de deta hai. Isse bean ko pata chal jata hai ki use kis database row par operation perform karna hai.

---

### 3\. Kahan aur Kyun use hota hai? (The Core Logic)

Book ne do methods ko highlight kiya hai jahan iski sabse zyada zaroorat padti hai. Ise dhyan se samajhna:

#### Case A: ejbLoad() (Database se RAM mein data laana)

- **Scenario:** Server bean ko bolta hai, "Jaake database se data RAM mein load karo."
- **Confusion:** Bean sochti hai, "Kiska data load karu? Pooled hone ki wajah se mujhe toh pata hi nahi ki main kaun hoon."
- **Action:** Bean `getPrimaryKey()` call karti hai. Use milta hai ID = `505`. Phir wo database mein raw SQL fire karti hai: `SELECT * FROM table WHERE id = 505`. Ab sahi data memory mein aa jata hai.

#### Case B: ejbRemove() (Database se data hamesha ke liye mitana)

- **Scenario:** Server bean ko bolta hai, "Database se record delete kar do."
- **Confusion:** Bean sochti hai, "Agar maine bina confirm kiye delete SQL chala di, toh galti se kisi aur customer ka data delete ho jayega!" (Kyunki `ejbRemove()` mein koi parameter pass nahi hota).
- **Action:** Bean confirm karne ke liye `getPrimaryKey()` call karti hai. Use ID milti hai. Phir wo SQL chalati hai: `DELETE FROM table WHERE id = 505`.

---

###  Exam Trick Question:

- **Q:** *`ejbLoad()` mein `getPrimaryKey()` chahiye, par `ejbStore()` (RAM se Database mein save karna) mein kyun nahi chahiye?*
- **Ans:** Kyunki jab `ejbStore()` call hota hai, toh data pehle se hi RAM (Bean ki memory) mein loaded hota hai. Bean ko apna account number pehle se pata hota hai jo memory mein saved hai, toh usko alag se context se ID mangne ki zaroorat nahi padti.

**In Short:** EJB Pooling ki wajah se server ki RAM bachti hai, par bechari Entity Bean ko apna naam baar-baar `getPrimaryKey()` se yaad karna padta hai jab use database se read (`ejbLoad`) ya delete (`ejbRemove`) karna ho.

Ye Chapter 6 ka aakhiri theory part tha. Ab agla step **Chapter 7 (Writing BMP Entity Beans)** hai, jahan hum in baaton ko actual code (SQL queries ke sath) mein badalte hue dekhenge. Shuru karein Chapter 7?

---

**You**

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

---

**Gemini**

Ani bhai, lagta hai tumne galti se wahi paragraph dobara paste kar diya!  Maine just pichle message mein is "Identity Crisis" wale logic ko detail mein explain kiya tha.

Ekdum short mein wapas yaad dila deta hoon: Kyunki server RAM bachane ke liye ek hi Entity Bean ko alag-alag customers ke liye reuse (pool) karta hai, bean ko khud nahi pata hota ki wo currently kisko represent kar rahi hai. Isliye jab bhi usko database se data load ya delete karna hota hai, wo `getPrimaryKey()` call karke apni current identity (jaise Account ID) confirm karti hai taaki kisi galat customer ka data delete na ho jaye.

Agar is specific paragraph ki kisi line mein abhi bhi doubt hai toh pooch lo, warna hum seedha **Chapter 7 (Writing BMP Entity Beans)** par attack karein?

---

**You**

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

---

**Gemini**

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

### In Short (The Exact Core Logic):

Kyunki ek hi Java object alag-alag data records ke beech switch (reuse) ho raha hai, aur EJB Server switch karte waqt us object ko uska naya naam/ID bata kar nahi bhejta. Isliye us Java object ko code ke through `getPrimaryKey()` chala kar khud apna naya ID context se nikalna padta hai.

Ab ye ekdum strictly book-to-brain clear hua?

---

**You**

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

throws FinderException {... }

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

throws FinderException {... }

/\*\*

\* Finds all the product entity beans. Returns a Collection

\* of primary keys.

148 Chapter 7

\*/

public Collection ejbFindAllProducts()

throws FinderException {... }

/\*\*

\* Finds all Bank Accounts that have at least a minimum balance.

\* Returns a Collection of primary keys.

\*/

public Collection ejbFindBigAccounts(int minimum)

throws FinderException {... }

/\*\*

\* Finds the most recently placed order

\*/

public OrderPK ejbFindMostRecentOrder()

throws FinderException {... }

Another interesting aspect of finders is that they can return collections. Your

database search may turn up more than one result and therefore more than one

entity bean. Here is the local home interface signature:

public Collection findAllProducts() throws FinderException;

And here is the bean implementation signature:

public Collection ejbFindAllProducts()

throws FinderException {... }

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

---

**Gemini**

Bhai, ye Chapter 7 EJB ka sabse practical aur coding-heavy hissa hai. **Bean-Managed Persistence (BMP)** mein developer ko apna SQL aur JDBC code khud likhna padta hai. Isliye isme code ki details samajhna exam point of view se bahut zaroori hai.

Pehle is book ka Table 7.1 aur Finder methods ka concept ekdum deep aur simple Hinglish mein decode karte hain, kyunki ye interviews aur exams dono mein poochha jata hai.

---

### 1\. The Two Interfaces of an Entity Bean

Entity bean ka class likhne se pehle tumhe EJB ki base interfaces samajhni hongi:

- **`javax.ejb.EnterpriseBean`:** Ye ek "Marker Interface" hai. Isme koi method nahi hota. Ye bas Java ko batata hai ki ye ek special EJB object hai.
- **`javax.ejb.EntityBean`:** Ye interface EJB Container ko hooks (callbacks) deti hai. Isme 7 required methods hote hain jo tumhari bean class ko implement (override) karne hi padte hain: `setEntityContext`, `unsetEntityContext`, `ejbRemove`, `ejbActivate`, `ejbPassivate`, `ejbLoad`, `ejbStore`.

---

### 2\. The 10 Callbacks of BMP (Table 7.1 Decoded)

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

### 3\. The Finder Methods in Depth

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
	- `ejbFindAllProducts()` Returns `Collection` (of multiple keys).
		- `ejbFindBigAccounts(int min)` Returns `Collection`.

---

**Summary for the code ahead:** Ab jo actual code (e.g., `Account.java`, `AccountBean.java`) aayega, usme tumhe bas yahi dekhna hai ki in methods ke andar JDBC ka code kaise fit kiya gaya hai. Database connection kaise open hua aur `ResultSet` kaise read kiya gaya.

Batao, `ejbLoad()` vs `ejbStore()` ka flow clear hai? Hum seedha Bank Account ke example code par move karein?

---

**You**

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

try { if (pstmt!= null) pstmt.close(); }

catch (Exception e) { }

try { if (conn!= null) conn.close(); }

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

... continued...

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

“delete from accounts where id =?”);

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

try { if (pstmt!= null) pstmt.close(); }

catch (Exception e) { }

try { if (conn!= null) conn.close(); }

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

\+ “where id =?”);

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

try { if (pstmt!= null) pstmt.close(); }

catch (Exception e) { }

Source 7.10 (continued)

164 Chapter 7

try { if (conn!= null) conn.close(); }

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

“update accounts set ownerName =?, balance =?”

\+ “ where id =?”);

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

try { if (pstmt!= null) pstmt.close(); }

catch (Exception e) { }

try { if (conn!= null) conn.close(); }

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

\+ “ values (?,?,?)”);

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

try { if (pstmt!= null) pstmt.close(); }

catch (Exception e) { }

try { if (conn!= null) conn.close(); }

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

if (account!= null) {

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

---

**Gemini**

Bhai, ye Chapter 7 ka grand finale hai. Isme actual Bank Account ka example run ho raha hai aur sabse important topic **BMP Entity Bean Life Cycle (Figure 7.3)** detail mein explain kiya gaya hai.

Kyunki tumhara EJB aur J2EE architecture ka exam kaafi pass hai (aur shayad aage Spring Boot wagerah mein bhi ye concepts indirectly help karein), isliye is diagram ko dimaag mein chhap lena sabse zaroori hai. Chalo isse step-by-step todte hain.

---

### 1\. The Bank Account Code Analysis (Source 7.9, 7.10, 7.12)

Book ne ek bada Bank Account bean likha hai. Uski key baatein kya hain?

- **`ejbHomeGetTotalBankValue()`:** Ye ek "Home Method" hai. Matlab isko call karne ke liye kisi specific customer ka account nahi chahiye. Ye sabhi accounts ka total nikal raha hai (`SELECT sum(balance) FROM accounts`). Isiliye ye *Pooled* state se chalta hai.
- **`getConnection()` helper:** Tumne dekha hoga har method (create, load, store, remove) ke shuru mein `getConnection()` call hota hai aur end mein `finally` block mein connection `close()` hota hai. Ye isliye kiya jata hai taaki database connections ka bhi ek pool maintain ho sake aur unhe block na karna pade.
- **The Client Flow (`Source 7.12`):** Client ne JNDI se connection liya naya account create kiya deposit call kiya `withdraw(150)` kiya (jisse exception aayi kyunki balance 100 tha) aur finally `remove()` call karke record delete kar diya.

---

### 2\. The Deployment Descriptor (ejb-jar.xml - Source 7.13)

Is XML file mein Session Bean aur Entity Bean ke beech ka fark saaf dikhta hai:

- `<persistence-type>Bean</persistence-type>`: Ye line EJB server ko batati hai ki ye BMP hai (matlab SQL queries developer ne khud code mein likhi hain). Agar ye CMP hota, toh yahan "Container" likha hota.
- `<prim-key-class>`: Ye property batati hai ki is data ka primary key (ID) ka format kya hai (e.g., `String` ya custom class).
- `<reentrant>false</reentrant>`: Ye threading se bachaata hai. Agar true hota, toh ek bean apne aap ko hi wapas call kar sakti thi (loop mein), jo ki aamtaur par avoid kiya jata hai.

---

### 3\. The Ultimate Map: BMP Entity Bean Life Cycle (Figure 7.3)

Ye diagram (page 178) tumhare Unit 5 ka confirm exam question hai. Ise 3 main "States" (hissay) mein samjho.

#### State A: Does Not Exist

- Abhi tak server par koi Java object nahi bana hai.

#### State B: The "Pooled" State (The Waiting Room)

1. **Entering the Pool:** Server RAM mein naya object banata hai (`newInstance()`) aur usko uska environment deta hai (`setEntityContext()`). Ab ye bean "Pool" (Waiting Room) mein aa gayi hai.
2. **What can it do here?** Is state mein bean ke paas kisi customer ka data nahi hota. Lekin ye do kaam kar sakti hai:
	- `ejbFind()` chalana (Kisi ka account dhoondna).
		- `ejbHome()` chalana (Jaise total bank balance nikalna).
3. **Leaving the Pool (To Death):** Agar server ko lagta hai ki RAM free karni hai, toh wo `unsetEntityContext()` call karke bean ko kachre mein (Garbage Collection) daal dega.

#### State C: The "Ready" State (The Active Worker)

Yahan bean kisi specific customer (e.g., "Account ID: 123") se judd jati hai aur EJB Object (Proxy) se attach ho jati hai.

- **Entering Ready State (Creation):** Client naya account banata hai. `ejbCreate()` chalta hai (INSERT query), fir `ejbPostCreate()` chalta hai. Ab bean *Ready* hai.
- **Entering Ready State (Activation):** Server purane account ko uthata hai. `ejbActivate()` chalta hai (sockets open hote hain), fir `ejbLoad()` chalta hai (SELECT query chalake data RAM mein aata hai). Ab bean *Ready* hai.
- **While in Ready State:** Ab client is par business methods (`deposit()`, `withdraw()`) call kar sakta hai.
- **Leaving Ready State (Passivation):** Agar bean idle padi hai, server usse wapas Pool mein daalna chahta hai. Pehle `ejbStore()` chalta hai (UPDATE query se data save), fir `ejbPassivate()` chalta hai (sockets band). Bean wapas Pool mein chali jati hai.
- **Leaving Ready State (Deletion):** Agar client account band karna chahe. `ejbRemove()` chalta hai (DELETE query). Record database se khatam, aur bean wapas khali hoke Pool mein chali jati hai.

---

### Exam Tip for Animesh (Ani)

Tum GATE CSE 2027 aur placements ki taiyari kar rahe ho, toh DBMS (Database) concepts tumhare clear honge. EJB BMP kuch nahi hai, bas **SQL CRUD operations ko Java class ke alag-alag life-cycle methods mein fit karne ka tareeka hai.**

- Create = `ejbCreate` (INSERT)
- Read = `ejbLoad` (SELECT)
- Update = `ejbStore` (UPDATE)
- Delete = `ejbRemove` (DELETE)

Chapter 7 khatam! Yahan tumhara BMP pura hota hai. CMP (Chapter 8) mein bas ye saara SQL Container khud likhega. Is Life Cycle mein kis arrow ya transition pe sabse zyada doubt hai?

---

**You**

see the entire code, and give me the account section code, without the exception handlingn fluff only the important code as its too long and explain it too

---

**Gemini**

Bhai, ekdum sahi demand hai. Book wale code mein `try-catch`, `finally`, aur `System.out.println` itna zyada hota hai ki asli logic chhip jata hai.

Exam mein agar BMP ka code likhne ko aaye, toh tumhe sirf **Core SQL Logic** dikhana hota hai. Maine us pure `AccountBean` code se saara "fluff" hata diya hai. Sirf wahi rakha hai jo actual kaam kar raha hai.

Isko dekho, ye ekdum crystal clear hai:

### The Simplified AccountBean (BMP Core Code)

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

### Code Explanation (Exam ke liye yaad rakhne wale points):

1. **Mapping Samajh lo:** \* `ejbCreate` = **INSERT**
	- `ejbLoad` = **SELECT**
		- `ejbStore` = **UPDATE**
		- `ejbRemove` = **DELETE**
2. **Context ka Magic:** Dhyan se dekho `ejbLoad` aur `ejbRemove` ko. Unke parameters khali `()` hote hain. Unhe account ka ID milta kahan se hai? Pehli line dekho: `ctx.getPrimaryKey()`. Ye wahi concept hai jo humne pichle messages mein deeply discuss kiya tha.
3. **Business Methods (Deposit/Withdraw):** In methods ke andar koi database connection nahi khula hai! Client jab deposit call karta hai, toh bas Java ka variable `this.balance += amt;` badalta hai. Phir transaction ke end mein EJB Server khud `ejbStore()` chala deta hai, jo naye balance ko database mein **UPDATE** kar deta hai.

Bhai, fluff hatne ke baad EJB ka BMP sirf basic JDBC CRUD operation lagta hai, haina? Exam mein agar iska snippet pucha jaaye toh strictly bas ye SQL queries aur context logic likh dena, examiner samajh jayega ki tumhe core architecture aata hai.