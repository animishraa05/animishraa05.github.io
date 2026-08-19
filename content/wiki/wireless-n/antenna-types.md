---
concept: Antenna Types
aliases: [isotropic-antenna, dipole-antenna, directional-antenna, sectorized-antenna, diversity-antenna]
tags: [networking, wireless]
sources_count: 1
last_source: WirelessN.md
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
An antenna is the transducer that converts electrical current into radio waves (transmit) and radio waves back into electrical current (receive). The shape and design of the antenna determines the radiation pattern — how the signal is distributed in space. Different applications require different radiation patterns: some need uniform coverage in all directions, while others need focused beams in specific directions.

## Core Idea
Antennas are classified by their radiation pattern: isotropic (theoretical perfect sphere, used as a reference), dipole (donut-shaped, 360° horizontal coverage), directional (focused narrow beam for long distance), sectorized (divided into sectors for cellular), and diversity (multiple antennas for signal quality improvement).

## How It Works

**Isotropic Antenna (Theoretical Reference):**
- Purely theoretical antenna that radiates equally in all directions (perfect sphere)
- Never exists in practice — used as the reference for measuring antenna gain (measured in dBi)
- 0 dBi gain by definition

**Dipole Antenna (Most Common Real-World):**
- Radiates 360° in the horizontal plane (omnidirectional)
- Does NOT radiate straight up or straight down
- 3D radiation pattern is donut-shaped
- Used in standard Wi-Fi routers and base station feeders

**Directional / Directed Antenna (Flashlight of Radio):**
- Focuses energy into a narrow beam in a specific direction
- Higher gain in the main direction, less energy in other directions
- Used for: microwave backhaul links, long-range point-to-point, satellite comms
- Types: Yagi, helical, parabolic dish

**Sectorized Antenna (Cellular Towers):**
- One omnidirectional antenna replaced by 3 or 6 directional antennas
- Each antenna covers a sector (120° or 60°)
- Total 360° coverage with reduced interference per sector
- Standard in modern cellular base stations

**Diversity Antenna (Smart Listener):**
- Not a shape but a technique: multiple receive antennas
- Antennas separated by small distances (to receive independent multipath signals)
- Receiver selects the strongest signal or combines both (MIMO)
- Effectively combats multipath fading

## Key Properties
- Isotropic: theoretical reference only; 0 dBi gain
- Dipole: 2.1 dBi gain; standard reference for real antennas
- Directional: 10–25 dBi gain; narrows coverage but increases range
- Sectorized: divides one cell into 3 or 6 sectors, reducing interference per sector
- Diversity: no gain increase but improves reliability in multipath environments

## Connections
- Built from: [[cellular-mobile-system|Cellular Mobile System]] — sectorized antennas enable cellular coverage
- Built from: [[channel-fading|Channel Fading]] — diversity antenna directly combats fading
- Related: [[sectoring|Sectoring]] — the cellular design technique that uses sectorized antennas
- Related: [[cell-splitting|Cell Splitting]] — another capacity enhancement technique
- Related: [[frequency-reuse|Frequency Reuse]] — sectoring improves frequency reuse efficiency

## Edge Cases & Gotchas
- Diversity antenna requires careful separation — too close and signals are correlated; too far and patterns differ
- MIMO (used in 4G/LTE and Wi-Fi) is a multi-antenna system that combines diversity with spatial multiplexing
- Sectorized antennas require precise azimuth pointing (for 120° sectors, ±60° from center)
- Diversity and MIMO are different: diversity improves reliability, MIMO improves throughput

## Sources
- [[wireless-n-summary|WirelessN.md]]