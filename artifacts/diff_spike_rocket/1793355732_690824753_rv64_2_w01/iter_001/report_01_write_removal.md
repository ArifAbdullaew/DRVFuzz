# Write Difference Removal Report

- Original test instruction count: 1222
- Removed: 1
- Remaining test instruction count: 1221

## Test Instruction #844, global index 890

- Classification: Each implementation's writes are different

- Tag: Known - ROCKET MISSING LOG

- Difference source: Single test instruction causes the difference

| Implementation | Instruction | Register Context | Memory Context | Register Writes | Memory Writes |
|------|------|------------|------------|------------|----------|
| Spike | `rem x14, x18, x14` | x14=0x11, x18=0x11 | - | x14=0x0 | - |
| Rocket | `rem x14, x18, x14` | x14=0x11, x18=0x11 | - | - | - |

