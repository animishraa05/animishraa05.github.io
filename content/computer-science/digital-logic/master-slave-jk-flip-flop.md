---
title: "Master-Slave JK Flip Flop"
topic: "digital-logic"
scraped_date: [[2026-03-29]]
---

# Master-Slave JK Flip Flop
When J = K = 1 and the clock stays high, a JK flip-flop output toggles continuously, causing the race around condition. Using short clock pulses led to the Master-Slave JK Flip-Flop to ensure stable operation.

The Master-Slave JK Flip-Flop consists of two JK flip-flops in series, with one as the master and the other as the slave. The master output feeds the slave input, and the slave output is fed back to the master. An inverter provides the inverted clock to the slave, so only one flip-flop is active at a time. This ensures stable and predictable output.

- The Master-Slave JK Flip-Flop is made of two JK flip-flops in series.
- One flip-flop acts as the master, the other as the slave.
- Master output → Slave inputs, and slave output → Master inputs.
- An inverter provides the inverted clock pulse to the slave.If CP = 1 for master, CP = 0 for slave.If CP = 0 for master, CP = 1 for slave.
- This configuration ensures only one flip-flop is active at a time, providing stable output.

1. If CP = 1 for master, CP = 0 for slave.
2. If CP = 0 for master, CP = 1 for slave.

Working of a master slave flip flop -

![](images/flipflop-1.jpg)

1. When the clock pulse goes to 1, the slave is isolated; J and K inputs may affect the state of the system. The slave flip-flop is isolated until the CP goes to 0. When the CP goes back to 0, information is passed from the master flip-flop to the slave and output is obtained.
2. Firstly the master flip flop is positive level triggered and the slave flip flop is negative level triggered, so the master responds before the slave.
3. If J=0 and K=1, the high Q’ output of the master goes to the K input of the slave and the clock forces the slave to reset, thus the slave copies the master.
4. If J=1 and K=0, the high Q output of the master goes to the J input of the slave and the Negative transition of the clock sets the slave, copying the master.
5. If J=1 and K=1, it toggles on the positive transition of the clock and thus the slave toggles on the negative transition of the clock.
6. If J=0 and K=0, the flip flop is disabled and Q remains unchanged.

The Master-Slave JK Flip-Flop is a memory element widely used in digital systems. If you want to dive deeper into digital logic and master the flip-flop mechanisms, the GATE CS Self-Paced Course offers detailed explanations and examples to help you understand this important concept.

Timing Diagram of a Master Slave flip flop -

![](images/flipflop-diag-1.jpg)

1. When the Clock pulse is high the output of master is high and remains high till the clock is low because the state is stored.
2. Now the output of master becomes low when the clock pulse becomes high again and remains low until the clock becomes high again.
3. Thus toggling takes place for a clock cycle.
4. When the clock pulse is high, the master is operational but not the slave thus the output of the slave remains low till the clock remains high.
5. When the clock is low, the slave becomes operational and remains high until the clock again becomes low.
6. Toggling takes place during the whole process since the output is changing once in a cycle.

This makes the Master-Slave J-K flip flop a Synchronous device as it only passes data with the timing of the clock signal.