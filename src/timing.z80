INCLUDE "hardware.inc"

Section "Timing", ROM0
waitVBlank::
.vblank
    ld a, [rLY]
    cp 144 ; Check if the LCD is past VBlank
    jr c, .vblank
    ret