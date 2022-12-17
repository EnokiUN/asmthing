section .data

greeting: db "Hi! What is your name?", 0xA, "> "
greetingsize: EQU $ - greeting

end: db "Hello", 0x20
endsize: EQU $ - end

end2: db ", greetings from assembly!", 0xA, 0
endsize2: EQU $ - end2

empty: db "You must pass something...", 0xA, 0
emptysize: EQU $ - empty

name: db 0 ; This must be defined at the end, ask me why if you're interested

section .text

start:
  mov rax, 4
  mov rbx, 1
  mov rcx, greeting
  mov rdx, greetingsize
  int 0x80

  mov rax, 3
  mov rbx, 0
  mov rcx, name
  mov rdx, -1
  int 0x80

  dec rax ; cheating but shhh

  cmp rax, 0
  jle redo_empty

  push rax ; push to stack

  mov rax, 4
  mov rbx, 1
  mov rcx, end
  mov rdx, endsize
  int 0x80

  pop rbp

  mov rax, 4
  mov rbx, 1
  mov rcx, name
  mov rdx, rbp
  int 0x80

  mov rax, 4
  mov rbx, 1
  mov rcx, end2
  mov rdx, endsize2
  int 0x80

  mov rax, 1
  mov rbx, 0
  int 0x80

redo_empty:
  mov rax, 4
  mov rbx, 1
  mov rcx, empty
  mov rdx, emptysize
  int 0x80

  jmp start

global start
