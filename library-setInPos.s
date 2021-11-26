.data
    inBuffer:    .asciz ""
    bufPointer:   .quad   0
    bufPosition:   .quad   0
    temp:   .quad   0
    temp2:   .quad   0
    maxPOS: .quad 0

.text
.global getInt
.global getText
.global getChar
.global setInPos
.global printBufferPosition
.global printBuffer
.global setMaxPos10

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
    movq $inBuffer, %rdx
    cmpb $0, (%rdx)
    je gtCallImage
    movq bufPointer, %rdx
    cmpb $0, (%rdx)
    je gtCallImage
    jmp gtStart
gtCallImage:
    movq %rdi, temp2
    addq $1, %rsi
    movq %rsi, temp
    movq $inBuffer, %rdi
    call inImage
    movq $inBuffer, %rdx
    movq temp2, %rdi
    movq temp, %rsi
gtStart:
    movq $0, %rax
textLoop:
    mov (%rdx), %ebx
    mov %ebx, (%rdi)

    addq $1, %rax
    subq $1, %rsi
    incq %rdi
    incq %rdx

    cmpq $0, %rsi
    je getTextEnd
    cmpb $0, (%rdx)
    je getTextEnd
    cmpb $0, (%rdi)
    je getTextEnd

    jmp textLoop
getTextEnd:
    movq %rdi, bufPointer
    ret

getChar:
    movq bufPointer, %rdi
    cmpq $0, %rdi
    je gcCallImage
    cmpb $0, (%rdi)
    je callInImage
    jmp getCharEnd
gcCallImage:
    movq $12, %rsi
    movq $inBuffer, %rdi
    call inImage
    movq $inBuffer, %rdi
getCharEnd:
    mov (%rdi), %eax
    incq %rdi
    movq %rdi, bufPointer
    ret

printBuffer:
    movq $bufPointer, %rdi
    call puts
    ret

getInPos:
    movq $bufPointer, %rax
    ret

setMaxPos:
    movq $inBuffer, %r10
    movq $0, %rcx
stpLoop:
    cmpb $0, (%r10)
    je stpEnd
    addq $1, %rcx
    incq %r10
    jmp stpLoop
stpEnd:
    movq %rcx, maxPOS
    movq $0, %rcx
    ret

setInPos:
    movq $inBuffer, %r10
    cmpq $0, %rdi
    jle reqZero
    call setMaxPos
    cmpq maxPOS, %rdi
    jge reqMaxPos
    jmp spLoopStart
reqMaxPos:
    movq maxPOS, %rdi
    jmp spLoopStart
reqZero:
    movq $0, %rcx
    jmp spEnd
spLoopStart:
    movq $inBuffer, %r10
    movq $0, %rcx
spLoop:
    cmpq %rcx, %rdi
    je spEnd
    addq $1, %rcx
    incq %r10
    jmp spLoop
spEnd:
    addq $'0', %rcx
    movq %rcx, bufPosition
    movq %r10, bufPointer
    ret

printBufferPosition:
    movq $bufPosition, %rdi
    call puts
    ret


