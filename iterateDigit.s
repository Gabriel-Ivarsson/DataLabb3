.data
    buf:    .space 64
    numOfDigits:    .quad 0
    temp:   .space 64
    num:    .quad 0

.global main
.text
main:
    leaq buf, %r13
    leaq temp, %r15
    movq $10112, %rdi
    movq %rdi, num
    movq num, %r12
    call printEachDigit
    movq $numOfDigits, %rsi

printEachDigit:
    movq $0, %rdx
    movq %r12, %rax 
    movq $10, %r14
    divq %r14
    movq %rax, %r12 
    addq $'0', %rdx
    movq %rdx, (%r13)
    movq %rdx, (%r15)
    incq %r13
    incq %r15
    addq $1, %rsi
    movq %rsi, numOfDigits
    cmpq $0, %rax 
    je transfer2Buf1
    jmp printEachDigit
transfer2Buf1:
    movq $'\0', (%r13)
    movq $'\0', (%r15)
    leaq buf, %r13
    movq $7, %rsi
    decq %r15
    jmp transfer2Buf2
transfer2Buf2:
    mov (%r15), %edx
    mov %edx, (%r13)
    incq %r13
    decq %r15
    subq $1, %rsi
    cmpq $0, %rsi
    jg transfer2Buf2
    jmp end
end:
    movq $buf, %rdi
    call puts
    ret

