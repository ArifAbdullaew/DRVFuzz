# Exception Difference Removal Report

- Original test instruction count: 1277
- Removed: 75
- Remaining test instruction count: 1202

## Test Instruction #20 (global index 66)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f18, 16.0` | f18=0xacc96bac5af0edee | - | - |
| Rocket | `fli.h f18, 16.0` | f18=0xacc96bac5af0edee | - | 0x2 |

## Test Instruction #31 (global index 77)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f18, f16` | f17=0xbd981c18507d2e33, f18=0xffffffffffff4c00, f16=0x76dc14e73739fa01 | - | - |
| Rocket | `fmaxm.d f17, f18, f16` | f17=0xbd981c18507d2e33, f18=0xacc96bac5af0edee, f16=0x76dc14e73739fa01 | - | 0x2 |

## Test Instruction #33 (global index 79)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f16, 0x1.0p-15` | f16=0x76dc14e73739fa01 | - | - |
| Rocket | `fli.h f16, 0x1.0p-15` | f16=0x76dc14e73739fa01 | - | 0x2 |

## Test Instruction #38 (global index 84)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x20, f15, f13` | x20=0x13, f15=0x4008000000000000, f13=0xffffffff00000000 | - | - |
| Rocket | `fltq.h x20, f15, f13` | x20=0x13, f15=0x4008000000000000, f13=0xffffffff00000000 | - | 0x2 |

## Test Instruction #44 (global index 90)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f20, -1.0` | f20=0x64da522e2cccc4df | - | - |
| Rocket | `fli.d f20, -1.0` | f20=0x64da522e2cccc4df | - | 0x2 |

## Test Instruction #55 (global index 101)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x16, f16, f19` | x16=0x0, f16=0xffffffffffff0200, f19=0x2dfad393aafadb9b | - | - |
| Rocket | `fltq.h x16, f16, f19` | x16=0x13, f16=0x76dc14e73739fa01, f19=0x2dfad393aafadb9b | - | 0x2 |

## Test Instruction #58 (global index 104)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f15, f13, f15` | f15=0x4008000000000000, f13=0xffffffff00000000 | - | - |
| Rocket | `fmaxm.h f15, f13, f15` | f15=0x4008000000000000, f13=0xffffffff00000000 | - | 0x2 |

## Test Instruction #65 (global index 111)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f15, 16.0` | f15=0xffffffff7fc00000 | - | - |
| Rocket | `fli.h f15, 16.0` | f15=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #67 (global index 113)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f14, 1.75` | f14=0xffffffff00000000 | - | - |
| Rocket | `fli.s f14, 1.75` | f14=0xffffffff00000000 | - | 0x2 |

## Test Instruction #71 (global index 117)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x13, f13, f14` | x13=0x13, f13=0xffffffff00000000, f14=0xffffffff3fe00000 | - | - |
| Rocket | `fleq.h x13, f13, f14` | x13=0x13, f13=0xffffffff00000000, f14=0xffffffff00000000 | - | 0x2 |

## Test Instruction #106 (global index 152)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f18, f14, f20` | f18=0xffffffff7fc00000, f14=0xffffffff3fe00000, f20=0x0 | - | - |
| Rocket | `fmaxm.s f18, f14, f20` | f18=0xffffffff7fc00000, f14=0xffffffff00000000, f20=0x0 | - | 0x2 |

## Test Instruction #111 (global index 157)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f17, f14, f17` | f17=0xffffffff7fc00000, f14=0xffffffff3fe00000 | - | - |
| Rocket | `fminm.d f17, f14, f17` | f17=0xffffffff7fc00000, f14=0xffffffff00000000 | - | 0x2 |

## Test Instruction #116 (global index 162)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f14, f18, f17` | f14=0xffffffff3fe00000, f18=0xffffffff7fc00000, f17=0x7ff8000000000000 | - | - |
| Rocket | `fminm.h f14, f18, f17` | f14=0xffffffff00000000, f18=0xffffffff7fc00000, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #118 (global index 164)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x20, f14, f13` | x20=0x13, f14=0xffffffffffff7e00, f13=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.h x20, f14, f13` | x20=0x13, f14=0xffffffff00000000, f13=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #120 (global index 166)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x13, f16, f17` | x13=0x13, f16=0xffffffff7fc00000, f17=0x7ff8000000000000 | - | - |
| Rocket | `fleq.d x13, f16, f17` | x13=0x13, f16=0xffffffff7fc00000, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #139 (global index 185)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x19, f17, f16` | x19=0x13, f17=0xfffffffffffffe00, f16=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.d x19, f17, f16` | x19=0x13, f17=0xfffffffffffffe00, f16=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #147 (global index 193)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f14, f17, f18` | f14=0xffffffffffff7e00, f17=0xfffffffffffffe00, f18=0x7ff8000000000000 | - | - |
| Rocket | `fminm.d f14, f17, f18` | f14=0xffffffff00000000, f17=0xfffffffffffffe00, f18=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #149 (global index 195)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f18, f19, f19` | f18=0x7ff8000000000000, f19=0x2dfad393aafadb9b | - | - |
| Rocket | `fmaxm.d f18, f19, f19` | f18=0x7ff8000000000000, f19=0x2dfad393aafadb9b | - | 0x2 |

