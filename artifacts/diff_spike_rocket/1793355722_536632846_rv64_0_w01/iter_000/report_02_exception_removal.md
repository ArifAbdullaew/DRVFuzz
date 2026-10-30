# Exception Difference Removal Report

- Original test instruction count: 1283
- Removed: 62
- Remaining test instruction count: 1221

## Test Instruction #5 (global index 51)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x16, f15, f19` | x16=0x10, f15=0x705aa753a677abb6, f19=0xb7265d83e803edf1 | - | - |
| Rocket | `fleq.d x16, f15, f19` | x16=0x10, f15=0x705aa753a677abb6, f19=0xb7265d83e803edf1 | - | 0x2 |

## Test Instruction #71 (global index 117)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f19, f18, f16` | f19=0xffffffff00000000, f18=0x75994ad3001b667d, f16=0x8628d9c280d311a4 | - | - |
| Rocket | `fmaxm.h f19, f18, f16` | f19=0xffffffff00000000, f18=0x75994ad3001b667d, f16=0x8628d9c280d311a4 | - | 0x2 |

## Test Instruction #79 (global index 125)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f16, f13, f15` | f16=0x8628d9c280d311a4, f13=0xffffffffffff7e00, f15=0xffffffff00000000 | - | - |
| Rocket | `fminm.h f16, f13, f15` | f16=0x8628d9c280d311a4, f13=0xffffffffffff7e00, f15=0xffffffff00000000 | - | 0x2 |

## Test Instruction #103 (global index 149)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f14, f20, rtz` | f14=0xffffffff7fc00000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.h f14, f20, rtz` | f14=0xffffffff7fc00000, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #108 (global index 154)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x20, f16, f19` | x20=0x0, f16=0xffffffffffff7e00, f19=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.h x20, f16, f19` | x20=0x0, f16=0x8628d9c280d311a4, f19=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #119 (global index 165)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f15, f14, rne` | f15=0xffffffff41880000, f14=0x4063200000000000 | - | - |
| Rocket | `fround.s f15, f14, rne` | f15=0xffffffff41880000, f14=0x4063200000000000 | - | 0x2 |

## Test Instruction #139 (global index 185)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f15, f14` | f13=0xffffffffffff7e00, f15=0x7fffffffffff7e00, f14=0x4063200000000000 | - | - |
| Rocket | `fminm.d f13, f15, f14` | f13=0xffffffffffff7e00, f15=0x7fffffffffff7e00, f14=0x4063200000000000 | - | 0x2 |

## Test Instruction #165 (global index 211)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x19, f15, f14` | x19=0x11, f15=0x7ff8000000000000, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.h x19, f15, f14` | x19=0x11, f15=0x7ff8000000000000, f14=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #195 (global index 241)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x20, f20, f14` | x20=0x0, f20=0x7ff8000000000000, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.h x20, f20, f14` | x20=0x0, f20=0x7ff8000000000000, f14=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #207 (global index 253)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f18, 128.0` | f18=0x75994ad3001b667d | - | - |
| Rocket | `fli.h f18, 128.0` | f18=0x75994ad3001b667d | - | 0x2 |

## Test Instruction #229 (global index 275)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f19, f18, dyn` | f19=0xffffffffffffe348, f18=0xffffffffffff5800 | - | - |
| Rocket | `fround.h f19, f18, dyn` | f19=0xffffffffffffe348, f18=0x75994ad3001b667d | - | 0x2 |

## Test Instruction #240 (global index 286)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f17, f18, f13` | f17=0x7ff8000000000000, f18=0xffffffffffff5800, f13=0xfffffffffffffc00 | - | - |
| Rocket | `fminm.s f17, f18, f13` | f17=0x75994ad3001b667d, f18=0x75994ad3001b667d, f13=0xfffffffffffffc00 | - | 0x2 |

## Test Instruction #261 (global index 307)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f16, f18` | f13=0x7ff8000000000000, f16=0x4031000000000000, f18=0xffffffffffff3c00 | - | - |
| Rocket | `fminm.d f13, f16, f18` | f13=0xa85822f84a5c6be, f16=0x4031000000000000, f18=0xffffffffffff3c00 | - | 0x2 |

