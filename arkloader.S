;assemble
; nasm arkloader.S -f bin -o arkloader.bin
;boot
; qemu-system-x86_64 -hda arkloader.bin -nographic

bits 16
org 0x7C00	

;set background
mov ah, 0x06
xor al, al
xor cx, cx
mov dx, 0x184f
mov bh, 0x9b
int 0x10

mov si, msg
call _print
JMP $ 		

_print:
  mov ah, 0x0e
  mov bl, 0x9b
  mov bh, 0x00
  int 0x10

_get_char:
  mov al, [si]
  inc si
  or al, al
  jz _exit
  call _print
  jmp _get_char
  ret

_exit:
  ret

msg: db "          .-~~~-.",13,10,"  .- ~ ~-(       )_ _",13,10," /                    ~ -.",13,10,"|   Ark Systemes          ',",13,10," \          BootLoader     .'",13,10,"   ~- ._ ,. ,.,.,., ,.. -~",13,10,"           '       '",13,10," ",13,10,"Chargement du noyaux en cours..."

times 510 - ($ - $$) db 0	
dw 0xAA55			
