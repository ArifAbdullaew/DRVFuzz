# Exception Difference Removal Report

- Original test instruction count: 1289
- Removed: 67
- Remaining test instruction count: 1222

## Test Instruction #2 (global index 48)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x13, f17, f16` | x13=0x9b3f54e642a07f60, f17=0xfc0c561bff784c17, f16=0xf15d4dee128a5f99 | - | - |
| Rocket | `fleq.d x13, f17, f16` | x13=0x9b3f54e642a07f60, f17=0xfc0c561bff784c17, f16=0xf15d4dee128a5f99 | - | 0x2 |

## Test Instruction #44 (global index 90)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f15, f17, rmm` | f15=0xc68809fcec5d3138, f17=0xffffffffffff4c00 | - | - |
| Rocket | `fround.h f15, f17, rmm` | f15=0xc68809fcec5d3138, f17=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #47 (global index 93)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f19, f17, dyn` | f19=0x4030000000000000, f17=0xffffffffffff4c00 | - | - |
| Rocket | `fround.h f19, f17, dyn` | f19=0x4030000000000000, f17=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #62 (global index 108)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f14, f15, rmm` | f14=0x152533645dc98538, f15=0xffffffffffff4c00 | - | - |
| Rocket | `fround.s f14, f15, rmm` | f14=0x152533645dc98538, f15=0xc68809fcec5d3138 | - | 0x2 |

## Test Instruction #66 (global index 112)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x15, f13, f20` | x15=0x11, f13=0x46c98a9cbb23044c, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fleq.h x15, f13, f20` | x15=0x11, f13=0x46c98a9cbb23044c, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #68 (global index 114)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f13, f14, f18` | f13=0x46c98a9cbb23044c, f14=0xffffffff7fc00000, f18=0xf15d4dee128a5f99 | - | - |
| Rocket | `fmaxm.d f13, f14, f18` | f13=0x46c98a9cbb23044c, f14=0x152533645dc98538, f18=0xf15d4dee128a5f99 | - | 0x2 |

## Test Instruction #131 (global index 177)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f19, 0.625` | f19=0xffffffffffff4c00 | - | - |
| Rocket | `fli.d f19, 0.625` | f19=0x4030000000000000 | - | 0x2 |

## Test Instruction #136 (global index 182)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f19, f13, f15` | f19=0x3fe4000000000000, f13=0x7ff8000000000000, f15=0xffffffffffff3c00 | - | - |
| Rocket | `fmaxm.h f19, f13, f15` | f19=0x4030000000000000, f13=0x7ff8000000000000, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #141 (global index 187)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f13, f19, f19` | f13=0x7ff8000000000000, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.s f13, f19, f19` | f13=0x7ff8000000000000, f19=0x4030000000000000 | - | 0x2 |

## Test Instruction #148 (global index 194)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f13, 32768.0` | f13=0xffffffff7fc00000 | - | - |
| Rocket | `fli.h f13, 32768.0` | f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #202 (global index 248)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f18, f15, f13` | f18=0xffffffff7fff4c00, f15=0x4031000000000000, f13=0xfffffffffffffe00 | - | - |
| Rocket | `fmaxm.d f18, f15, f13` | f18=0xffffffff7fc00000, f15=0x4031000000000000, f13=0xfffffffffffffe00 | - | 0x2 |

## Test Instruction #217 (global index 263)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f18, f20, f17` | f18=0x7ff8000000000000, f20=0xffffffffffffd450, f17=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.s f18, f20, f17` | f18=0xffffffff7fc00000, f20=0xffffffffffffd450, f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #225 (global index 271)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x15, f14, f14` | x15=0x1, f14=0x7ff8000000000000 | - | - |
| Rocket | `fleq.s x15, f14, f14` | x15=0x1, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #233 (global index 279)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f19, f18, f20` | f19=0xffffffff7fc00000, f18=0xffffffff7fc00000, f20=0xffffffffffffd450 | - | - |
| Rocket | `fmaxm.h f19, f18, f20` | f19=0xffffffff7fc00000, f18=0xffffffff7fc00000, f20=0xffffffffffffd450 | - | 0x2 |