## Test Instruction #179 (global index 225)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f14, f17` | f17=0xfffffffffffffe00, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.d f17, f14, f17` | f17=0xfffffffffffffe00, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #229 (global index 275)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f14, f13` | f13=0xffffffff7fc00000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.d f13, f14, f13` | f13=0xffffffff7fc00000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #249 (global index 295)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f19, f16, f20` | f19=0xffffffff7fc00000, f16=0xffffffffffff7e00, f20=0x409ca00000000000 | - | - |
| Rocket | `fminm.s f19, f16, f20` | f19=0xffffffff7fc00000, f16=0xffffffffffff7e00, f20=0x409ca00000000000 | - | 0x2 |

## Test Instruction #255 (global index 301)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x15, f13, f18` | x15=0x13, f13=0x7ff8000000000000, f18=0x0 | - | - |
| Rocket | `fleq.h x15, f13, f18` | x15=0x13, f13=0xffffffff7fc00000, f18=0x0 | - | 0x2 |

## Test Instruction #257 (global index 303)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x18, f18, f14` | x18=0x13, f18=0x0, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.s x18, f18, f14` | x18=0x13, f18=0x0, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #279 (global index 325)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f16, f17, rtz` | f16=0xffffffffffff7e00, f17=0x409ca00000000000 | - | - |
| Rocket | `fround.h f16, f17, rtz` | f16=0xffffffffffff7e00, f17=0x409ca00000000000 | - | 0x2 |

## Test Instruction #297 (global index 343)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f15, f14, f15` | f15=0x7ff8000000000000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.h f15, f14, f15` | f15=0x7ff8000000000000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #333 (global index 379)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f14, f20, rup` | f14=0x7ff8000000000000, f20=0xffffffff7fc00000 | - | - |
| Rocket | `fround.d f14, f20, rup` | f14=0x7ff8000000000000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #349 (global index 395)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f20, f14, rmm` | f20=0xffffffff7fc00000, f14=0x7ff8000000000000 | - | - |
| Rocket | `fround.d f20, f14, rmm` | f20=0xffffffff7fc00000, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #351 (global index 397)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f14, 0x1.0p-15` | f14=0x7ff8000000000000 | - | - |
| Rocket | `fli.h f14, 0x1.0p-15` | f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #353 (global index 399)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f13, f20, rup` | f13=0x7ff8000000000000, f20=0x7ff8000000000000 | - | - |
| Rocket | `fround.s f13, f20, rup` | f13=0x7ff8000000000000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #356 (global index 402)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f18, f14, f13` | f18=0xffffffff7fc00000, f14=0xffffffffffff0200, f13=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.d f18, f14, f13` | f18=0xffffffff7fc00000, f14=0x7ff8000000000000, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #364 (global index 410)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x16, f19, f18` | x16=0x13, f19=0x7ff8000000000000, f18=0x7ff8000000000000 | - | - |
| Rocket | `fltq.h x16, f19, f18` | x16=0x13, f19=0x7ff8000000000000, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #380 (global index 426)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x13, f19, f20` | x13=0x13, f19=0x7ff8000000000000, f20=0x7ff8000000000000 | - | - |
| Rocket | `fltq.d x13, f19, f20` | x13=0x13, f19=0x7ff8000000000000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #405 (global index 451)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f13, f19, rtz` | f13=0xffffffff7fc00000, f19=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.s f13, f19, rtz` | f13=0x7ff8000000000000, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #414 (global index 460)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f14, f13, f16` | f14=0xffffffff7fc00000, f13=0xffffffff7fc00000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.s f14, f13, f16` | f14=0xffffffff7fc00000, f13=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #420 (global index 466)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f20, f16, rtz` | f20=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.d f20, f16, rtz` | f20=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #457 (global index 503)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x20, f14, rtz` | x20=0x13, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fcvtmod.w.d x20, f14, rtz` | x20=0x13, f14=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #523 (global index 569)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f16, f14, rtz` | f16=0xffffffffffff7e00, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fround.h f16, f14, rtz` | f16=0xffffffffffff7e00, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #537 (global index 583)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f18, f18, f18` | f18=0xffffffff41980000 | - | - |
| Rocket | `fminm.h f18, f18, f18` | f18=0xffffffff41980000 | - | 0x2 |

