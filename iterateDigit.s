.data
    buf:    .space 64
    zero:   .asciz "Is zero\n"
    one:    .asciz "is one\n"
    temp:   .space 64

.global main
.text
main:
    leaq buf, %r13
    movq $101111, %r12
    call printEachDigit
    movq $0, %rsi

printEachDigit:
    movq $0, %rdx
    movq %r12, %rax 
    movq $10, %r14
    divq %r14 
    movq %rax, %r12 
    addq $'0', %rdx
    movq %rdx, (%r13)
    incq %rsi 
    incq %r13
    cmpq $0, %rax 
    je end
    jmp printEachDigit
end:
    movb $0, (%r13)
    movq $buf, %rdi
    call puts
    ret