## Test Instruction #242 (global index 288)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x18, f19, f18` | x18=0x11, f19=0xffffffffffff7e00, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.s x18, f19, f18` | x18=0x11, f19=0xffffffff7fc00000, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #281 (global index 327)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f17, -1.0` | f17=0xfffffffffffffe00 | - | - |
| Rocket | `fli.h f17, -1.0` | f17=0xfffffffffffffe00 | - | 0x2 |

## Test Instruction #284 (global index 330)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f14, f16, rmm` | f14=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.s f14, f16, rmm` | f14=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #303 (global index 349)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f14, f20, f19` | f14=0xffffffff7fc00000, f20=0xffffffff7fc00000, f19=0xffffffffffff4c40 | - | - |
| Rocket | `fmaxm.d f14, f20, f19` | f14=0x7ff8000000000000, f20=0xffffffff7fc00000, f19=0xffffffffffff4c40 | - | 0x2 |

## Test Instruction #332 (global index 378)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f13, f17, rdn` | f13=0xffffffffffff4c40, f17=0xffffffffffffbc00 | - | - |
| Rocket | `fround.s f13, f17, rdn` | f13=0xffffffffffff4c40, f17=0xfffffffffffffe00 | - | 0x2 |

## Test Instruction #340 (global index 386)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x16, f14, f18` | x16=0xffffffffffff7e00, f14=0xffffffffffff7e00, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x16, f14, f18` | x16=0xffffffffffff7e00, f14=0xffffffffffff7e00, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #374 (global index 420)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f18, 0.875` | f18=0x7ff8000000000000 | - | - |
| Rocket | `fli.d f18, 0.875` | f18=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #414 (global index 460)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x20, f14, rtz` | x20=0x11, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fcvtmod.w.d x20, f14, rtz` | x20=0x11, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #423 (global index 469)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x19, f17, f14` | x19=0x200, f17=0xffffffffffff7e00, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.s x19, f17, f14` | x19=0x200, f17=0xffffffffffff0000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #445 (global index 491)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f17, 0.5` | f17=0x7ff8000000000000 | - | - |
| Rocket | `fli.s f17, 0.5` | f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #454 (global index 500)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f18, f13, f20` | f18=0xffffffff7fff4c40, f13=0xffffffff7fc00000, f20=0xffffffff4f800000 | - | - |
| Rocket | `fminm.h f18, f13, f20` | f18=0xffffffff7fff4c40, f13=0xffffffffffff4c40, f20=0xffffffff4f800000 | - | 0x2 |

## Test Instruction #470 (global index 516)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x14, f17, rtz` | x14=0x11, f17=0xffffffffffff7e00 | - | - |
| Rocket | `fcvtmod.w.d x14, f17, rtz` | x14=0x11, f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #474 (global index 520)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f17, f20, f16` | f17=0xffffffffffff7e00, f20=0xffffffff4f800000, f16=0x0 | - | - |
| Rocket | `fminm.h f17, f20, f16` | f17=0xffffffffffff7e00, f20=0xffffffff4f800000, f16=0x0 | - | 0x2 |

## Test Instruction #488 (global index 534)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f18, f18, dyn` | f18=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.d f18, f18, dyn` | f18=0xffffffff7fff4c40 | - | 0x2 |

## Test Instruction #497 (global index 543)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f18, f14, dyn` | f18=0x7ff8000000000000, f14=0xffffffffffff4c40 | - | - |
| Rocket | `fround.s f18, f14, dyn` | f18=0xffffffff7fff4c40, f14=0xffffffffffff4c40 | - | 0x2 |

## Test Instruction #499 (global index 545)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x19, f15, f19` | x19=0x11, f15=0xffffffffffff7e00, f19=0xffffffffffff4c40 | - | - |
| Rocket | `fleq.h x19, f15, f19` | x19=0x11, f15=0xffffffffffff7e00, f19=0xffffffffffff4c40 | - | 0x2 |

## Test Instruction #507 (global index 553)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f16, f18, rdn` | f16=0xfffffffffffffe00, f18=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.d f16, f18, rdn` | f16=0xfffffffffffffe00, f18=0xffffffff7fff4c40 | - | 0x2 |

