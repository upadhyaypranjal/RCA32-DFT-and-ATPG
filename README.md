# RCA32-DFT-and-ATPG

Implementation of Design-for-Testability (DFT) and Automatic Test Pattern Generation (ATPG) techniques for a 32-bit Ripple Carry Adder using Cadence Genus and Modus.

# 32-bit Ripple Carry Adder: DFT Insertion & ATPG

![Cadence](https://img.shields.io/badge/CADENCE-GENUS_SYNTHESIS-blue)
![Cadence](https://img.shields.io/badge/CADENCE-MODUS_ATPG-blue)
![Technology](https://img.shields.io/badge/TECH-90NM_CMOS-yellowgreen)
![DFT](https://img.shields.io/badge/SCAN-INSERTION-orange)
![Status](https://img.shields.io/badge/ATPG-IN_PROGRESS-lightgrey)
![License](https://img.shields.io/badge/LICENSE-MIT-yellow)

Implementation of scan-based Design-for-Testability (DFT) architecture and ATPG workflow for a sequential 32-bit Ripple Carry Adder designed in Verilog and synthesized using Cadence EDA tools.

---

## 🎯 Overview

This project presents the implementation of **scan-based Design-for-Testability (DFT)** on a **32-bit Ripple Carry Adder (RCA)** using **Cadence Genus Synthesis Solution**, targeting a **90nm CMOS technology library**.

The objective of this work is to transform the sequential RCA design into a **testable scan-compatible architecture** by inserting scan flip-flops and establishing scan chain connectivity for enhanced controllability and observability during test mode.

The current implementation includes RTL synthesis, scan insertion, scan chain generation, and DFT verification. ATPG-based fault pattern generation using **Cadence Modus** is planned for future integration.

---

## ✨ Key Highlights

- **32-bit Sequential Ripple Carry Adder Architecture** implemented in Verilog HDL  
- **Scan-Based DFT Insertion** using Cadence Genus  
- **Single Muxed-Scan Chain Architecture** connecting all sequential elements  
- **98 Scan Flip-Flops** integrated into the final scan chain  
- **DFT Rule Verification** completed successfully  
- **Post-DFT Netlist and SCANDEF Generation** completed  
- **ATPG Integration Planned** using Cadence Modus  

---

## 🏗️ Architecture

### Design Hierarchy

```text
rca_32bit_seq (Top Module)
│
├── Input Registers (A[31:0], B[31:0])
├── Carry Input Register (Cin)
├── 32-bit Ripple Carry Adder Core
├── Output Registers (Sum[31:0])
└── Carry Output Register (Cout)
```

### Design Classification

> The Ripple Carry Adder core is combinational in nature; however, the overall design is implemented as a **sequential circuit** due to the presence of clocked registers and scan flip-flops.

---

## 🔄 DFT Flow

```text
RTL Design (rca_32bit.v)
│
├── Verilog-based sequential RCA implementation
│
▼
Synthesis (Cadence Genus)
│
├── Generic synthesis
├── Technology mapping (90nm CMOS)
│
▼
DFT Insertion
│
├── Scan flip-flop replacement
├── Scan chain connection
├── DFT rule checking
│
▼
Generated Outputs
│
├── Post-DFT Scan Netlist
├── SCANDEF File
└── Timing/Area Reports
│
▼
ATPG (Planned)
│
└── Fault Pattern Generation using Cadence Modus
```

---

## 🔗 Scan Chain Architecture

| Parameter | Value |
|----------|-------|
| Scan Style | Muxed Scan |
| Total Chains | 1 |
| Chain Length | 98 Bits |
| Shift Enable | scan_en |
| Scan Input | SI |
| Scan Output | SO |
| Clock Domain | clk |
| Scan Trigger Edge | Rising Edge |

---

## 📊 Results

### DFT Implementation Summary

| Metric | Value |
|-------|-------|
| Total Scan Flip-Flops | 98 |
| Scan Chains Generated | 1 |
| DFT Rule Check | Pass |
| Netlist Generated | Yes |
| SCANDEF Generated | Yes |
| Post-DFT Optimization | Completed |

---

## 🚀 Future Work

The following enhancements are planned for future updates of this repository:

- Integration of **Cadence Modus ATPG Flow**
- Stuck-at Fault Model Generation
- Fault Coverage Analysis
- ATPG Test Pattern Generation
- Test Vector Export for Simulation

---

## 📂 Repository Structure

```text
.
├── rtl/
│   └── rca_32bit.v
│
├── scripts/
│   └── run_genus_dft.tcl
│
├── output/
│   ├── rca_32bit_scan_netlist.v
│   └── rca_32bit.scandef
│
├── reports/
│   └── scan_chain_report.rpt
│
└── README.md
```

---

## 🎓 Academic Context

**Course:** Digital Systems Testing  
**Institution:** IIITDM Kurnool  
**Tools Used:** Cadence Genus, Cadence Modus  
**Technology Library:** 90nm CMOS Standard Cell Library  

---

