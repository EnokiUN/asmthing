section .data

greeting: db "Hi! What is your name?", 0xA, 0
greetingsize: EQU $ - greeting

end: db "Hello", 0x20
endsize: EQU $ - end

end2: db ", greetings from assembly!"
endsize2: EQU $ - end2

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

  push rax ; push to stack

  mov rax, 4
  mov rbx, 1
  mov rcx, end
  mov rdx, endsize
  int 0x80

  pop rbp
  dec rbp ; cheating but shhh

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

global start
