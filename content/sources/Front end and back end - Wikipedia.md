---
title: "Front end and back end - Wikipedia"
created: 2026-04-12
description:
tags:
  - "backend"
---
In [software development](https://en.wikipedia.org/wiki/Software_development "Software development"), **front end** refers to the [presentation layer](https://en.wikipedia.org/wiki/Presentation_layer "Presentation layer") that users interact with, while **back end** refers to the [data management](https://en.wikipedia.org/wiki/Data_management "Data management") and processing behind the scenes. "Full stack" refers to both together. In the [client–server model](https://en.wikipedia.org/wiki/Client%E2%80%93server_model "Client–server model"), the [client](https://en.wikipedia.org/wiki/Client_\(computing\) "Client (computing)") is usually considered the front end, handling most user-facing tasks, and the [server](https://en.wikipedia.org/wiki/Server_\(computing\) "Server (computing)") is the back end, mainly managing data and logic.

## Introduction

In [software architecture](https://en.wikipedia.org/wiki/Software_architecture "Software architecture"), there can be many [layers](https://en.wikipedia.org/wiki/Abstraction_layer "Abstraction layer") between the hardware and [end user](https://en.wikipedia.org/wiki/End-user_\(computer_science\)#End_user "End-user (computer science)"). The *front end* is an abstraction, simplifying the underlying components by providing a [user-friendly](https://en.wikipedia.org/wiki/User-friendly "User-friendly") interface, while the *back end* handles data storage and [business logic](https://en.wikipedia.org/wiki/Business_logic "Business logic").

## Examples

**E-commerce Website**: The front end is the user interface (e.g., product pages, search bar), while the back end processes payments and updates inventory.

**Banking App**: The front end displays account balances, while the back end handles secure transactions and updates records.

**Social Media Platform**: The front end shows the news feed, while the back end stores posts and manages notifications.

In [telecommunication](https://en.wikipedia.org/wiki/Telecommunication "Telecommunication"), the front end can be considered a device or service, while the back end is the infrastructure that supports the provision of services.

A [rule of thumb](https://en.wikipedia.org/wiki/Rule_of_thumb "Rule of thumb") is that the front end, or client side, includes any components manipulated by the user. The back end, or server side, usually resides on the [server](https://en.wikipedia.org/wiki/Server_\(computing\) "Server (computing)"), often far removed physically from the user.

## Software definitions

There are many different ways the terms 'front end' and 'back end' can be defined in the context of software. For example, in [content management systems](https://en.wikipedia.org/wiki/Content_management_system "Content management system"), the front end refers to views facing end users, and the back end refers to views facing administrative users.[^1] [^2] Similarly, within the field of [speech synthesis](https://en.wikipedia.org/wiki/Speech_synthesis "Speech synthesis"), the front end refers to the part of the synthesis system that converts the input text into a [symbolic](https://en.wikipedia.org/wiki/Symbol "Symbol") [phonetic](https://en.wikipedia.org/wiki/Phonetics "Phonetics") representation, and the back end converts the symbolic phonetic representation into actual sounds.[^3] In [programming language compilers](https://en.wikipedia.org/wiki/Compilers "Compilers"), the front end [translates](https://en.wikipedia.org/wiki/Translator_\(computing\) "Translator (computing)") computer [source code](https://en.wikipedia.org/wiki/Source_code "Source code") into an [intermediate representation](https://en.wikipedia.org/wiki/Intermediate_representation "Intermediate representation"), and the back end produces executable code from the intermediate representation. The back end usually [optimizes](https://en.wikipedia.org/wiki/Program_optimization "Program optimization") to produce code that runs faster. The front end/back end distinction can also separate a [parser](https://en.wikipedia.org/wiki/Parsing "Parsing") that deals with source code from a compiler that [generates and optimizes executable code](https://en.wikipedia.org/wiki/Code_generation_\(compiler\) "Code generation (compiler)"). Some designs, such as [GCC](https://en.wikipedia.org/wiki/GNU_Compiler_Collection "GNU Compiler Collection"), offer multiple front end options (parsing different source [languages](https://en.wikipedia.org/wiki/Programming_language "Programming language")) and multiple back end options (generating code for different target [processors](https://en.wikipedia.org/wiki/Central_processing_unit "Central processing unit")).[^4]

Some [graphical user interface](https://en.wikipedia.org/wiki/Graphical_user_interface "Graphical user interface") (GUI) applications act as a thin front end for underlying [command-line interface](https://en.wikipedia.org/wiki/Command-line_interface "Command-line interface") (CLI) programs, to save users from having to learn the CLI terminology and [commands](https://en.wikipedia.org/wiki/Command_\(computing\) "Command (computing)").

### Web development as an example

Another way to understand the differences between the front end and back end is to consider the knowledge that each requires of a [software developer](https://en.wikipedia.org/wiki/Software_developer "Software developer"). The example lists below focus on [web development](https://en.wikipedia.org/wiki/Web_development "Web development").

#### Front end

- Markup and web languages such as [HTML](https://en.wikipedia.org/wiki/HTML "HTML"), [CSS](https://en.wikipedia.org/wiki/CSS "CSS"), and [JavaScript](https://en.wikipedia.org/wiki/JavaScript "JavaScript"), as well as ancillary libraries commonly used in those languages, such as [Sass](https://en.wikipedia.org/wiki/Sass_\(stylesheet_language\) "Sass (stylesheet language)") or [jQuery](https://en.wikipedia.org/wiki/JQuery "JQuery")
- [Asynchronous](https://en.wikipedia.org/wiki/Asynchronous_I/O "Asynchronous I/O") request handling and [AJAX](https://en.wikipedia.org/wiki/Ajax_\(programming\) "Ajax (programming)")
- [Single-page applications](https://en.wikipedia.org/wiki/Single-page_application "Single-page application") with frameworks like [React](https://en.wikipedia.org/wiki/React_\(JavaScript_library\) "React (JavaScript library)"), [Angular](https://en.wikipedia.org/wiki/Angular_\(web_framework\) "Angular (web framework)") or [Vue.js](https://en.wikipedia.org/wiki/Vue.js "Vue.js")
- [Web performance](https://en.wikipedia.org/wiki/Web_performance "Web performance") (optimization of things like largest contentful paint, time to interactive, animation [FPS](https://en.wikipedia.org/wiki/Frame_rate "Frame rate"), and memory usage)
- [Responsive web design](https://en.wikipedia.org/wiki/Responsive_web_design "Responsive web design")
- [Cross-browser](https://en.wikipedia.org/wiki/Cross-browser "Cross-browser") compatibility issues and workarounds
- [End-to-end testing](https://en.wikipedia.org/wiki/Software_testing "Software testing") with a [headless browser](https://en.wikipedia.org/wiki/Headless_browser "Headless browser")
- [Build automation](https://en.wikipedia.org/wiki/Build_automation "Build automation") to transform and bundle JavaScript files, reduce image sizes, and handle other processes using tools such as [Webpack](https://en.wikipedia.org/wiki/Webpack "Webpack") and [Gulp.js](https://en.wikipedia.org/wiki/Gulp.js "Gulp.js")
- [Search engine optimization](https://en.wikipedia.org/wiki/Search_engine_optimization "Search engine optimization")
- [Accessibility](https://en.wikipedia.org/wiki/Web_accessibility "Web accessibility") concerns
- Image editing tools such as [GIMP](https://en.wikipedia.org/wiki/GIMP "GIMP") or [Photoshop](https://en.wikipedia.org/wiki/Adobe_Photoshop "Adobe Photoshop")
- [User interface](https://en.wikipedia.org/wiki/User_interface "User interface") design and creation

#### Back end

- [Scripting languages](https://en.wikipedia.org/wiki/Scripting_language "Scripting language") like [PHP](https://en.wikipedia.org/wiki/PHP "PHP"), [Python](https://en.wikipedia.org/wiki/Python_\(programming_language\) "Python (programming language)"), [Ruby](https://en.wikipedia.org/wiki/Ruby_\(programming_language\) "Ruby (programming language)"), [Perl](https://en.wikipedia.org/wiki/Perl "Perl"), and [Node.js](https://en.wikipedia.org/wiki/Node.js "Node.js")
- [Compiled languages](https://en.wikipedia.org/wiki/Compiled_language "Compiled language") like [C#](https://en.wikipedia.org/wiki/C_Sharp_\(programming_language\) "C Sharp (programming language)"), [Java](https://en.wikipedia.org/wiki/Java_\(programming_language\) "Java (programming language)"), and [Go](https://en.wikipedia.org/wiki/Go_\(programming_language\) "Go (programming language)")
- [Data access layer](https://en.wikipedia.org/wiki/Data_access_layer "Data access layer")
- [Business logic](https://en.wikipedia.org/wiki/Business_logic "Business logic")
- [Database administration](https://en.wikipedia.org/wiki/Database_administrator "Database administrator")
- [Scalability](https://en.wikipedia.org/wiki/Scalability "Scalability")
- [High availability](https://en.wikipedia.org/wiki/High_availability "High availability")
- Security concerns, such as [authentication](https://en.wikipedia.org/wiki/Authentication "Authentication") and [authorization](https://en.wikipedia.org/wiki/Authorization "Authorization")
- [Software architecture](https://en.wikipedia.org/wiki/Software_architecture "Software architecture")
- [Data transformation](https://en.wikipedia.org/wiki/Data_transformation "Data transformation")
- [Backup](https://en.wikipedia.org/wiki/Backup "Backup") methods and software

#### Front end and back end

- [Version control](https://en.wikipedia.org/wiki/Version_control "Version control") tools such as [Git](https://en.wikipedia.org/wiki/Git "Git"), [Mercurial](https://en.wikipedia.org/wiki/Mercurial "Mercurial"), and [Subversion](https://en.wikipedia.org/wiki/Apache_Subversion "Apache Subversion")
- [File transfer](https://en.wikipedia.org/wiki/File_transfer "File transfer") tools and protocols such as [FTP](https://en.wikipedia.org/wiki/FTP "FTP") and [rsync](https://en.wikipedia.org/wiki/Rsync "Rsync")

### API

The front end communicates with the back end through an [API](https://en.wikipedia.org/wiki/API "API"). In the case of [web](https://en.wikipedia.org/wiki/Web_API "Web API") and mobile front ends, the API is often based on [HTTP](https://en.wikipedia.org/wiki/HTTP "HTTP") requests/responses. An API can also reduce the front-end processing load by using different back-end services for different front-end interfaces, such as in the "Back end For Front end" (BFF) pattern.[^5]

## Hardware definitions

In [computer networking](https://en.wikipedia.org/wiki/Computer_network "Computer network"), *front end* can refer to [hardware](https://en.wikipedia.org/wiki/Networking_hardware "Networking hardware") that connects devices to the network, provides security such as a [DMZ](https://en.wikipedia.org/wiki/DMZ_\(computing\) "DMZ (computing)"), or converts data into a [transportable format](https://en.wikipedia.org/w/index.php?title=Network_Packet&action=edit&redlink=1 "Network Packet (page does not exist)"). *Back end* refers to hardware that handles and transports data within the network.

[^1]: ["Front End vs Back End of Your Website: Everything You Need to Know"](https://letsgodojo.com/front-end-vs-back-end/). *DOJO Creative*. 7 February 2020. [Archived](https://web.archive.org/web/20220901020406/https://letsgodojo.com/front-end-vs-back-end/) from the original on 1 September 2022. Retrieved 31 August 2022.

[^2]: Thapliyal, Vimal. ["Difference Between Frontend and Backend MVC – Joomlatuts"](https://web.archive.org/web/20161230230237/http://joomlatuts.net/joomla-2-5/87-how-backend-model-view-controller-mvc-works-in-joomla/98-difference-between-frontend-and-backend-mvc). *joomlatuts.net*. Archived from [the original](http://joomlatuts.net/joomla-2-5/87-how-backend-model-view-controller-mvc-works-in-joomla/98-difference-between-frontend-and-backend-mvc) on 30 December 2016. Retrieved 30 December 2016.

[^3]: Gutierrez--Osuna, Ricardo. ["L18: Speech synthesis (backend)"](https://web.archive.org/web/20190214183352/http://research.cs.tamu.edu/prism/lectures/sp/l18.pdf) (PDF). *tamu.edu*. Texas A&M University. Archived from [the original](http://research.cs.tamu.edu/prism/lectures/sp/l18.pdf) (PDF) on 14 February 2019. Retrieved 29 December 2016.

[^4]: Bin Muhammad, Rashid. ["Operating Systems Notes"](http://www.personal.kent.edu/~rmuhamma/Compilers/MyCompiler/phase.htm). *www.personal.kent.edu*. Kent State University. [Archived](https://web.archive.org/web/20180831090618/http://personal.kent.edu/~rmuhamma/Compilers/MyCompiler/phase.htm) from the original on 31 August 2018. Retrieved 30 December 2016.

[^5]: Wickramarachchi, Viduni (24 February 2021). ["The BFF Pattern (Backend for Frontend): An Introduction"](https://blog.bitsrc.io/bff-pattern-backend-for-frontend-an-introduction-e4fa965128bf). *Bits and pieces*. [Archived](https://web.archive.org/web/20240327144654/https://blog.bitsrc.io/bff-pattern-backend-for-frontend-an-introduction-e4fa965128bf?gi=f6e22c3d720c) from the original on 27 March 2024. Retrieved 13 November 2021.