## Test Instruction #520 (global index 566)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f16, f19, f19` | f16=0x7ff8000000000000, f19=0xffffffffffffcc40 | - | - |
| Rocket | `fminm.h f16, f19, f19` | f16=0xfffffffffffffe00, f19=0xffffffffffffcc40 | - | 0x2 |

## Test Instruction #537 (global index 583)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f19, min` | f19=0xffffffffffffcc40 | - | - |
| Rocket | `fli.h f19, min` | f19=0xffffffffffffcc40 | - | 0x2 |

## Test Instruction #564 (global index 610)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f17, inf` | f17=0xffffffffffff7e00 | - | - |
| Rocket | `fli.h f17, inf` | f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #575 (global index 621)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f13, f19, rup` | f13=0x7ff8000000000000, f19=0xffffffffffff0400 | - | - |
| Rocket | `froundnx.s f13, f19, rup` | f13=0x7ff8000000000000, f19=0xffffffffffffcc40 | - | 0x2 |

## Test Instruction #585 (global index 631)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f18, f18, f19` | f18=0xffffffff41880000, f19=0xffffffffffff0400 | - | - |
| Rocket | `fmaxm.s f18, f18, f19` | f18=0xffffffff41880000, f19=0xffffffffffffcc40 | - | 0x2 |

## Test Instruction #601 (global index 647)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f18, 8.0` | f18=0xffffffff7fc00000 | - | - |
| Rocket | `fli.d f18, 8.0` | f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #615 (global index 661)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f14, f16, f16` | f14=0xffffffffffff7e00, f16=0xffffffffffffcc40 | - | - |
| Rocket | `fmaxm.h f14, f16, f16` | f14=0xffffffffffff7e00, f16=0xfffffffffffffe00 | - | 0x2 |

## Test Instruction #619 (global index 665)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f17, f19, rdn` | f17=0xffffffffffff7c00, f19=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.h f17, f19, rdn` | f17=0xffffffffffff7e00, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #627 (global index 673)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f13, f13, f13` | f13=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.d f13, f13, f13` | f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #640 (global index 686)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f18, f18, f17` | f18=0x7ff8000000000000, f17=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.d f18, f18, f17` | f18=0x7ff8000000000000, f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #671 (global index 717)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x20, f20, rtz` | x20=0x0, f20=0xffffffff4f800000 | - | - |
| Rocket | `fcvtmod.w.d x20, f20, rtz` | x20=0x0, f20=0xffffffff4f800000 | - | 0x2 |

## Test Instruction #696 (global index 742)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f19, f15, f13` | f19=0x7ff8000000000000, f15=0xffffffff7fc00000, f13=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.s f19, f15, f13` | f19=0x7ff8000000000000, f15=0x7ff8000000000000, f13=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #704 (global index 750)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x18, f14, f13` | x18=0x4400000000000, f14=0xffffffffffff7e00, f13=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x18, f14, f13` | x18=0x4400000000000, f14=0xffffffffffff7e00, f13=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #724 (global index 770)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f20, f15, rmm` | f20=0xffffffffffff7e00, f15=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.d f20, f15, rmm` | f20=0xffffffffffff7e00, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #734 (global index 780)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f15, f19, f15` | f15=0xffffffff7fc00000, f19=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.d f15, f19, f15` | f15=0x7ff8000000000000, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #760 (global index 806)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x15, f14, rtz` | x15=0x11, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fcvtmod.w.d x15, f14, rtz` | x15=0x11, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #824 (global index 870)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x19, f18, f13` | x19=0xffffffffffff7e00, f18=0x7ff8000000000000, f13=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.h x19, f18, f13` | x19=0xffffffffffff7e00, f18=0x7ff8000000000000, f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #842 (global index 888)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x16, f19, f17` | x16=0x0, f19=0xffffffff7fc00000, f17=0xffffffff00000011 | - | - |
| Rocket | `fltq.h x16, f19, f17` | x16=0x0, f19=0x7ff8000000000000, f17=0xffffffff00000011 | - | 0x2 |