## Test Instruction #547 (global index 593)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f15, f20, f19` | f15=0xffffffffffff7c00, f20=0xffffffff7fc00000, f19=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f15, f20, f19` | f15=0xffffffffffff7c00, f20=0xffffffff7fc00000, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #597 (global index 643)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f19, f18, rne` | f19=0xffffffff7fc00000, f18=0x41600002e0000000 | - | - |
| Rocket | `fround.d f19, f18, rne` | f19=0xffffffff7fff7c00, f18=0x41600002e0000000 | - | 0x2 |

## Test Instruction #603 (global index 649)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f20, f15, rtz` | f20=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.h f20, f15, rtz` | f20=0xffffffff7fc00000, f15=0xffffffffffff7c00 | - | 0x2 |

## Test Instruction #607 (global index 653)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x20, f19, rtz` | x20=0x17, f19=0xffffffffffff0017 | - | - |
| Rocket | `fcvtmod.w.d x20, f19, rtz` | x20=0x17, f19=0xffffffffffff0017 | - | 0x2 |

## Test Instruction #649 (global index 695)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f14, f17, f19` | f14=0x41600002e0000000, f17=0xffffffffffff7e00, f19=0xffffffff41b80000 | - | - |
| Rocket | `fmaxm.s f14, f17, f19` | f14=0x41600002e0000000, f17=0xffffffffffff7e00, f19=0xffffffff41b80000 | - | 0x2 |

## Test Instruction #659 (global index 705)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f18, f16, f18` | f18=0x41600002e0000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.h f18, f16, f18` | f18=0x41600002e0000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #672 (global index 718)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x13, f14, f18` | x13=0x0, f14=0xffffffff7fc00000, f18=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.h x13, f14, f18` | x13=0x0, f14=0x41600002e0000000, f18=0x41600002e0000000 | - | 0x2 |

## Test Instruction #698 (global index 744)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f19, f14, f19` | f19=0xffffffff41b80000, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.h f19, f14, f19` | f19=0xffffffff41b80000, f14=0x41600002e0000000 | - | 0x2 |

## Test Instruction #719 (global index 765)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f19, f17, f15` | f19=0xffffffffffff7e00, f17=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.s f19, f17, f15` | f19=0xffffffff41b80000, f17=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #743 (global index 789)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f14, 32768.0` | f14=0xffffffff7fc00000 | - | - |
| Rocket | `fli.h f14, 32768.0` | f14=0x41600002e0000000 | - | 0x2 |

## Test Instruction #762 (global index 808)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x14, f17, f17` | x14=0x1, f17=0xfffffffffffffc00 | - | - |
| Rocket | `fleq.h x14, f17, f17` | x14=0x1, f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #774 (global index 820)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f18, f14, f18` | f18=0xffffffffffff7e00, f14=0xffffffffffff7800 | - | - |
| Rocket | `fmaxm.d f18, f14, f18` | f18=0x41600002e0000000, f14=0x41600002e0000000 | - | 0x2 |

## Test Instruction #782 (global index 828)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f14, f14, f15` | f14=0xffffffffffff7800, f15=0x4018000000000000 | - | - |
| Rocket | `fminm.s f14, f14, f15` | f14=0x41600002e0000000, f15=0x4032000000000000 | - | 0x2 |

## Test Instruction #796 (global index 842)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f17, f20, f16` | f17=0xfffffffffffffc00, f20=0xffffffff7fc00000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.s f17, f20, f16` | f17=0xffffffffffff7e00, f20=0xffffffff7fc00000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #805 (global index 851)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x15, f13, f16` | x15=0x0, f13=0xffffffffffff0000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.h x15, f13, f16` | x15=0x0, f13=0xffffffffffff0000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #830 (global index 876)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f16, f19, f14` | f16=0xffffffffffff7e00, f19=0xffffffffffffffff, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f16, f19, f14` | f16=0xffffffffffff7e00, f19=0xffffffffffffffff, f14=0x41600002e0000000 | - | 0x2 |

