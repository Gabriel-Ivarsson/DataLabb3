.data
    inBuffer:    .asciz ""
    outBuffer:    .asciz ""
    bufPointer:   .quad   0
    temp:   .quad   0
    temp2:   .quad   0
    maxPOS: .quad 0

.text
.global inImage
.global outImage
.global getInt
.global getText
.global getChar
.global getInPos
.global setInPos
.global printBufferPosition
.global outImage

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
    movq %rdx, bufPointer
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
    movq $inBuffer, %rdi
    call puts
    ret

getInPos:
    movq bufPointer, %rax
    ret

setMaxPos:
    movq $0, %rbx
stpLoop:
    cmpb $0, (%rdi)
    je stpEnd
    movq $inBuffer, %rdi
    incq %rbx
    incq %rdi
    jmp stpLoop
stpEnd:
    movq $0, %rdi
    movq %rbx, maxPOS
    ret


setInPos:
    movq inBuffer, %rdx
    movq $0, %rbx
    call setMaxPos
    cmpq maxPOS, %rsi
    jge reqMaxPos
    cmpq $0, %rsi
    jle reqZero
    jmp spLoop
reqMaxPos:
    movq maxPOS, %rsi
    jmp spLoop
reqZero:
    movq %rdx, bufPointer
    jmp spEnd
spLoop:
    cmpq %rbx, %rsi
    je spEnd
    incq %rbx
    incq %rdx
    jmp spLoop
spEnd:
    movq %rdx, bufPointer
    ret

printBufferPosition:
    movq $bufPointer, %rdi
    call puts
    ret


# out
outImage:
    movq $outBuffer, %rdi
    call puts
    # cleans buffer
    movq $0, outBuffer
    ret
