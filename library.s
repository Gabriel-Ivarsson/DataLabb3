.data
    inBuffer:    .space 64
    outBuffer:    .space 64
    tempBuf:    .space 64
    bufPointer:   .quad   0
    outBufPointer: .quad   0
    bufPosition:   .quad   0
    temp:   .quad   0
    temp2:   .quad   0
    maxPOS: .quad 0
    numOfDigits:    .quad 0

.text
.global inImage
.global outImage
.global getInt
.global getText
.global getChar
.global setInPos
.global printBufferPosition
.global printBuffer
.global outImage
.global putInt
.global printOutBuffer

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
    movq bufPointer, %rdi
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
    incq %rcx
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
    incq %rcx
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




# out
outImage:
    movq $outBuffer, %rdi
    call puts
    # cleans buffer
    movq $0, outBuffer
    ret

putInt:
    movq %rdi, %r12
    movq $numOfDigits, %rsi
    leaq outBufPointer, %r13
    leaq tempBuf, %r15
    movb $'\0', (%r15)
    incq %r15
    cmpq $0, %r13
    je ptCallImage
    cmpb $0, (%r13)
    je ptCallImage
    jmp to_string
ptCallImage:
    call outImage
    leaq outBuffer, %r13
    jmp to_string
to_string:
    movq $0, %rdx
    movq %r12, %rax
    movq $10, %r14
    divq %r14
    movq %rax, %r12
    addq $'0', %rdx
    movq %rdx, (%r15)
    incq %r13
    incq %r15
    addq $1, %rsi
    movq %rsi, numOfDigits
    cmpq $0, %rax
    je transfer2Buf1
    jmp to_string
transfer2Buf1:
    leaq outBuffer, %r13
    decq %r15
    jmp transfer2Buf2
transfer2Buf2:
    mov (%r15), %edx
    mov %edx, (%r13)
    incq %r13
    decq %r15
    cmpb $0, (%r15)
    jne transfer2Buf2
    jmp ptEnd
ptEnd:
    decq %r13
    movb $0, (%r13)
    ret

printOutBuffer:
    movq $outBuffer, %rdi
    call puts
    ret
