# Exception Difference Removal Report

- Original test instruction count: 1288
- Removed: 63
- Remaining test instruction count: 1225

## Test Instruction #64 (global index 110)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x13, f14, f17` | x13=0x4000000, f14=0x88afa51ef76c2611, f17=0x0 | - | - |
| Rocket | `fltq.h x13, f14, f17` | x13=0x4000000, f14=0x88afa51ef76c2611, f17=0x0 | - | 0x2 |

## Test Instruction #88 (global index 134)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x17, f18, rtz` | x17=0x10, f18=0xffffffff7fc00000 | - | - |
| Rocket | `fcvtmod.w.d x17, f18, rtz` | x17=0x10, f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #96 (global index 142)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f17, f17, f14` | f17=0x0, f14=0x88afa51ef76c2611 | - | - |
| Rocket | `fmaxm.d f17, f17, f14` | f17=0x0, f14=0x88afa51ef76c2611 | - | 0x2 |

## Test Instruction #164 (global index 210)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x18, f19, f15` | x18=0x10, f19=0x0, f15=0x7ff8000000000000 | - | - |
| Rocket | `fleq.h x18, f19, f15` | x18=0x10, f19=0x0, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #194 (global index 240)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x17, f16, rtz` | x17=0xfffffffffffffd90, f16=0xffffffffffff4c00 | - | - |
| Rocket | `fcvtmod.w.d x17, f16, rtz` | x17=0xfffffffffffffd90, f16=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #198 (global index 244)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f18, min` | f18=0x7ff8000000000000 | - | - |
| Rocket | `fli.h f18, min` | f18=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #222 (global index 268)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `csrrwi x15, mtval2, 19` | x15=0x10 | - | 0x2 |
| Rocket | `csrrwi x15, mtval2, 19` | x15=0x10 | - | - |

## Test Instruction #234 (global index 280)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f16, 0x1.0p-7` | f16=0xffffffffffff7e00 | - | - |
| Rocket | `fli.s f16, 0x1.0p-7` | f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #244 (global index 290)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f17, f18, f15` | f17=0x7ff8000000000000, f18=0x7ff8000000000000, f15=0x7ff8000000000000 | - | - |
| Rocket | `fminm.s f17, f18, f15` | f17=0x7ff8000000000000, f18=0x7ff8000000000000, f15=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #268 (global index 314)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x13, f16, f14` | x13=0x200, f16=0xffffffff3c000000, f14=0xffffffff7fff7e00 | - | - |
| Rocket | `fltq.s x13, f16, f14` | x13=0x200, f16=0xffffffffffff7e00, f14=0xffffffff7fff7e00 | - | 0x2 |

## Test Instruction #293 (global index 339)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f18, f20, f18` | f18=0xffffffff41800000, f20=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.h f18, f20, f18` | f18=0xffffffff41800000, f20=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #318 (global index 364)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f14, f17, f19` | f14=0xffffffff7fff7e00, f17=0xffffffff7fc00000, f19=0x7ff8000000000000 | - | - |
| Rocket | `fminm.h f14, f17, f19` | f14=0xffffffff7fff7e00, f17=0x7ff8000000000000, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #328 (global index 374)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x19, f17, f16` | x19=0x11, f17=0xffffffff7fc00000, f16=0xffffffff3c000000 | - | - |
| Rocket | `fltq.d x19, f17, f16` | x19=0x10, f17=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #330 (global index 376)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x17, f19, f19` | x17=0x11, f19=0x7ff8000000000000 | - | - |
| Rocket | `fleq.d x17, f19, f19` | x17=0x10, f19=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #403 (global index 449)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f17, f20, rne` | f17=0x7fffffffffff7e00, f20=0xffffffff7fc00000 | - | - |
| Rocket | `froundnx.s f17, f20, rne` | f17=0x7fffffffffff7e00, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #422 (global index 468)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f20, f15, rup` | f20=0xffffffff7fc00000, f15=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.h f20, f15, rup` | f20=0xffffffff7fc00000, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #428 (global index 474)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x20, f17, f16` | x20=0x3b, f17=0x7ff8000000000000, f16=0xffffffff3c000000 | - | - |
| Rocket | `fltq.s x20, f17, f16` | x20=0x3b, f17=0x7ff8000000000000, f16=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #439 (global index 485)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f18, f18, f13` | f18=0x7ff8000000000000, f13=0xffffffffffff4c40 | - | - |
| Rocket | `fminm.h f18, f18, f13` | f18=0x7ff8000000000000, f13=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #443 (global index 489)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f16, f13, rmm` | f16=0xffffffff3c000000, f13=0xffffffffffff4c40 | - | - |
| Rocket | `froundnx.s f16, f13, rmm` | f16=0xffffffffffff7e00, f13=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #446 (global index 492)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x13, f13, rtz` | x13=0x11, f13=0xffffffffffff4c40 | - | - |
| Rocket | `fcvtmod.w.d x13, f13, rtz` | x13=0x10, f13=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #452 (global index 498)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f16, f14, rne` | f16=0xffffffff7fc00000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.s f16, f14, rne` | f16=0xffffffffffff7e00, f14=0xffffffff7fff7e00 | - | 0x2 |

