.data
buf: .asciz "xxxx"

.text
.global main
  someCode:
    movq $buf, %rdi
    movq $20, %rsi
    movq stdin,%rdx
    call fgets
    movq $buf, %rdi
    call puts
    movq $buf, %rax
    ret

main:
  call someCode
  ret