## Test Instruction #263 (global index 309)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f15, f20, f13` | f15=0x7ff8000000000000, f20=0xffffffffffff4c40, f13=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.h f15, f20, f13` | f15=0x7ff8000000000000, f20=0xffffffffffff4c40, f13=0xa85822f84a5c6be | - | 0x2 |

## Test Instruction #287 (global index 333)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f17, f20` | f17=0xffffffff7fc00000, f20=0xffffffff7fff4d40 | - | - |
| Rocket | `fmaxm.d f17, f17, f20` | f17=0x75994ad3001b667d, f20=0xffffffff7fff4d40 | - | 0x2 |

## Test Instruction #306 (global index 352)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x18, f14, f20` | x18=0xffffffffffffffff, f14=0xffffffffffff7e00, f20=0xffffffff7fff4d40 | - | - |
| Rocket | `fleq.h x18, f14, f20` | x18=0xffffffffffffffff, f14=0xffffffffffff7e00, f20=0xffffffff7fff4d40 | - | 0x2 |

## Test Instruction #336 (global index 382)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x17, f18, f18` | x17=0x7fffffff, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x17, f18, f18` | x17=0x7fffffff, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #343 (global index 389)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f19, f18, f18` | f19=0xffffffffffff4c40, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f19, f18, f18` | f19=0xffffffffffff4c40, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #375 (global index 421)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f15, 1.5` | f15=0x7ff8000000000000 | - | - |
| Rocket | `fli.h f15, 1.5` | f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #387 (global index 433)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f15, f17, f15` | f15=0xffffffffffff3e00, f17=0x7ff8000000000000 | - | - |
| Rocket | `fminm.d f15, f17, f15` | f15=0x7ff8000000000000, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #401 (global index 447)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x16, f20, rtz` | x16=0x15, f20=0xffffffff7fff4d40 | - | - |
| Rocket | `fcvtmod.w.d x16, f20, rtz` | x16=0x15, f20=0xffffffff7fff4d40 | - | 0x2 |

## Test Instruction #440 (global index 486)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f14, f13, f17` | f14=0xfffffffffffffe00, f13=0xffffffff7fc00000, f17=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.s f14, f13, f17` | f14=0xfffffffffffffe00, f13=0xffffffff7fc00000, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #450 (global index 496)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x19, f19, f14` | x19=0x15, f19=0x7ff8000000000000, f14=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.d x19, f19, f14` | x19=0x15, f19=0x7ff8000000000000, f14=0xfffffffffffffe00 | - | 0x2 |

## Test Instruction #496 (global index 542)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x20, f20, f14` | x20=0x15, f20=0xffffffff7fff4d40, f14=0x7ff8000000000000 | - | - |
| Rocket | `fltq.d x20, f20, f14` | x20=0x15, f20=0xffffffff7fff4d40, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #511 (global index 557)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f20, f17, f13` | f20=0xffffffff7fff4d40, f17=0x7ff8000000000000, f13=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.h f20, f17, f13` | f20=0xffffffff7fff4d40, f17=0x7ff8000000000000, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #519 (global index 565)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f15, f15` | f13=0x7ff8000000000000, f15=0x7ff8000000000000 | - | - |
| Rocket | `fminm.d f13, f15, f15` | f13=0x7ff8000000000000, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #526 (global index 572)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f13, f16, f15` | f13=0x7ff8000000000000, f16=0xffffffffffff0015, f15=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f13, f16, f15` | f13=0x7ff8000000000000, f16=0xffffffffffff0015, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #561 (global index 607)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f17, f16, f13` | f17=0x7ff8000000000000, f16=0xffffffffffff0015, f13=0x7ff8000000000000 | - | - |
| Rocket | `fminm.s f17, f16, f13` | f17=0x7ff8000000000000, f16=0xffffffffffff0015, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #579 (global index 625)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f13, f18, dyn` | f13=0x7ff8000000000000, f18=0xffffffffffff4d40 | - | - |
| Rocket | `fround.s f13, f18, dyn` | f13=0x7ff8000000000000, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #588 (global index 634)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x19, f20, f18` | x19=0x20000000000015, f20=0x0, f18=0xffffffffffff4d40 | - | - |
| Rocket | `fleq.d x19, f20, f18` | x19=0x20000000000015, f20=0x0, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #604 (global index 650)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x19, f16, f17` | x19=0xffffffffffffffdd, f16=0xffffffffffff7e00, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x19, f16, f17` | x19=0xffffffffffffffdd, f16=0xffffffffffff7e00, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #608 (global index 654)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x15, f15, f19` | x15=0x15, f15=0xffffffffffff7e00, f19=0x7fffffffffff4d40 | - | - |
| Rocket | `fleq.h x15, f15, f19` | x15=0x15, f15=0xffffffffffff7e00, f19=0x7fffffffffff4d40 | - | 0x2 |

