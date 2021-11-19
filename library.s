.data
    buffert:    .asciz ""

.text
.global inImage
.global getInt

inImage:
    movq stdin, %rdx
    call fgets
    ret

getInt:
    movq $buffert, %rdi
    movq $10, %rsi

    cmpb $'0', (%rdi)
    jl inImage
    cmpb $'9', (%rdi)
    jg inImage

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
    movq %rax, %rdi
    call atoi
    ret

