# Exception Difference Removal Report

- Original test instruction count: 1289
- Removed: 62
- Remaining test instruction count: 1227

## Test Instruction #11 (global index 57)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f17, 0.75` | f17=0x30b7f4ac15b65ddb | - | - |
| Rocket | `fli.s f17, 0.75` | f17=0x30b7f4ac15b65ddb | - | 0x2 |

## Test Instruction #28 (global index 74)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f14, f19, dyn` | f14=0xffffffffffff7e00, f19=0x3d3bccc71bf5b05b | - | - |
| Rocket | `froundnx.d f14, f19, dyn` | f14=0xffffffffffff7e00, f19=0x3d3bccc71bf5b05b | - | 0x2 |

## Test Instruction #77 (global index 123)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `csrrwi x20, mtval2, 11` | x20=0x4000 | - | 0x2 |
| Rocket | `csrrwi x20, mtval2, 11` | x20=0x4000 | - | - |

## Test Instruction #128 (global index 174)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x18, f13, f20` | x18=0x7fffffff, f13=0xffffffffffff7e00, f20=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.s x18, f13, f20` | x18=0x7fffffff, f13=0xffffffffffff7e00, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #138 (global index 184)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x13, f16, f18` | x13=0x0, f16=0xffffffff7fc00000, f18=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.d x13, f16, f18` | x13=0x0, f16=0xffffffff7fc00000, f18=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #160 (global index 206)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f13, f16, f20` | f13=0xffffffffffff7e00, f16=0xffffffff7fc00000, f20=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.s f13, f16, f20` | f13=0xffffffffffff7e00, f16=0xffffffff7fc00000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #188 (global index 234)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f19, f15, f17` | f19=0xffffffffffff4c40, f15=0x71f0084de5e37239, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f19, f15, f17` | f19=0xffffffffffff4c40, f15=0x71f0084de5e37239, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #195 (global index 241)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x17, f18, f20` | x17=0x10, f18=0x7ff8000000000000, f20=0xffffffffffff4c40 | - | - |
| Rocket | `fltq.h x17, f18, f20` | x17=0x10, f18=0x7ff8000000000000, f20=0xffffffffffff4c40 | - | 0x2 |

## Test Instruction #240 (global index 286)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x19, f13, f15` | x19=0x11, f13=0x7ff8000000000000, f15=0xffffffffffff7e00 | - | - |
| Rocket | `fleq.h x19, f13, f15` | x19=0x11, f13=0x7ff8000000000000, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #248 (global index 294)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f19, f14, rdn` | f19=0xffffffff7fc00000, f14=0xffffffffffff4c40 | - | - |
| Rocket | `froundnx.h f19, f14, rdn` | f19=0xffffffffffff4c40, f14=0xffffffffffff4c40 | - | 0x2 |

## Test Instruction #269 (global index 315)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f14, f15, f14` | f14=0xffffffffffff4c40, f15=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.d f14, f15, f14` | f14=0xffffffffffff4c40, f15=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #273 (global index 319)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f18, 0x1.0p-3` | f18=0xffffffff7fc00000 | - | - |
| Rocket | `fli.h f18, 0x1.0p-3` | f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #285 (global index 331)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f13, f13, dyn` | f13=0xffffffffffff7e00 | - | - |
| Rocket | `fround.s f13, f13, dyn` | f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #298 (global index 344)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f13, f17, rmm` | f13=0xffffffff7fc00000, f17=0x220000 | - | - |
| Rocket | `froundnx.s f13, f17, rmm` | f13=0xffffffffffff7e00, f17=0x220000 | - | 0x2 |

## Test Instruction #304 (global index 350)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f18, f15, dyn` | f18=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | - |
| Rocket | `fround.d f18, f15, dyn` | f18=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #330 (global index 376)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x15, f14, f13` | x15=0x11, f14=0xffffffff7fc00000, f13=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.d x15, f14, f13` | x15=0x11, f14=0xffffffff7fc00000, f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #337 (global index 383)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f19, f13, f15` | f19=0xffffffff7fc00000, f13=0xffffffffffff7e00, f15=0xffffffff41880000 | - | - |
| Rocket | `fminm.s f19, f13, f15` | f19=0xffffffff7fc00000, f13=0xffffffffffff7e00, f15=0xffffffff41880000 | - | 0x2 |

