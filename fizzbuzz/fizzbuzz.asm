section .data

fizz: DB "Fizz"
fizzsize: EQU $ - fizz
buzz: DB "Buzz"
buzzsize: EQU $ - buzz
lf: DB 0xA, 0
lfsize: EQU $ - lf
digits: DB "0123456789"
; digitssize: EQU $ - zero ; unused

section .text

start:
  mov r8, 1
  mov r9, 15

  loop:
    mov r10, 0
    mov r11, 0

    cmp_fizz:
      xor rdx, rdx

      mov rax, r8
      mov rcx, 3
      div rcx

      cmp rdx, 0
      je write_fizz

    cmp_buzz:
      xor rdx, rdx

      mov rax, r8
      mov rcx, 5
      div rcx

      cmp rdx, 0
      je write_buzz

    write_num:
      cmp r10, 0 ; if r10 > 0 (was incremented to by either writes)
      jg continue ; break
      mov r11, r8 ; r11 = r8
      mov r10, 0
      write_digit_stack:
        cmp r11, 0 ; if r11 = 0
        je write_digit_stdout ; break

        inc r10

        xor rdx, rdx
        mov rax, r11
        mov rcx, 10
        div rcx ; rax = r11 / 10, rdx = r11 % 10
        mov r11, rax ; r11 = r11 / 10
        push rdx
        jmp write_digit_stack
      write_digit_stdout:
        cmp r10, 0
        je continue

        dec r10

        pop rdx
        mov rax, 4
        mov rbx, 1
        mov rcx, digits
        add rcx, rdx
        mov rdx, 1
        int 0x80
        jmp write_digit_stdout

    continue:
      mov rax, 4
      mov rbx, 1
      mov rcx, lf
      mov rdx, lfsize
      int 0x80

      inc r8
      cmp r8, r9
      jg exit

    jmp loop


write_fizz:
  mov rax, 4
  mov rbx, 1
  mov rcx, fizz
  mov rdx, fizzsize
  int 0x80
  inc r10
  jmp cmp_buzz

write_buzz:
  mov rax, 4
  mov rbx, 1
  mov rcx, buzz
  mov rdx, buzzsize
  int 0x80
  inc r10
  jmp continue

exit:
  mov rax, 1
  mov rbx, 0
  int 0x80

global start
