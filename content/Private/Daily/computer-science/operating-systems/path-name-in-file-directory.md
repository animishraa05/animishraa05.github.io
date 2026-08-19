---
title: "Path Name in File Directory"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Path Name in File Directory
When files are organized as a directory tree, there must be a way to uniquely identify and access them. This is done through path names. A path name specifies the location of a file or directory in the file system hierarchy. There are two main types of path names:

- Absolute Path Name
- Relative Path Name

## 1. Absolute Path Name

An absolute path name (also known as a full path) specifies the complete path from the root directory ("/") to the target file or directory. It does not depend on the current working directory, which makes it unique and unambiguous.

### Example:

In UNIX/Linux:

> /usr/ast/mailbox

/usr/ast/mailbox

In Windows:

> C:\usr\ast\mailbox

C:\usr\ast\mailbox

Here,

- / (or C:\) represents the root directory.
- Each subdirectory name is separated by a slash ("/") in UNIX or backslash ("") in Windows.

`/`

### Key Features:

- Always starts from the root.
- Unique across the entire system.
- Works irrespective of the current directory.

### When to Use:

Absolute path names are used when:

- The program or script must access files independent of the current working directory.
- Referring to system files or files in fixed locations (e.g., /usr/lib/dictionary).

### Example in UNIX:

> cp /usr/ast/mailbox /usr/ast/mailbox.bak

cp /usr/ast/mailbox /usr/ast/mailbox.bak

This command copies the file mailbox from /usr/ast/ to a backup file in the same directory, using absolute paths.

## 2. Relative Path Name

A relative path name specifies the file or directory in relation to the current working directory (also known as the present working directory). It does not start from the root and is shorter and more flexible than an absolute path.

### Example:

If the current working directory is:

> /usr/ast

/usr/ast

Then the absolute path /usr/ast/mailbox can be referred to simply as:

> mailboX

mailboX

### Example in UNIX:

> cp mailbox mailbox.bak

cp mailbox mailbox.bak

This command performs the same operation as the earlier absolute path example, assuming the working directory is /usr/ast.

### When to Use:

Relative path names are used when:

- The file resides in or near the current directory.
- You want shorter commands or portable scripts.
- The program explicitly sets or knows the working directory.

## Working Directory Concept

The working directory (or current directory) is the directory that the operating system considers as the default for all relative path operations.

You can: View it using:

> pwd

pwd

Change it using:

> cd /usr/ast

cd /usr/ast

Once the working directory is set, all file operations using relative paths are performed relative to this directory.

## When to Use Absolute vs Relative Path

| Criteria | Absolute Path | Relative Path |
| --- | --- | --- |
| Definition | Full path from root directory | Path relative to current working directory |
| Dependency | Independent of working directory | Depends on working directory |
| Uniqueness | Always unique | May vary depending on current directory |
| Usage | Used in scripts or programs requiring fixed file references | Used in user-level commands or local navigation |
| Example (UNIX) | /usr/lib/dictionary | ../lib/dictionary |

## Why Use Absolute Path Names

Absolute paths are preferred when:

- You want certainty about the file’s location.
- The script or application may run in different working directories.
- The file is located in a system-wide or shared location.
- The command or service runs automatically (cron jobs, daemons, etc.) where the working directory might not be known.

Example: A spell-checking program may need to read the dictionary file at:

> /usr/lib/dictionary

/usr/lib/dictionary

Since the working directory during execution may vary, using an absolute path ensures it always finds the file correctly.