## Test Instruction #610 (global index 656)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f14, f16, f14` | f14=0xffffffffffff52b1, f16=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.d f14, f16, f14` | f14=0xffffffffffff52b1, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #614 (global index 660)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f18, 0.5` | f18=0xffffffffffff4d40 | - | - |
| Rocket | `fli.s f18, 0.5` | f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #626 (global index 672)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x16, f19, f18` | x16=0x15, f19=0x7fffffffffff4d40, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.s x16, f19, f18` | x16=0x15, f19=0x7fffffffffff4d40, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #640 (global index 686)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f20, f18, f18` | f20=0x7ff8000000000000, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f20, f18, f18` | f20=0x7ff8000000000000, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #658 (global index 704)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f14, 0x1.0p-4` | f14=0x7ff8000000000000 | - | - |
| Rocket | `fli.d f14, 0x1.0p-4` | f14=0xffffffffffff52b1 | - | 0x2 |

## Test Instruction #687 (global index 733)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f20, f19, rne` | f20=0x7ff8000000000000, f19=0x7fffffffffff4d40 | - | - |
| Rocket | `fround.h f20, f19, rne` | f20=0x7ff8000000000000, f19=0x7fffffffffff4d40 | - | 0x2 |

## Test Instruction #716 (global index 762)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f16, f14, f16` | f16=0xffffffffffff7e00, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.h f16, f14, f16` | f16=0xffffffffffff7e00, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #727 (global index 773)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f15, f18` | f13=0xffffffffffff7e00, f15=0xffffffffffff7e00, f18=0xffffffffffff4d40 | - | - |
| Rocket | `fminm.d f13, f15, f18` | f13=0xffffffffffff7e00, f15=0xffffffffffff7e00, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #762 (global index 808)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x17, f19, f16` | x17=0x2a, f19=0xffffffffffff7e00, f16=0xfffffffffffffc00 | - | - |
| Rocket | `fltq.d x17, f19, f16` | x17=0x2a, f19=0xffffffffffff7e00, f16=0xfffffffffffffc00 | - | 0x2 |

## Test Instruction #768 (global index 814)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x15, f15, f17` | x15=0x15, f15=0xffffffffffff7e00, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.h x15, f15, f17` | x15=0x15, f15=0xffffffffffff7e00, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #792 (global index 838)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x14, f19, f18` | x14=0x15, f19=0xffffffffffff7e00, f18=0x4035000000000000 | - | - |
| Rocket | `fltq.d x14, f19, f18` | x14=0x15, f19=0xffffffffffff7e00, f18=0x4035000000000000 | - | 0x2 |

## Test Instruction #808 (global index 854)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x13, f14, f16` | x13=0x15, f14=0xffffffff7fc00000, f16=0xfffffffffffffc00 | - | - |
| Rocket | `fltq.d x13, f14, f16` | x13=0x15, f14=0xffffffff7fc00000, f16=0xfffffffffffffc00 | - | 0x2 |

## Test Instruction #817 (global index 863)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f19, f16, f13` | f19=0xffffffffffff7e00, f16=0xfffffffffffffc00, f13=0xffffffffffff0000 | - | - |
| Rocket | `fminm.h f19, f16, f13` | f19=0xffffffffffff7e00, f16=0xfffffffffffffc00, f13=0xffffffffffff0000 | - | 0x2 |

