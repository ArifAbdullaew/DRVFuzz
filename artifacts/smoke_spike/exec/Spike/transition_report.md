# SDModel Transition Report

| Item | Value |
| --- | --- |
| Reference implementation | Spike |
| States | 3 |
| Transitions | 2 |
| Unique transitions | 2 |

## Instruction States

| Index | Opcode | Predicates | Instruction |
| --- | --- | --- | --- |
| 0 | `addi` | `boundary_value:int-bitmask`<br>`boundary_value:int-one` | `addi x1, x0, 1` |
| 1 | `addi` | `boundary_value:int-bitmask` | `addi x2, x0, 2` |
| 2 | `add` | `boundary_value:int-bitmask`<br>`boundary_value:int-one` | `add x3, x1, x2` |

## Transitions

| Index | From | To | From Predicates | To Predicates |
| --- | --- | --- | --- | --- |
| 0 | `addi` | `addi` | `boundary_value:int-bitmask`<br>`boundary_value:int-one` | `boundary_value:int-bitmask` |
| 1 | `addi` | `add` | `boundary_value:int-bitmask` | `boundary_value:int-bitmask`<br>`boundary_value:int-one` |
