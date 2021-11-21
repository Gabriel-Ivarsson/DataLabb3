.data
    inBuffer:    .asciz ""
    temp:	.quad	0

.text
.global getInt
resetImage:
    movq $' ', inBuffer
    ret
inImage: 
    movq stdin, %rdx
    call fgets
    ret

getInt:
    movq $inBuffer, %rdi
    movq $10, %rsi
    cmpq $0, (%rdi)
    je callInImage
    cmpb $'\0', (%rdi)
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
    ret

getText:
    movq %rsi, temp
    movq inBuffer, %rdx
start:
    cmpq $0, %rsi
    je getTextEnd
    jl getTextEnd
    subq $1, %rsi
    movb (%rdi), (%rdx)
    incq (%rdi)
    incq (%rdx)
getTextEnd:
    subq %rsi, temp
    movq temp, %rax
    ret