## Test Instruction #837 (global index 883)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x16, f14, f17` | x16=0x15, f14=0xffffffffffff7e00, f17=0xffffffff41a80000 | - | - |
| Rocket | `fleq.d x16, f14, f17` | x16=0x15, f14=0xffffffffffff7e00, f17=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #889 (global index 935)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f19, f20, f19` | f19=0xffffffffffff7e00, f20=0x7ff8000000000000 | - | - |
| Rocket | `fminm.d f19, f20, f19` | f19=0xffffffffffff7e00, f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #917 (global index 963)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x15, f19, f19` | x15=0x200, f19=0x7ff8000000000000 | - | - |
| Rocket | `fleq.h x15, f19, f19` | x15=0x200, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #955 (global index 1001)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x20, f14, f20` | x20=0x15, f14=0x7fffffff7fc00000, f20=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.h x20, f14, f20` | x20=0x15, f14=0x7fffffff7fc00000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1012 (global index 1058)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f16, f15, rup` | f16=0xffffffff41a80000, f15=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.h f16, f15, rup` | f16=0xffffffff41a80000, f15=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1062 (global index 1108)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f20, f19, dyn` | f20=0xffffffffffff7e00, f19=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.h f20, f19, dyn` | f20=0xffffffffffff7e00, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1075 (global index 1121)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f14, f19, f13` | f14=0xffffffffffff7e00, f19=0xffffffffffff7e00, f13=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.h f14, f19, f13` | f14=0xffffffffffff7e00, f19=0xffffffffffff7e00, f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1088 (global index 1134)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f14, f13, f19` | f14=0xffffffffffff7e00, f13=0xffffffffffff7e00, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.h f14, f13, f19` | f14=0xffffffffffff7e00, f13=0xffffffffffff7e00, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1117 (global index 1163)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f17, f19, rtz` | f17=0xffffffff41502daa, f19=0xffffffff3f800000 | - | - |
| Rocket | `froundnx.d f17, f19, rtz` | f17=0xffffffff41502daa, f19=0xffffffff3f800000 | - | 0x2 |

## Test Instruction #1127 (global index 1173)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x16, f15, rtz` | x16=0x0, f15=0xffffffff7fc00000 | - | - |
| Rocket | `fcvtmod.w.d x16, f15, rtz` | x16=0x0, f15=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1172 (global index 1218)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x13, f18, f19` | x13=0x6b6, f18=0xffffffff41a80000, f19=0xffffffff3f800000 | - | - |
| Rocket | `fltq.s x13, f18, f19` | x13=0x6b6, f18=0xffffffff41a80000, f19=0xffffffff3f800000 | - | 0x2 |

## Test Instruction #1184 (global index 1230)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f15, f17, f13` | f15=0xffffffffffff7e00, f17=0xffffffffffff7e00, f13=0xffffffff40800000 | - | - |
| Rocket | `fmaxm.h f15, f17, f13` | f15=0xffffffffffff7e00, f17=0xffffffffffff7e00, f13=0xffffffff40800000 | - | 0x2 |

## Test Instruction #1189 (global index 1235)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f15, f17, f14` | f15=0xffffffffffff7e00, f17=0xffffffffffff7e00, f14=0xffffffff44d60000 | - | - |
| Rocket | `fmaxm.s f15, f17, f14` | f15=0xffffffffffff7e00, f17=0xffffffffffff7e00, f14=0xffffffff44d60000 | - | 0x2 |

## Test Instruction #1214 (global index 1260)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `csrrwi x17, mtval2, 30` | x17=0xfffffffffffffda3 | - | 0x2 |
| Rocket | `csrrwi x17, mtval2, 30` | x17=0xfffffffffffffda3 | - | - |

## Test Instruction #1220 (global index 1266)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f18, f19, f20` | f18=0xffffffff41a80000, f19=0xffffffff7fc00000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.h f18, f19, f20` | f18=0xffffffff41a80000, f19=0xffffffff7fc00000, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1237 (global index 1283)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f14, f20, f13` | f14=0xffffffff40800000, f20=0xffffffffffff7e00, f13=0x7ff8000000000000 | - | - |
| Rocket | `fminm.h f14, f20, f13` | f14=0xffffffff40800000, f20=0xffffffffffff7e00, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1245 (global index 1291)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f14, 256.0` | f14=0xffffffffffff7e00 | - | - |
| Rocket | `fli.s f14, 256.0` | f14=0xffffffff40800000 | - | 0x2 |

