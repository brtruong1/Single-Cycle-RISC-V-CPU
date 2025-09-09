# Single-Cycle-RISC-V-CPU


This repository contains a 32-bit single-cycle RISC-V CPU implemented in Verilog.
The design was developed and tested on the PYNQ-Z2 FPGA board.  
Documentation used during development is included in the repository (`docs/`).

---

## Features
- Implements a subset of the RV32I instruction set:
  - `add`, `sub`, `addi`, `lw`, `sw`
- 32 × 32-bit register file
- 4 KB instruction memory (1024 × 32-bit)
- Instruction and data memory implemented using Verilog arrays
- Synthesizable on PYNQ-Z2 FPGA

---

## Current Status
- Instruction set: working for basic arithmetic, memory load/store, and immediate operations
- Top-level FPGA wrapper added for deployment
- Internal registers are not yet externally visible

---


## Planned Improvements
- Add additional RV32I instructions (e.g., `beq`, `jal`, `jalr`)
- Implement UART communication for loading programs into instruction memory
- Provide a debug interface for reading register file and memory contents
- Explore pipelining to improve performance

---