## Test Instruction #466 (global index 512)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f14, f14, f20` | f14=0xffffffffffff4c40, f20=0x7ff8000000000000 | - | - |
| Rocket | `fminm.d f14, f14, f20` | f14=0xffffffffffff4c00, f20=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #475 (global index 521)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.d x17, f13, f13` | x17=0x0, f13=0xffffffffffff4c40 | - | - |
| Rocket | `fleq.d x17, f13, f13` | x17=0x0, f13=0xffffffffffff4c00 | - | 0x2 |

## Test Instruction #488 (global index 534)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.h x18, f19, f17` | x18=0x0, f19=0x7ff8000000000000, f17=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.h x18, f19, f17` | x18=0x0, f19=0x7ff8000000000000, f17=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #526 (global index 572)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f15, 0x1.0p-4` | f15=0xffffffff7fc00000 | - | - |
| Rocket | `fli.s f15, 0x1.0p-4` | f15=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #566 (global index 612)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f13, 0x1.0p-16` | f13=0xffffffff7fc00000 | - | - |
| Rocket | `fli.s f13, 0x1.0p-16` | f13=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #573 (global index 619)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.h f14, f19, f20` | f14=0x4031000000000000, f19=0xffffffff7fc00000, f20=0xffffffff7fc00000 | - | - |
| Rocket | `fminm.h f14, f19, f20` | f14=0x4030000000000000, f19=0xffffffff7fc00000, f20=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #582 (global index 628)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f20, f20, f13` | f20=0xffffffff7fc00000, f13=0x4031000000000000 | - | - |
| Rocket | `fmaxm.d f20, f20, f13` | f20=0xffffffff7fc00000, f13=0x4030000000000000 | - | 0x2 |

## Test Instruction #646 (global index 692)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f15, f20, rdn` | f15=0x7fffffffffff7e00, f20=0xffffffffffff7c00 | - | - |
| Rocket | `froundnx.h f15, f20, rdn` | f15=0x7fffffffffff7e00, f20=0xffffffffffff7c00 | - | 0x2 |

## Test Instruction #734 (global index 780)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f13, f14, dyn` | f13=0x0, f14=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.h f13, f14, dyn` | f13=0x0, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #740 (global index 786)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f13, f15, f17` | f13=0xffffffffffff7e00, f15=0xffffffffffff0015, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fmaxm.h f13, f15, f17` | f13=0x0, f15=0xffffffffffff0015, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #745 (global index 791)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.s f13, -1.0` | f13=0xffffffffffff7e00 | - | - |
| Rocket | `fli.s f13, -1.0` | f13=0x0 | - | 0x2 |

