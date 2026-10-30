# Write Difference Replay Report

- Difference source: Single test instruction causes the difference
- Test instruction index: 221
- Global index: 267

| Implementation | Instruction | Register Context | Memory Context | Register Writes | Memory Writes |
|------|------|------------|------------|------------|----------|
| Spike | `rem x14, x18, x14` | x14=0x11, x18=0x11 | - | x14=0x0 | - |
| Rocket | `rem x14, x18, x14` | x14=0x11, x18=0x11 | - | x14=0x0 | - |

