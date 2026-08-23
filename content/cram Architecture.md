# Cram Architecture Overview

This document outlines the high-level architecture of cram, breaking it down into distinct layers. You can use this to confidently explain your system design in an interview.

## High-Level Architecture Diagram
'''dot
flowchart TB  
    %% Users  
    User([User])  
  
    %% UI Layer  
    subgraph UI_Layer [Presentation Layer]  
        CLI[CLI Commands\nArgparse]  
        TUI[Textual TUI\nDashboard, Editor, Review Queue]  
    end  
  
    %% Logic Layer  
    subgraph Logic_Layer [Business Logic & Controllers]  
        Screens[Screen Managers\nApp State]  
        FSRS[FSRS-4.5 Engine\nScheduling Algorithm]  
    end  
  
    %% Integration Layer  
    subgraph Integration_Layer [Integration Services]  
        LC_API[LeetCode Client\nGraphQL]  
        Obs_Sync[Obsidian Scanner\nRegex / File IO]  
        Git_Sync[Git Auto-Sync\nBackground Thread]  
        Notifier[Notification Service\nDunst Timer]  
    end  
  
    %% Storage Layer  
    subgraph Storage_Layer [Data & Storage]  
        JSON[(cards.json\nMetadata & Stats)]  
        MD[(Markdown Notes\nObsidian Vault / Local)]  
        Config[(Config.ini)]  
    end  
  
    %% External Systems  
    Ext_LC((LeetCode\nServers))  
    Ext_Git((Remote Git\nRepo))  
  
    %% Relationships  
    User -->|Uses| CLI  
    User -->|Interacts with| TUI  
      
    CLI --> Screens  
    TUI --> Screens  
      
    Screens --> FSRS  
    Screens --> LC_API  
    Screens --> Obs_Sync  
    Screens --> Git_Sync  
    Screens --> Notifier  
      
    FSRS <--> JSON  
    LC_API <--> Ext_LC  
    Obs_Sync <--> MD  
    Git_Sync --> Ext_Git  
      
    LC_API -->|Transforms data to| FSRS  
    Obs_Sync -->|Transforms data to| FSRS  
      
    Screens -.->|Reads| Config
'''dot
    

---

## The 4 Main Architectural Layers

When asked to explain your project's architecture, divide it into these four distinct layers. This shows the interviewer that you understand separation of concerns and modular design.

### 1. Presentation Layer (UI)

- **Technologies:** Python, textual, argparse.
    
- **What it does:** This is the entry point of your application (srs/app.py). It handles all user interactions.
    
- **Key Design Choice:** You utilized textual, which leverages Python's asyncio under the hood. This allows your TUI to remain highly responsive (non-blocking) while rendering complex dual-pane layouts, interactive rating dialogs, and an embedded TextArea editor all within the terminal.
    

### 2. Business Logic Layer (The Brains)

- **Technologies:** Core Python (math, datetime).
    
- **What it does:** The heart of this layer is the **FSRS-4.5 Engine** (srs/cards.py). It strictly handles the mathematical formulas (Retrievability, Stability, Difficulty) and updates card states.
    
- **Key Design Choice:** By separating the FSRS logic from the UI, you keep your mathematical operations pure. The UI simply passes a "grade" (Again, Hard, Good, Easy) to the engine, and the engine returns the updated card object with the newly calculated next_review timestamp.
    

### 3. Integration Services Layer

- **Technologies:** urllib (HTTP), subprocess, threading.
    
- **What it does:** Handles all communication with external systems.
    
    - **LeetCode API (****leetcode.py****):** Acts as a GraphQL client fetching public submissions. Implements exponential backoff to handle HTTP 429 (Rate Limiting) gracefully.
        
    - **Git Auto-Sync (****git_sync.py****):** Uses Python's threading.Thread to spawn detached background workers. This allows the app to execute subprocess.run(["git", "push"]) silently without freezing the Textual UI.
        
    - **Obsidian Scanner (****obsidian.py****):** Recursively parses .md files looking for specific YAML frontmatter tags to sync external concept notes.
        

### 4. Data & Storage Layer

- **Technologies:** json, standard file I/O.
    
- **What it does:** Persists the state of the application.
    
- **Key Design Choice:** Instead of setting up a heavy SQLite database, you chose a lightweight JSON storage approach (cards.json) for metadata and standard Markdown files for the actual note content. To prevent data corruption during writes, you implemented an **Atomic Write Pattern**: you write to a .tmp file first, and only upon success do you use os.replace() to overwrite the main database file.
    

---

## How to talk about it in the interview:

**If they ask:** _"Walk me through the architecture of cram."_

**Your script:**

> "The architecture of cram is divided into four main layers to ensure a clean separation of concerns.

> At the top, I have the **Presentation Layer** built entirely with the Textual framework, which uses asynchronous rendering so the UI never blocks.

> Below that is the **Business Logic Layer**, which primarily houses the FSRS-4.5 scheduling engine. It handles all the complex decay math for spaced repetition.

> Then there is the **Integration Layer**, which consists of several independent modules: a GraphQL client with exponential backoff for fetching LeetCode submissions, and a background threading service that safely commits and pushes data to Git without freezing the terminal.

> Finally, the **Storage Layer** persists metadata using lightweight JSON files guarded by atomic write patterns to prevent corruption, while content is saved directly as Markdown files to maintain native integration with Obsidian."