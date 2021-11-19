.data
buf: .asciz "xxxx"

.text
.global someCode
  someCode:
    movq $buf, %rdi
    movq $5, %rsi
    movq stdin,%rdx
    call fgets
    movq $buf, %rdi
    call puts
    movq $buf, %rax
    ret
