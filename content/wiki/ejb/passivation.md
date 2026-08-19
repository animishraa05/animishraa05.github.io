---
concept: Passivation
aliases: [Stateful Passivation]
tags: [dev, ejb, stateful-bean]
created: 2026-04-11
updated: 2026-04-11
---
	
## The Problem

How does the EJB container manage memory when there are many stateful session beans, each holding client state?

## Core Idea

Passivation is the process where the container serializes a stateful session bean to secondary storage (typically disk) to free up memory. The bean moves from "Ready" state to "Passive" state.

## How It Works

- Container invokes ejbPassivate() callback on the bean
- Bean should release resources and prepare for serialization
- Serialized state saved to persistent storage
- Bean instance removed from memory
- When client calls a method on the passivated bean, container activates it

## Key Properties

- Only applies to stateful session beans
- Triggered when container's active instance limit is reached
- Preserves conversational state across the transition
- Opposite of activation

## Connections

- Built from: [[stateful-session-bean|Stateful Session Bean]]
- Builds into: [[activation|Activation]]
- Contrasts with: [[ejb-remove|ejbRemove()]]
- Related: [[ejbpassivate|ejbPassivate() callback]]

## Edge Cases & Gotchas

- Resources like database connections should be released before passivation
- Don't rely on ejbPassivate() for critical cleanup either
- Performance impact when activation occurs

## Sources

- [[ejb-source-summary|EJB Source]]