## Test Instruction #748 (global index 794)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x14, f14, f17` | x14=0x15, f14=0xffffffffffff0015, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fleq.h x14, f14, f17` | x14=0x15, f14=0xffffffffffff0015, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #758 (global index 804)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f18, 3.0` | f18=0xffffffff7fc00000 | - | - |
| Rocket | `fli.h f18, 3.0` | f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #799 (global index 845)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.s f18, f18, dyn` | f18=0xffffffffffff4200 | - | - |
| Rocket | `fround.s f18, f18, dyn` | f18=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #813 (global index 859)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x16, f20, f17` | x16=0x15, f20=0xffffffffffc00000, f17=0xffffffff00000000 | - | - |
| Rocket | `fltq.d x16, f20, f17` | x16=0x15, f20=0xffffffffffc00000, f17=0xffffffff00000000 | - | 0x2 |

## Test Instruction #819 (global index 865)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.d f19, f13, f13` | f19=0xffffffff7fff4200, f13=0x7ff8000000000000 | - | - |
| Rocket | `fmaxm.d f19, f13, f13` | f19=0xffffffff7fc00000, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #838 (global index 884)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x13, f15, rtz` | x13=0x10, f15=0xffffffffffff7e00 | - | - |
| Rocket | `fcvtmod.w.d x13, f15, rtz` | x13=0x10, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #840 (global index 886)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x19, f16, rtz` | x19=0x15, f16=0xffffffff7fc00000 | - | - |
| Rocket | `fcvtmod.w.d x19, f16, rtz` | x19=0x15, f16=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #843 (global index 889)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x18, f17, f16` | x18=0x15, f17=0xffffffff00000000, f16=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.s x18, f17, f16` | x18=0x15, f17=0xffffffff00000000, f16=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #887 (global index 933)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f16, f14, f16` | f16=0xffffffff7fc00000, f14=0xffffffffffff0015 | - | - |
| Rocket | `fminm.d f16, f14, f16` | f16=0xffffffff7fc00000, f14=0xffffffffffff0015 | - | 0x2 |

## Test Instruction #897 (global index 943)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x20, f18, f17` | x20=0x15, f18=0x7ff8000000000000, f17=0xffffffff7fc00000 | - | - |
| Rocket | `fltq.d x20, f18, f17` | x20=0x15, f18=0x7ff8000000000000, f17=0xffffffff7fc00000 | - | 0x2 |

## Test Instruction #911 (global index 957)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f19, f19, rup` | f19=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.s f19, f19, rup` | f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #955 (global index 1001)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f20, f14, dyn` | f20=0x7ff8000000000000, f14=0xffffffffffff0015 | - | - |
| Rocket | `froundnx.d f20, f14, dyn` | f20=0x7ff8000000000000, f14=0xffffffffffff0015 | - | 0x2 |

## Test Instruction #962 (global index 1008)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f16, f18, f16` | f16=0x7ff8000000000000, f18=0xffffffffffff4d40 | - | - |
| Rocket | `fminm.d f16, f18, f16` | f16=0x7ff8000000000000, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #988 (global index 1034)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.s f17, f19, f19` | f17=0xffffffffffff0015, f19=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.s f17, f19, f19` | f17=0xffffffffffff0015, f19=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1008 (global index 1054)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fmaxm.h f16, f15, f16` | f16=0x3eb5000000000000, f15=0xffffffffffff7e00 | - | - |
| Rocket | `fmaxm.h f16, f15, f16` | f16=0x3eb5000000000000, f15=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1033 (global index 1079)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x20, f17, f20` | x20=0x200, f17=0x7ff8000000000000, f20=0xffffffffffff4d40 | - | - |
| Rocket | `fltq.s x20, f17, f20` | x20=0x200, f17=0x3eb5000000000000, f20=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1040 (global index 1086)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.h f19, f18, rne` | f19=0xffffffffffff7e00, f18=0xffffffffffff4d40 | - | - |
| Rocket | `froundnx.h f19, f18, rne` | f19=0xffffffffffff7e00, f18=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1048 (global index 1094)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f18, f20, rmm` | f18=0xffffffffffff4d40, f20=0xffffffffffff4d40 | - | - |
| Rocket | `fround.h f18, f20, rmm` | f18=0xffffffffffff4d40, f20=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1052 (global index 1098)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.h f14, 0.375` | f14=0xffffffffffff0015 | - | - |
| Rocket | `fli.h f14, 0.375` | f14=0xffffffffffff0015 | - | 0x2 |

