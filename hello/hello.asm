section .data

msg:
  ; TIL: DB does the allocation of `char` in C

  db "Hello, World!"

; Right so, from my *new* undertanding, how this works is it takes the location
; of the end of msg in memory which is a pointer? subtracts it by the start of
; the msg pointer and you get the length.

; Example: (I am still not sure of this myself)
; 
; treat 0 as a pleaceholder of whatever the bit's value could be (even though
; technically it's a null byte)
;
; m stands for a byte with some msg data
; This does *not* represent the actual message defined at the top
; 
; b1 b2 b3 b4 b5 b6 b7 b8 b9 b1
;  0  0  0  m  m  m  m  m  0  0
;           ^              ^
; 			|              |
;          msg 			   $
;
; 9 - 4 = 5 which happens to be true for the example

; TODO: look it up again
size equ $ - msg

ready: db "Are you ready? (press enter) "
ready_size: equ $ - msg

section .text

start:
  ; Write ready message to StdOut
  mov rax, 4
  mov rbx, 1
  mov rcx, ready
  mov rdx, ready_size
  int 0x80

  ; Wait for user input
  mov rax, 3 ; read instruction
  mov rbx, 0 ; StdOut
  mov rcx, 0 ; length of 0 since we do not care about what text is provided
  int 0x80

  loop:
    call print
    jmp loop
  ; call exit

print:
  ; Notice the alphabetical ordering
  ; r *a* x
  ; r *b* x
  ; r *c* x
  ; r *d* x

  ; `mov`  writes the data into said memory registers... I think

  ; We put the instruction we want to carry on here
  mov rax, 4 ; 4 is "sys_write", aka print
  ; Side note: apparently this is *also* used when functions want to return something

  ; This is a special register apparently for some reason???
  mov rbx, 1 ; 1 is the RawFd of StdOut

  ; Scratch
  mov rcx, msg ; This is, afaik, the location of our message in memory
  ; Scratch
  mov rdx, size ; The size of the message

  ; Right so how this works is you throw all your data into the memory registers
  ; then when everything is ready you call an `0x80` system interrupt which then
  ; takes said data and actually does the intended stuff with it
  int 0x80 ; Interrupt

  ret

; "Exiting is for losers."
; - Sun Tzu, The Art of x86_64 ASM.

; exit:
;   mov rax, 1 ; 1 is "exit", not running this causes a segfault >~<
;   mov rbx, 0 ; Our exit code :D, 0 is success as usual
;   int 0x80

global start