## Test Instruction #341 (global index 387)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f16, 0.625` | f16=0x7ff8000000000000 | - | - |
| Rocket | `fli.d f16, 0.625` | f16=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #367 (global index 413)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x17, f13, f14` | x17=0x15, f13=0x7ff8000000000000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.h x17, f13, f14` | x17=0x15, f13=0x7ff8000000000000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #381 (global index 427)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f20, f18` | f17=0x4031000000000000, f20=0xffffffffffff7e00, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.d f17, f20, f18` | f17=0x4031000000000000, f20=0xffffffffffff7e00, f18=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #383 (global index 429)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f16, f13, rdn` | f16=0x7ff8000000000000, f13=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.s f16, f13, rdn` | f16=0x7ff8000000000000, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #390 (global index 436)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f20, f18, dyn` | f20=0xffffffffffff7e00, f18=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.s f20, f18, dyn` | f20=0xffffffffffff7e00, f18=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #396 (global index 442)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f20, f19, f19` | f20=0xffffffff7fc00000, f19=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.h f20, f19, f19` | f20=0xffffffffffff7e00, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #407 (global index 453)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f17, f14, rup` | f17=0x7ff8000000000000, f14=0x7fffffff7fc00000 | - | - |
| Rocket | `froundnx.h f17, f14, rup` | f17=0x4031000000000000, f14=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #409 (global index 455)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f19, f16, f19` | f19=0x7ff8000000000000, f16=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.h f19, f16, f19` | f19=0x7ff8000000000000, f16=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #415 (global index 461)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x15, f13, f15` | x15=0x15, f13=0xffffffffffff4d40, f15=0xffffffff41880000 | - | - |
| Rocket | `fleq.s x15, f13, f15` | x15=0x15, f13=0xffffffffffff4d40, f15=0xffffffff41880000 | - | 0x2 |

## Test Instruction #431 (global index 477)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f18, f15, f20` | f18=0xffffffff7fc00000, f15=0xffffffff41880000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.s f18, f15, f20` | f18=0xffffffff7fc00000, f15=0xffffffff41880000, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #526 (global index 572)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f16, 256.0` | f16=0xffffffffffff7e00 | - | - |
| Rocket | `fli.h f16, 256.0` | f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #539 (global index 585)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f19, f13, f19` | f19=0xffffffff41a80000, f13=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.d f19, f13, f19` | f19=0xffffffff41a80000, f13=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #551 (global index 597)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f20, f14, f15` | f20=0xffffffffffff7e00, f14=0x7fffffff7fc00000, f15=0x15 | - | - |
| Rocket | `fmaxm.h f20, f14, f15` | f20=0xffffffffffff7e00, f14=0x7ff8000000000000, f15=0x15 | - | 0x2 |

## Test Instruction #560 (global index 606)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f13, f18, rne` | f13=0xffffffffffff7e00, f18=0xffffffffffff7e00 | - | - |
| Rocket | `fround.s f13, f18, rne` | f13=0xffffffffffff7e00, f18=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #585 (global index 631)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f17, f14, dyn` | f17=0xffffffffffff7e00, f14=0x7fffffff7fc00000 | - | - |
| Rocket | `froundnx.s f17, f14, dyn` | f17=0xffffffffffff7e00, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #618 (global index 664)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x19, f19, f17` | x19=0x15, f19=0x7ff8000000000000, f17=0xffffffff41a80000 | - | - |
| Rocket | `fleq.s x19, f19, f17` | x19=0x15, f19=0x7ff8000000000000, f17=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #621 (global index 667)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f14, inf` | f14=0x7fffffff7fc00000 | - | - |
| Rocket | `fli.h f14, inf` | f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #675 (global index 721)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f16, f13, rdn` | f16=0xffffffffffff7e00, f13=0xffffffff41a80000 | - | - |
| Rocket | `fround.d f16, f13, rdn` | f16=0xffffffffffff7e00, f13=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #680 (global index 726)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f16, 8.0` | f16=0x7ff8000000000000 | - | - |
| Rocket | `fli.s f16, 8.0` | f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #685 (global index 731)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f14, f14, f13` | f14=0xfffffffffffffe00, f13=0xffffffff41a80000 | - | - |
| Rocket | `fminm.s f14, f14, f13` | f14=0xfffffffffffffe00, f13=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #689 (global index 735)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x17, f14, f15` | x17=0x15, f14=0xffffffff7fc00000, f15=0x7ff8000000000000 | - | - |
| Rocket | `fleq.h x17, f14, f15` | x17=0x15, f14=0xfffffffffffffe00, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #740 (global index 786)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f20, f19, dyn` | f20=0xffffffff41a80000, f19=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.h f20, f19, dyn` | f20=0xffffffff41a80000, f19=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #766 (global index 812)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f17, 0.5` | f17=0xffffffffffff7e00 | - | - |
| Rocket | `fli.h f17, 0.5` | f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #797 (global index 843)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f17, f14, f15` | f17=0xffffffffffff3800, f14=0xffffffffffff7e00, f15=0xffffffffffff7e00 | - | - |
| Rocket | `fminm.d f17, f14, f15` | f17=0xffffffffffff7e00, f14=0xffffffffffff7e00, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #836 (global index 882)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f14, f20, dyn` | f14=0xffffffff7fc00000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fround.h f14, f20, dyn` | f14=0xffffffff7fc00000, f20=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #841 (global index 887)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f13, 0.5` | f13=0xffffffff41800000 | - | - |
| Rocket | `fli.s f13, 0.5` | f13=0xffffffff41800000 | - | 0x2 |

