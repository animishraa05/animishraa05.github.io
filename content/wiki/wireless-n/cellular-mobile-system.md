---
concept: Cellular Mobile System
aliases: [cellular-network, cellular-system]
tags: [networking, cellular]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Supporting millions of mobile users across a city with a single high-power antenna is impractical because: (1) mobile devices lack enough transmit power to reach a 50 km distant tower, and (2) the available radio spectrum can only support a limited number of simultaneous channels. A city-wide single-antenna system would have insufficient capacity. The solution is to divide the coverage area into small cells, each with a low-power base station.

## Core Idea
A cellular mobile system divides a geographical area into small hexagonal cells, each served by a low-power base station. Because each cell covers a small area, devices only need to reach antennas within hundreds of meters. The same frequencies can be reused in non-adjacent cells, massively increasing network capacity as cells get smaller.

## How It Works
1. The city is divided into small hexagonal cells (typically 1–35 km radius)
2. Each cell has a Base Transceiver Station (BTS) with low-power radio equipment
3. Mobile devices connect to the nearest BTS via the Um (air) interface
4. Cells using the same frequencies (co-channel cells) are separated by the co-channel reuse distance D
5. As a mobile moves between cells, the call is handed over from one BTS to another (handoff)
6. Base Station Controllers (BSCs) manage multiple BTSs; Mobile Switching Centers (MSCs) manage routing

Key concepts: **Frequency Reuse** (same frequencies in distant cells), **Cell Splitting** (splitting a large overloaded cell into smaller micro-cells), **Sectoring** (using directional antennas to divide a cell into 120° or 60° sectors).

## Key Properties
- Massive capacity scaling: total capacity = channels_per_cell × number_of_cells
- Limited antenna power means devices only need short-range transmission
- Frequency reuse enables near-infinite capacity scaling as cells shrink
- Cell radius can be 100 m (dense urban) to 35 km (rural)
- Handoff (hard vs soft) maintains connectivity during mobility
- Sectoring reduces co-channel interference per sector

## Connections
- Built from: [[frequency-reuse|Frequency Reuse]] — the foundational principle of cellular architecture
- Built from: [[handoff|Handoff]] — what allows continuous communication during mobility
- Built into: [[gsm|GSM]] — the most widely deployed 2G cellular system
- Related: [[cell-splitting|Cell Splitting]] — increasing capacity by shrinking cell size
- Related: [[sectoring|Sectoring]] — directional antennas that improve cell efficiency
- Related: [[co-channel-interference|Co-Channel Interference]] — the interference that constrains frequency reuse
- Related: [[frequency-management|Frequency Management]] — managing channel assignments across the network

## Edge Cases & Gotchas
- Cell planning in urban areas is complex due to irregular terrain and building shadowing
- Cell boundaries are not clean hexagons — they overlap and change with traffic and conditions
- Very small cells (micro-cells) require more base stations, increasing infrastructure cost
- Too many small cells cause excessive handoffs, degrading quality