## Test Instruction #861 (global index 907)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x14, f15, f13` | x14=0x0, f15=0xffffffffffff7e00, f13=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.s x14, f15, f13` | x14=0x0, f15=0xffffffffffff7e00, f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #880 (global index 926)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x18, f14, f16` | x18=0x11, f14=0xffffffff7fc00000, f16=0xffffffff41880000 | - | - |
| Rocket | `fleq.d x18, f14, f16` | x18=0x11, f14=0xffffffff7fc00000, f16=0xffffffff41880000 | - | 0x2 |

## Test Instruction #921 (global index 967)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f17, f19, f20` | f17=0x7ff8000000000000, f19=0x7ff8000000000000, f20=0xffffffffffff7c00 | - | - |
| Rocket | `fmaxm.h f17, f19, f20` | f17=0x7ff8000000000000, f19=0x7ff8000000000000, f20=0xffffffffffff7c00 | - | 0x2 |

## Test Instruction #940 (global index 986)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f16, f14, dyn` | f16=0x7ff8000000000000, f14=0x7ff8000000000000 | - | - |
| Rocket | `fround.d f16, f14, dyn` | f16=0x7ff8000000000000, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #946 (global index 992)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x15, f13, f17` | x15=0x15, f13=0x15, f17=0x7ff8000000000000 | - | - |
| Rocket | `fltq.d x15, f13, f17` | x15=0x15, f13=0x15, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #962 (global index 1008)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f13, f13, f20` | f13=0xffffffffffff0000, f20=0x7ff8000000000000 | - | - |
| Rocket | `fminm.s f13, f13, f20` | f13=0xffffffffffff4d40, f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #977 (global index 1023)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x15, f16, rtz` | x15=0x15, f16=0x7ff8000000000000 | - | - |
| Rocket | `fcvtmod.w.d x15, f16, rtz` | x15=0x15, f16=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #994 (global index 1040)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x16, f18, f18` | x16=0x15, f18=0x7ff8000000000000 | - | - |
| Rocket | `fltq.h x16, f18, f18` | x16=0x15, f18=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #996 (global index 1042)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f14, f19, f19` | f14=0x7ff8000000000000, f19=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f14, f19, f19` | f14=0x7ff8000000000000, f19=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1012 (global index 1058)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x15, f16, f17` | x15=0x4000000000000000, f16=0xffffffffffff7e00, f17=0xffffffffffc00000 | - | - |
| Rocket | `fleq.s x15, f16, f17` | x15=0x0, f16=0xffffffffffff7e00, f17=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1044 (global index 1090)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f15, min` | f15=0x0 | - | - |
| Rocket | `fli.s f15, min` | f15=0x0 | - | 0x2 |

## Test Instruction #1060 (global index 1106)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f16, f14, f15` | f16=0xffffffff41a80000, f14=0xffffffffffff7e00, f15=0xffffffff00800000 | - | - |
| Rocket | `fminm.d f16, f14, f15` | f16=0xffffffff41a80000, f14=0xffffffffffff7e00, f15=0x0 | - | 0x2 |

## Test Instruction #1071 (global index 1117)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x17, f17, f13` | x17=0x110000f7, f17=0xffffffffffc00000, f13=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x17, f17, f13` | x17=0x110000f7, f17=0xffffffffffff4d40, f13=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1073 (global index 1119)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x13, f17, f20` | x13=0x1f, f17=0xffffffffffc00000, f20=0x7ff8000000000000 | - | - |
| Rocket | `fltq.s x13, f17, f20` | x13=0x1f, f17=0xffffffffffff4d40, f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1082 (global index 1128)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f14, 0x1.0p-3` | f14=0xffffffffffff7e00 | - | - |
| Rocket | `fli.h f14, 0x1.0p-3` | f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1236 (global index 1282)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f13, f20, f17` | f13=0xffffffff7fc00000, f20=0xffffffff7fff7e00, f17=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f13, f20, f17` | f13=0xffffffffffff4d40, f20=0xffffffff7fff7e00, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1247 (global index 1293)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x17, f16, f19` | x17=0x78c4cc7d5239251a, f16=0xffffffffffff7e00, f19=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.h x17, f16, f19` | x17=0x78c4cc7d5239251a, f16=0xffffffffffff7e00, f19=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1253 (global index 1299)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f13, f16, rdn` | f13=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.s f13, f16, rdn` | f13=0xffffffffffff4d40, f16=0xffffffffffff7e00 | - | 0x2 |

