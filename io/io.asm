section .data

section .text

start:
  call exit

; Good 'ol code `0` exit
exit:
  mov rax, 1
  mov rbx, 0
  int 0x80

global start