## Test Instruction #1084 (global index 1130)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fround.h f19, f17, dyn` | f19=0xffffffffffff4d40, f17=0x7ff8000000000000 | - | - |
| Rocket | `fround.h f19, f17, dyn` | f19=0xffffffffffff7e00, f17=0x3eb5000000000000 | - | 0x2 |

## Test Instruction #1086 (global index 1132)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fcvtmod.w.d x20, f14, rtz` | x20=0x15, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fcvtmod.w.d x20, f14, rtz` | x20=0x15, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1097 (global index 1143)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.s x19, f13, f20` | x19=0x15, f13=0xffffffff00000015, f20=0xffffffffffff4d40 | - | - |
| Rocket | `fleq.s x19, f13, f20` | x19=0x15, f13=0xffffffff00000015, f20=0xffffffffffff4d40 | - | 0x2 |

## Test Instruction #1128 (global index 1174)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.d x18, f20, f14` | x18=0x15, f20=0xffffffff7fc00000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `fltq.d x18, f20, f14` | x18=0x15, f20=0xffffffff7fc00000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1130 (global index 1176)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fleq.h x18, f19, f15` | x18=0x0, f19=0x4035000000000000, f15=0x7fffffffffc00000 | - | - |
| Rocket | `fleq.h x18, f19, f15` | x18=0x15, f19=0x4035000000000000, f15=0x7fffffffffc00000 | - | 0x2 |

## Test Instruction #1164 (global index 1210)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.d f20, f13, f16` | f20=0x0, f13=0x7ff8000000000000, f16=0xffffffffffc00000 | - | - |
| Rocket | `fminm.d f20, f13, f16` | f20=0x0, f13=0x7ff8000000000000, f16=0xffffffffffc00000 | - | 0x2 |

## Test Instruction #1198 (global index 1244)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fltq.s x19, f16, f19` | x19=0x0, f16=0xffffffffffc00000, f19=0x7fffffff7fc00000 | - | - |
| Rocket | `fltq.s x19, f16, f19` | x19=0x0, f16=0xffffffffffc00000, f19=0x7fffffff7fc00000 | - | 0x2 |

## Test Instruction #1212 (global index 1258)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fminm.s f19, f16, f13` | f19=0x7fffffff7fc00000, f16=0xffffffffffff7e00, f13=0x7ff8000000000000 | - | - |
| Rocket | `fminm.s f19, f16, f13` | f19=0x7fffffff7fc00000, f16=0xffffffffffff7e00, f13=0x7ff8000000000000 | - | 0x2 |

## Test Instruction #1215 (global index 1261)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.d f17, f14, rup` | f17=0xffffffffffc00000, f14=0xffffffffffff7e00 | - | - |
| Rocket | `froundnx.d f17, f14, rup` | f17=0xffffffffffc00000, f14=0xffffffffffff7e00 | - | 0x2 |

## Test Instruction #1233 (global index 1279)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f15, 0.875` | f15=0xc034000000000000 | - | - |
| Rocket | `fli.d f15, 0.875` | f15=0xc034000000000000 | - | 0x2 |

## Test Instruction #1248 (global index 1294)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `fli.d f15, 2.0` | f15=0x3fec000000000000 | - | - |
| Rocket | `fli.d f15, 2.0` | f15=0xc034000000000000 | - | 0x2 |

## Test Instruction #1250 (global index 1296)

| Implementation | Instruction | Register Context | Memory Context | Exception |
|------|------|------------|------------|------|
| Spike | `froundnx.s f13, f13, rdn` | f13=0x7ff8000000000000 | - | - |
| Rocket | `froundnx.s f13, f13, rdn` | f13=0x7ff8000000000000 | - | 0x2 |

