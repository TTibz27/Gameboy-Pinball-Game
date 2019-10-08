INCLUDE "hardware.inc"

SECTION "Header", ROM0[$100]
    ;our code here
EntryPoint: ;
    di ;disable interupts.... lol
    jp Start ;
REPT $150 - $104
    db 0
ENDR


SECTION "Game Init", ROM0

Start:
    ; Turn off the LCD
    call waitVBlank

    xor a ; ld a, 0 ; We only need to reset a value with bit 7 reset, but 0 does the job
    ld [rLCDC], a ; We will have to write to LCDC again later, so it's not a bother, really.
   
.copyFont
    ld hl, $9000 ; vram
    ld bc, FontTiles
    ld de, FontTilesEnd - FontTiles
    call memcpy; 

.copyString ;  '' this actually loads the tile map!
    ld hl, $98E4 ; This will print toward the center of the screen. 
    ld bc, HelloWorldStr
    ld de, 12  ; 12 bytes. I actaully think HELLO WORLD! is 24 bytes. why does 13 work????
    call memcpy

.copySprite
    ld hl, $8010
    ld bc, dummySprite
    ld de, dummySpriteEnd - dummySprite
    call memcpy

    ; blank A0 bytes in WRAM to use for OAM, that why there 
    ; isnt garbage ram data populated in OAM by default
.blankGarbageData
    ld b, $00;
    ld hl, $C000;
    ld de, $A0;
    call memfill;
    ; now lets blank that first tile too.
     ld hl, $8000
     ld de, $10
     call memfill



 ; Init BG pallete
    ld a, %11100100
    ld [rBGP], a

 ; Set Sprite pallete
    ld a, %11100100
    ld [rOBP0],a

    ; Set BG scroll to 0 ,0 
    xor a ; ld a, 0
    ld [rSCY], a
    ld [rSCX], a

    ; Shut sound down
    ld [rNR52], a

    ; Turn screen on, sprites/objects on,  display background
    ld a, %10000011
    ld [rLCDC], a

     ;  should jumpt to a game loop instead of infinite

     ; lets try to copy sprite OAM to ram
    ld hl, $C000
    ld bc, dummyOAM
    ld de, endDummyOAM -dummyOAM
    call memcpy

    ;move DMA subroutine to HRAM
    call CopyDMARoutine
     
.loop
    ;; going to try to draw my sprite here....
    call waitVBlank ; wait for vblank
    
    ;ld a, $c100
    ;cp $00

    
    call moveSprite

    ;; draw our sprites to OAM
    ld  a, HIGH($c000)
    call hOAMDMA
    
    jr .loop


moveSprite::
    ;check if we should move
    .move_Check
        ld hl, $C100 ; we are just using this register for giggles.
        inc [hl]   ; 
        ld a, [hl] ; 
        and %00001111 ;; should toggle every other inc
        cp  %00001111 ;; after we mask it with the and, we compare to set the Zero flag appropriately
        ret nz

    .move_pixel
        ld hl, $C000   ; first byte is y,x
        dec [hl]
        ld hl, $C004   ; first byte is y,x
        dec [hl]
        ld hl, $C008   ; first byte is y,x
        dec [hl]
        ld hl, $C00C   ; first byte is y,x
        dec [hl]
        ret

SECTION "Font", ROM0
    
FontTiles:
INCBIN "font.chr"
FontTilesEnd:

dummySprite:
INCBIN "gfx/dummy.bin"
dummySpriteEnd:


SECTION "dummy OAM Test", ROM0
dummyOAM:
    db $75, $8C, $01, $00  ;y- loc, x - loc, tile #,  flags
    db $7d, $8C, $02, $00  ;bottom left
    db $75, $94, $03, $00  ; top right
    db $7D, $94, $04, $00  ; bottom right
endDummyOAM:



SECTION "Hello World string", ROM0

HelloWorldStr:
    db "12345678901234567890", 0

