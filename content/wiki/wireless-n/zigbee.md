---
concept: ZigBee
aliases: [IEEE-802-15-4]
tags: [networking, wpan]
created: 2026-04-21
updated: 2026-04-21
---

## The Problem
Wi-Fi and Bluetooth consume too much power for battery-powered sensors and actuators that need to run for months or years on a single coin cell. A truly low-power wireless standard was needed for industrial monitoring, home automation, and IoT sensor networks where devices must operate for long periods without battery replacement.

## Core Idea
ZigBee (IEEE 802.15.4) is an ultra-low-power wireless personal area network (WPAN) standard designed for low-rate, short-range, battery-powered devices. It operates in the 2.4 GHz, 900 MHz, and 868 MHz bands, provides 250 kbps, and is designed for years of battery life.

## How It Works

**Physical Layer:**
- 2.4 GHz ISM band: 250 kbps (worldwide)
- 915 MHz band: 40 kbps (Americas)
- 868 MHz band: 20 kbps (Europe)
- Direct Sequence Spread Spectrum (DSSS) for interference resistance

**MAC Layer:**
- CSMA/CA channel access (similar to 802.11)
- Optional beacon mode for synchronous data transfer
- Guaranteed Time Slots (GTS) for low-latency applications
- Superframe structure: active and inactive periods

**Network Layer:**
- Star topology: simple, coordinator-based
- Peer-to-peer (tree, mesh): extended range through multi-hop

**Applications:**
- Home automation: lights, thermostats, door locks
- Industrial monitoring: temperature, pressure, vibration
- Health care: patient monitors, medication dispensers
- Smart metering: electricity, water, gas

## Key Properties
- Ultra-low power: years of battery life (vs. days for Wi-Fi, hours for Bluetooth)
- Very low data rate: 250 kbps (sufficient for sensor data)
- Short range: 10–100 m (sufficient for home/industrial)
- Simple protocol stack: smaller code and memory footprint
- Mesh networking: extended range through multi-hop routing
- Standard: equipment from multiple vendors is interoperable

## Connections
- Related: [[bluetooth|Bluetooth]] — another WPAN standard; higher rate but higher power
- Related: [[bluetooth-low-energy|BLE]] — competing for the same IoT sensor market
- Related: [[ieee-802-15|IEEE 802.15]] — ZigBee is a 802.15.4-based standard
- Related: [[wifi-zigbee-comparison|Wi-Fi vs Bluetooth vs ZigBee]] — comparison of these short-range standards
- Related: [[wireless-sensor-network|Wireless Sensor Network]] — ZigBee is commonly used in WSNs

## Edge Cases & Gotchas
- Data rate (250 kbps) is too low for audio, video, or large data transfers
- Range is shorter than Wi-Fi or sub-GHz alternatives
- Bluetooth Low Energy (BLE) is now a strong competitor in the IoT space
- ZigBee and BLE are not interoperable — separate ecosystems