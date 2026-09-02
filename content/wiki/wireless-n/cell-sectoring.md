---
concept: Cell Sectoring
aliases: [sectoring, cell-sectoring]
tags: [networking, cellular]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
A single omnidirectional antenna at a cell site broadcasts in all 360° directions, but users are not evenly distributed around the cell. More importantly, signals transmitted toward the back of the cell (toward co-channel cells) cause co-channel interference. Cell sectoring uses directional antennas to divide a cell into sectors, focusing energy where users are and reducing interference toward co-channel cells.

## Core Idea
Cell sectoring divides a single cell into 3 or 6 sectors (120° or 60° each) using directional antennas instead of one omnidirectional antenna. Each sector operates as an independent cell with its own channel set, reducing co-channel interference and increasing capacity per unit area.

## How It Works
1. Instead of one omnidirectional antenna, install 3 (120°) or 6 (60°) directional antennas per cell site
2. Each sector covers a wedge-shaped area; total coverage remains 360°
3. Each sector is assigned its own subset of the cell's frequencies
4. Since each antenna covers only a 60–120° sector, signals are not broadcast toward co-channel cells
5. Effective co-channel interference decreases by the number of sectors
6. C/I ratio improves, or cluster size (N) can be reduced, increasing capacity

The effective reuse factor improves by a factor equal to the number of sectors: 3 sectors reduces interference by 3× or allows 3× reduction in cluster size (from N=7 to N=4).

## Key Properties
- Reduces effective co-channel interference by a factor of 3 (or the number of sectors)
- Allows smaller cluster sizes (higher capacity) while maintaining C/I
- Improves downlink coverage for directional antennas
- Requires careful sector boundary planning to avoid coverage gaps
- Common configuration: 3 sectors per cell (120° each)
- Sectors can overlap at boundaries, enabling soft handoff zones

## Connections
- Built from: [[cellular-mobile-system|Cellular Mobile System]] — sectoring is a capacity enhancement technique for cellular systems
- Built from: [[antenna-types|Antenna Types]] — sectoring uses directional antennas
- Built from: [[frequency-reuse|Frequency Reuse]] — sectoring improves effective frequency reuse
- Related: [[cell-splitting|Cell Splitting]] — another capacity enhancement technique
- Related: [[co-channel-interference|Co-Channel Interference]] — sectoring directly reduces this
- Related: [[gsm-architecture|GSM Architecture]] — GSM BTS supports sectorized deployments

## Edge Cases & Gotchas
- Sectors can cause coverage gaps at their boundaries
- Requires careful RF planning to ensure uniform coverage
- Sector boundaries are not static — they shift with traffic load and seasonal foliage
- Ping-pong handovers can occur at sector boundaries