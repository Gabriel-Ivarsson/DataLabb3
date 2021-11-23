.data
    inBuffer:    .asciz ""
    temp:	.quad	0
    bufferPointer:  .quad   0

.text
.global getInt
.global getText
.global printBuffer

inImage:
    movq $inBuffer, %rdi
    movq stdin, %rdx
    call fgets
    ret

getInt:
    movq bufferPointer, %rdi
    movq $10, %rsi
    cmpq $0, %rdi
    je callInImage
    cmpb $0, (%rdi)
    je callInImage
    jmp startBlank
callInImage:
    call inImage
    movq $inBuffer, %rdi
    movq $0, %rax
    movq $0, %r11 # Teckenvisare
startBlank:
    cmpb $' ', (%rdi)
    jne startPositive
    incq %rdi
    jmp startBlank
startPositive:
    cmpb $'+', (%rdi)
    jne startNegative
    incq %rdi
    jmp number
startNegative:
    cmpb $'-', (%rdi)
    jne number
    movq $1, %r11
    incq %rdi
    jmp number
number:
    cmpb $'0', (%rdi)
    jl NAN
    cmpb $'9', (%rdi)
    jg NAN
    movzbq (%rdi), %r10
    subq $'0', %r10
    imulq $10, %rax
    addq %r10, %rax
    incq %rdi
    jmp number
NAN:
    cmpq $1, %r11
    jne end
    negq %rax
    jmp end
end:
    movq %rdi, bufferPointer
    ret

getText:
    movq bufferPointer, %rdx
    push %rdi
    movq $0, %rax
    cmpq $0, %rdx
    je gtCallImage
    cmpb $0, (%rdx)
gtCallImage:
    call inImage
    movq $inBuffer, %rdx
    pop %rdi
start:
    cmpq $0, %rsi
    je getTextEnd
    cmpb $0, (%rdi)
    je getTextEnd
    cmpb $0, (%rdx)
    je getTextEnd

    mov (%rdx), %ebx
    mov %ebx, (%rdi)  

    addq $1, %rax
    subq $1, %rsi
    incq %rdi
    incq %rdx

    jmp start
getTextEnd:
    movq %rax, %rdi
    call puts
    movq %rdx, bufferPointer
    ret

printBuffer:
    movq $inBuffer, %rdi
    call puts
    ret

printBufferPosition:
    movq $bufferPointer, %rdi
    call puts
    ret
