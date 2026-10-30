    .section .text
    .globl  _start

_start:
    la      t0, trap_handler
    csrw    mtvec, t0

    csrr    t0, mstatus
    li      t1, 0x00003000       # set FS field to Dirty (0b11) so FP regs usable
    or      t0, t0, t1
    csrw    mstatus, t0
    csrw    fcsr, x0             # clear floating-point status

    # Relax PMP: one NAPOT entry covers the full address space to allow S-mode fetch/load/store
    li      t0, -1
    csrw    pmpaddr0, t0
    li      t0, 0x1f             # R|W|X | A=NAPOT
    csrw    pmpcfg0, t0

    j       user_code

user_code:
addi x1, x0, 1
addi x2, x0, 2
add  x3, x1, x2

exit:
    li      t0, 1                # report success
    la      t1, tohost
    sd      t0, 0(t1)
1:
    j       1b


.align 2
switch_to_s_mode:
    # Set up the page table: identity-map the 1GB region containing 0x80000000
    la      t0, pgtbl
    li      t1, (0x80000 << 10) | 0xCF # PPN=0x80000, full permissions
    sd      t1, 16(t0)

    # Write satp to enable paging (Sv39)
    li      t2, 8
    slli    t2, t2, 60
    srli    t1, t0, 12
    or      t2, t2, t1
    csrw    satp, t2
    sfence.vma

    # Set MPP to S-mode (1) and prepare for mret
    li      t0, ~(3 << 11)
    csrr    t1, mstatus
    and     t1, t1, t0
    li      t2, (1 << 11)
    or      t1, t1, t2
    csrw    mstatus, t1

    csrw    mepc, ra
    mret

.align 2
exit_s_mode:
    ecall                        # Trigger Environment Call (Cause 9)
    ret                          # Handler will actually adjust mepc to skip this spot


    .align  2
trap_handler:
    csrr    t0, mepc             # faulting PC
    csrr    t1, mcause           # trap cause
    csrr    t4, mtval

    # Extract the exception code
    slli    t5, t1, 1
    srli    t1, t5, 1

    # --- Added: handle requests to return to M-mode ---
    li      t3, 9                # Ecall from S-mode
    bne     t1, t3, check_page_fault
    # If it is an ecall, set MPP so mret returns to M-mode
    li      t2, 3 << 11
    csrs    mstatus, t2          # Set MPP to 3 (Machine)
    li      t2, 4                # Skip the ecall instruction
    j       update_mepc

check_page_fault:
    # --- Added: detect page faults (13 or 15) ---
    li      t3, 13
    beq     t1, t3, handle_as_normal_fault
    li      t3, 15
    beq     t1, t3, handle_as_normal_fault
    
    # If it's neither a page fault nor an ecall, fall back to the original logic
    j       original_logic

handle_as_normal_fault:
    # Page faults still need instruction-length decoding and skipping; reuse the original logic
    j       original_logic

original_logic:
    # Original logic: decode instruction length
    li      t2, 2                
    li      t3, 2                
    beq     t1, t3, illegal_len
    li      t3, 1                
    beq     t1, t3, instr_fault_len
    li      t3, 12               
    beq     t1, t3, instr_fault_len

    lhu     t4, 0(t0)
    j       decode_length

other_len:
    lhu     t4, 0(t0)
    j       decode_length

illegal_len:
    beqz    t4, other_len
    j       decode_length
    
instr_fault_len:
    li      t2, 4
    j       update_mepc

decode_length:
    andi    t4, t4, 3
    li      t3, 3
    bne     t4, t3, compressed_len
    li      t2, 4
    j       update_mepc

compressed_len:
    li      t2, 2

update_mepc:
    add     t0, t0, t2
    csrw    mepc, t0
    csrw    mcause, x0
    csrw    mtval, x0
    mret

    .section .data
    .balign 4096
pgtbl:
    .zero 4096
    

    .section .tohost,"aw",@progbits
    .align  6
    .globl  tohost
    .globl  fromhost
tohost:
    .dword  0
fromhost:
    .dword  0