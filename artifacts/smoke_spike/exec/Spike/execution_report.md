# Spike Execution Output Detail Report

## 📋 Basic Info

| Item | Value |
|------|-------|
| RISC-V Implementation | Spike |
| ISA Base | Rv64 |
| Instruction Count | 3 |
| Exception Count | 0 |
| User Memory Range | 0x0000000080002000 - 0x000000008fffffff |

## 📊 Execution Trace Summary

> Memory-context addresses are shown as 0-based offsets relative to the start of user memory.

| Instruction Index | Instruction | Changes | Register Context | Memory Context | Exception |
|---------|------|-----------|------------|------------|------|
| 0 | `addi x1, x0, 1` | x1:?→0x1 | - | - |
| 1 | `addi x2, x0, 2` | x2:?→0x2 | - | - |
| 2 | `add x3, x1, x2` | x3:?→0x3 | x1=0x1, x2=0x2 | - |

## 📈 Statistics Summary

| Metric | Value |
|--------|-------|
| Instructions with writes | 3 (100.00%) |
| Instructions with exceptions | 0 (0.00%) |
| Instructions without writes or exceptions | 3 (100.00%) |
