SECTION "Sprite handlers", ROM0

moveSpriteUp::
    ;check if we should move
.move_check
    ld hl, $C100 ; we are just using this register for giggles.
    inc [hl]   ; 
    ld a, [hl]
    and %00000111 ;; should toggle every other inc
    cp  %00000111 ;; after we mask it with the and, we compare to set the Zero flag appropriately
    ret nz

.move_pixel_up
    ld hl, $C000   ; first byte is y,x
    dec [hl]
    ld hl, $C004  
    dec [hl]
    ld hl, $C008  
    dec [hl]
    ld hl, $C00C   
    dec [hl]
ret

moveSpriteDown::
.move_check_up
    ld hl, $C101 ; we are just using this register for giggles.
    inc [hl]   
    ld a, [hl]
    and %00000111 ;; should toggle every other inc
    cp  %00000111 ;; after we mask it with the and, we compare to set the Zero flag appropriately
    ret nz

.move_pixel_down
    ld hl, $C000   ; first byte is y,x
    inc [hl]
    ld hl, $C004  
    inc [hl]
    ld hl, $C008  
    inc [hl]
    ld hl, $C00C   
    inc [hl]
ret

moveSpriteLeft::
.move_check_left
    ld hl, $C102 ; we are just using this register for giggles.
    inc [hl]   
    ld a, [hl]
    and %00000111 ;; should toggle every other inc
    cp  %00000111 ;; after we mask it with the and, we compare to set the Zero flag appropriately
    ret nz

.move_pixel_left
    ld hl, $C001   ; first byte is y,x
    dec [hl]
    ld hl, $C005  
    dec [hl]
    ld hl, $C009  
    dec [hl]
    ld hl, $C00D   
    dec [hl]
ret

moveSpriteRight::
.move_check_right
    ld hl, $C103 ; we are just using this register for giggles.
    inc [hl]   
    ld a, [hl]
    and %00000111 ;; should toggle every other inc
    cp  %00000111 ;; after we mask it with the and, we compare to set the Zero flag appropriately
    ret nz

.move_pixel_right
    ld hl, $C001   ; first byte is y,x
    inc [hl]
    ld hl, $C005  
    inc [hl]
    ld hl, $C009  
    inc [hl]
    ld hl, $C00D   
    inc [hl]
ret