.data
    inBuffer:    .asciz ""
    bufPointer:   .quad   0

.text
.global getInt
.global getText
inImage:
    movq $inBuffer, %rdi
    movq stdin, %rdx
    call fgets
    ret
getInt:
    movq $inBuffer, %rdi
    cmpb $0, (%rdi)
    je callInImage
    movq bufPointer, %rdi
    cmpb $0, (%rdi)
    je callInImage
    jmp startBlank
callInImage:
    movq $12, %rsi
    movq $inBuffer, %rdi
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
    incq %rdi
    movq %rdi, bufPointer
    ret

getText:
    movq $0, %rax
    movq $inBuffer, %rdx
    cmpb $0, (%rdx)
    je gtCallImage
    movq bufPointer, %rdx
    cmpb $0, (%rdx)
    je gtCallImage
gtCallImage:
    push %rdi
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
    movq %rdx, bufPointer
    ret

printBuffer:
    movq $inBuffer, %rdi
    call puts
    ret

printBufferPosition:
    movq $bufPointer, %rdi
    call puts
    ret