## Test Instruction #861 (global index 907)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f18, 1.75` | f18=0x7ff8000000000000 | - | - |
| Rocket | `fli.d f18, 1.75` | f18=0x41600002e0000000 | - | 0x2 |

## Test Instruction #909 (global index 955)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f19, f19, f20` | f19=0xffffffffffffffff, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.h f19, f19, f20` | f19=0xffffffffffffffff, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #932 (global index 978)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f17, f13, f19` | f17=0xffffffff7fc00000, f13=0xffffffffffff0000, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.h f17, f13, f19` | f17=0xffffffff7fc00000, f13=0xffffffffffff0000, f19=0xffffffffffffffff | - | 0x2 |

## Test Instruction #949 (global index 995)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f16, f15, rtz` | f16=0x0, f15=0xffffffff23e0e01f | - | - |
| Rocket | `froundnx.h f16, f15, rtz` | f16=0x0, f15=0xffffffff23e0e01f | - | 0x2 |

## Test Instruction #986 (global index 1032)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f18, f18, rdn` | f18=0x7fffffff7fc00000 | - | - |
| Rocket | `fround.h f18, f18, rdn` | f18=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #997 (global index 1043)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f20, 8.0` | f20=0x7ff8000000000000 | - | - |
| Rocket | `fli.s f20, 8.0` | f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1009 (global index 1055)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f14, 2.0` | f14=0x7ff8000000000000 | - | - |
| Rocket | `fli.d f14, 2.0` | f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1028 (global index 1074)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x20, f15, f14` | x20=0x17, f15=0xffffffffffff7e00, f14=0x4000000000000000 | - | - |
| Rocket | `fltq.h x20, f15, f14` | x20=0x17, f15=0xffffffffffff7e00, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1049 (global index 1095)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f20, f14, rmm` | f20=0xffffffff41b80000, f14=0x4000000000000000 | - | - |
| Rocket | `fround.d f20, f14, rmm` | f20=0xffffffff41b80000, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1090 (global index 1136)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x14, f19, f17` | x14=0x17, f19=0xffffffffffff7e00, f17=0x7fffffffffff7e00 | - | - |
| Rocket | `fleq.s x14, f19, f17` | x14=0x17, f19=0xffffffffffff7e00, f17=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #1092 (global index 1138)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f17, f13, f20` | f17=0x7fffffffffff7e00, f13=0x4037000000000000, f20=0x0 | - | - |
| Rocket | `fmaxm.s f17, f13, f20` | f17=0x7fffffff7fc00000, f13=0x4037000000000000, f20=0x0 | - | 0x2 |

## Test Instruction #1110 (global index 1156)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f18, f14` | f17=0xffffffff7fc00000, f18=0xffffffffffc00000, f14=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f17, f18, f14` | f17=0x7fffffff7fc00000, f18=0xffffffffffc00000, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1114 (global index 1160)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f14, f20, f19` | f14=0xffffffffffff7e00, f20=0x4037000000000000, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.d f14, f20, f19` | f14=0xffffffffffff7e00, f20=0x4037000000000000, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1121 (global index 1167)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f15, 0.5` | f15=0xffffffffffc00000 | - | - |
| Rocket | `fli.s f15, 0.5` | f15=0xffffffffffc00000 | - | 0x2 |

## Test Instruction #1124 (global index 1170)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f13, 0x1.0p-7` | f13=0x4037000000000000 | - | - |
| Rocket | `fli.s f13, 0x1.0p-7` | f13=0x4037000000000000 | - | 0x2 |

## Test Instruction #1136 (global index 1182)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f17, f16, f17` | f17=0xffffffffffff7e00, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.s f17, f16, f17` | f17=0xffffffffffff7e00, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1139 (global index 1185)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x16, f17, f16` | x16=0x0, f17=0xffffffff7fc00000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fleq.d x16, f17, f16` | x16=0x0, f17=0xffffffffffff7e00, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1142 (global index 1188)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x14, f20, f16` | x14=0x17, f20=0x4037000000000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fleq.s x14, f20, f16` | x14=0x17, f20=0x4037000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1147 (global index 1193)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f15, f16, rdn` | f15=0xffffffff3f000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.d f15, f16, rdn` | f15=0xffffffffffc00000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1160 (global index 1206)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x17, f13, f16` | x17=0x6e806ed5, f13=0xffffffff3c000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fleq.h x17, f13, f16` | x17=0x6e806ed5, f13=0x4037000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1189 (global index 1235)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f18, 1.75` | f18=0xffffffff3c000000 | - | - |
| Rocket | `fli.d f18, 1.75` | f18=0xffffffff7fc00000 | - | 0x2 |

