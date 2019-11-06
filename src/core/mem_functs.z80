INCLUDE "hardware.inc"

SECTION "memcpy", ROM0
    ;Memory Functions should go in this section.
memcpy::
    ; DE = block size
    ; BC = source address
    ; HL = destination address
    ; dec DE

.memcpy_loop:
    ld A, [BC]
    ld [HL], A
    inc BC
    inc HL
    dec DE

.memcpy_check_limit:
    ld A, E
    cp $00
    jr nz, .memcpy_loop     
    ld A, D
    cp $00
    jr nz, .memcpy_loop
    ret

memfill:: ;; this will fill a  block of memory with the same bytes repeating
    ;  B = value to fill
    ; DE = Block size
    ; HL = destination address
.memfill_loop:
    ld [HL], B
    inc HL
    dec DE

.memfill_check:
    ld A, E
    cp $00
    jr nz, .memfill_loop     
    ld A, D
    cp $00
    jr nz, .memfill_loop
    ret
    



SECTION "OAM DMA routine", ROM0
CopyDMARoutine::
  ld  hl, DMARoutine
  ld  b, DMARoutineEnd - DMARoutine ; Number of bytes to copy
  ld  c, LOW(hOAMDMA) ; Low byte of the destination address
.copy
  ld  a, [hli]
  ldh [c], a
  inc c
  dec b
  jr  nz, .copy
  ret

DMARoutine:
  ldh [rDMA], a
  
  ld  a, 40
.wait
  dec a
  jr  nz, .wait
  ret
DMARoutineEnd:


SECTION "OAM DMA", HRAM

hOAMDMA::
  ds DMARoutineEnd - DMARoutine ; Reserve space in HRAM to copy the routine to
