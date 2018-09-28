BITS 16

mov ax, 07C0h  ; Set up 4K stack space after this bootloader
add ax, 288    ; (4096 + 512) / 16 bytes per paragraph
mov ss, ax
mov sp, 4096

cwd             	; "clear" DX for perfect alignment
mov [degree],byte 1
mov [rain],byte 1
mov [patt_xor],byte 1
mov ah, 00h ; set mode
mov al, 13h ; video
mov bl, 0x0     ; pixel data used for drawing
int 10h     
draw:
        mov 	ax,cx		; get column in AH
        sub		ax,di		; offset by framecounter
        sub		si,di		; offset by framecounter
        cmp byte [rain],0
        jz skip_rain
        add     dx,di	; awesome pattern dl set by gh keys
        skip_rain:
        add     si,di	; offset by framecounter
        cmp byte[patt_xor],0
        jz skip_xor
            xor 	al,ah		; the famous XOR pattern
        skip_xor:
        and 	al,bl		; awesome rotation of glitchy stuff! 
        mov 	ah,0x0C		; set subfunction "set pixel" for int 0x10
        int 10h
    loop draw; loop 65536 times
    inc 	di			; increment framecounter
    add bl,byte[degree] 
    inc     bl          ; increment bl 
    mov ah, 0x0 ; maybe this is the issue
jmp draw

patt_xor db 1
rain db 1
degree db 1

  times 510-($-$$) db 0  ; Pad remainder of boot sector with 0s
  dw 0xAA55    ; The standard PC boot signature