## Test Instruction #862 (global index 908)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f17, 2.5` | f17=0x4035000000000000 | - | - |
| Rocket | `fli.d f17, 2.5` | f17=0x4035000000000000 | - | 0x2 |

## Test Instruction #869 (global index 915)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f15, inf` | f15=0xffffffffffff7e00 | - | - |
| Rocket | `fli.s f15, inf` | f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #872 (global index 918)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f16, f20, dyn` | f16=0xffffffff41a80000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.d f16, f20, dyn` | f16=0xffffffff41a80000, f20=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #884 (global index 930)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x17, f19, f13` | x17=0x15, f19=0xffffffff7fc00000, f13=0xffffffff3f000000 | - | - |
| Rocket | `fleq.s x17, f19, f13` | x17=0x15, f19=0xffffffff7fc00000, f13=0xffffffff41800000 | - | 0x2 |

## Test Instruction #921 (global index 967)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f14, f14, f19` | f14=0xffffffff41a80000, f19=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.s f14, f14, f19` | f14=0xffffffff41a80000, f19=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #925 (global index 971)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f18, f13, dyn` | f18=0xffffffff7fc00000, f13=0xffffffff3f000000 | - | - |
| Rocket | `froundnx.h f18, f13, dyn` | f18=0xffffffff7fc00000, f13=0xffffffff41800000 | - | 0x2 |

## Test Instruction #952 (global index 998)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f20, f19, rtz` | f20=0xffffffff7fc00000, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fround.h f20, f19, rtz` | f20=0xffffffff7fc00000, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #958 (global index 1004)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f13, f14, f16` | f13=0xffffffff3f000000, f14=0xffffffff7fc00000, f16=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f13, f14, f16` | f13=0xffffffff41800000, f14=0xffffffff7fc00000, f16=0xffffffff41a80000 | - | 0x2 |

## Test Instruction #989 (global index 1035)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f13, f19, rne` | f13=0x7ff8000000000000, f19=0xffffffffffff0000 | - | - |
| Rocket | `fround.d f13, f19, rne` | f13=0xffffffff41800000, f19=0xffffffffffff0000 | - | 0x2 |

## Test Instruction #996 (global index 1042)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f14, f14, rtz` | f14=0xffffffff7fc00000 | - | - |
| Rocket | `fround.h f14, f14, rtz` | f14=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #1044 (global index 1090)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f16, f15, dyn` | f16=0x7ff8000000000000, f15=0xffffffffffff7e00 | - | - |
| Rocket | `fround.d f16, f15, dyn` | f16=0xffffffff41a80000, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1046 (global index 1092)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x17, f19, f14` | x17=0x15, f19=0x0, f14=0x7ff8000000000000 | - | - |
| Rocket | `fltq.d x17, f19, f14` | x17=0x15, f19=0x0, f14=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1092 (global index 1138)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x18, f15, f17` | x18=0xfffffffffffe8000, f15=0xffffffffffff7e00, f17=0x7ff8000000000000 | - | - |
| Rocket | `fleq.s x18, f15, f17` | x18=0xfffffffffffe8000, f15=0xffffffffffff7e00, f17=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1136 (global index 1182)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f17, 128.0` | f17=0xffffffffffff0000 | - | - |
| Rocket | `fli.h f17, 128.0` | f17=0xffffffffffff0000 | - | 0x2 |

## Test Instruction #1154 (global index 1200)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f20, f20, rup` | f20=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.d f20, f20, rup` | f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1180 (global index 1226)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f18, f20, rup` | f18=0xffffffff00000015, f20=0x7ff8000000000000 | - | - |
| Rocket | `fround.h f18, f20, rup` | f18=0xffffffff00000015, f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1207 (global index 1253)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.d f15, f15, rup` | f15=0x7ff8000000000000 | - | - |
| Rocket | `fround.d f15, f15, rup` | f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1252 (global index 1298)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f13, f18, rdn` | f13=0xffffffff7fc00000, f18=0xffffffffffff4d40 | - | - |
| Rocket | `fround.h f13, f18, rdn` | f13=0xffffffff7fc00000, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1282 (global index 1328)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x19, f13, f20` | x19=0x15, f13=0x7ff8000000000000, f20=0x7ff8000000000000 | - | - |
| Rocket | `fleq.h x19, f13, f20` | x19=0x15, f13=0x7ff8000000000000, f20=0x7ff8000000000000 | - | 0x2 |

