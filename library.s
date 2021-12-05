.data
    empty: .asciz ""
    inBuffer:    .space 64
    outBuffer:    .space 64
    tempBuf:    .space 64
    bufPointer:   .quad   0
    outBufPointer: .quad   0
    outBufPosition:   .quad   0
    bufPosition:   .quad   0
    temp:   .quad   0
    temp2:   .quad   0
    maxPOS: .quad 0

.text
.global inImage
.global outImage
.global getInt
.global getText
.global getChar
.global setInPos
.global setOutPos
.global printBufferPosition
.global printOutBufferPosition
.global printBuffer
.global outImage
.global putInt
.global putText
.global printOutBuffer
.global putChar
.global getOutPos
.global getInPos
.global getOutBufPtr
.global getOutBuf

inImage:
    movq $64, %rsi
    movq $inBuffer, %rdi
    movq stdin, %rdx
    call fgets
    movq $inBuffer, bufPointer
    ret

getInt:
    movq $inBuffer, %rdi
    cmpq $0, (%rdi)
    je callInImage
    call getInPos #; get in pos gay
    cmpq $64, %rax
    je callInImage
    movq bufPointer, %rdi
    movq $0, %rax
    movq $0, %r11
    jmp startBlank
callInImage:
    call inImage
    movq $inBuffer, %rdi
    movq $0, %rax
    movq $0, %r11 # Teckenvisare
    jmp startBlank
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
    movq %rdi, bufPointer
    ret

getText:
    movq $inBuffer, %rdx
    cmpq $0, (%rdx)
    je gtCallImage
    call getInPos
    cmpq $63, %rax
    je gtCallImage
    movq bufPointer, %rdx
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
    movq $inBuffer, %rdi
    cmpq $0, (%rdi)
    je gcCallImage
    call getInPos
    cmpq $63, %rax
    je gcCallImage
    movq bufPointer, %rdi
    jmp getCharEnd
gcCallImage:
    movq $64, %rsi
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
    pushq %r13
    pushq %r14
    movq bufPointer, %r13
    movq $inBuffer, %r14
    cmpq $0, (%r14)
    je gipEnd
    movq $0, %rax
    jmp gipLoop
gipLoop:
    cmpq %r14, %r13
    je gipEnd
    incq %rax
    incq %r14
    jne gipLoop
gipEnd:
    pop %r13
    pop %r14
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
    cmpq $63, %rdi
    jge reqMaxPos
    jmp spLoopStart
reqMaxPos:
    movq $63, %rdi
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
    movq $0, outBufPointer
    ret

putInt:
    movq %rdi, %r9
    movq $outBufPointer, %r10
    movq $tempBuf, %r15
    movb $0, (%r15)
    incq %r15
    call getOutPos
    cmpq $63, %rax
    je ptCallImage
    jmp to_string
ptCallImage:
    call outImage
    movq $outBuffer, %r10
    jmp to_string
to_string:
    movq $0, %rdx
    movq %r9, %rax
    movq $10, %r14
    divq %r14
    movq %rax, %r9
    addq $'0', %rdx
    movq %rdx, (%r15)
    incq %r10
    incq %r15
    cmpq $0, %rax
    je transfer2Buf1
    jmp to_string
transfer2Buf1:
    movq $outBuffer, %r10
    decq %r15
    jmp transfer2Buf2
transfer2Buf2:
    mov (%r15), %edx
    mov %edx, (%r10)
    incq %r10
    decq %r15
    cmpb $0, (%r15)
    jne transfer2Buf2
    jmp ptEnd
ptEnd:
    movb $0, (%r10)
    movq %r10, outBufPointer
    ret

printOutBuffer:
    movq $outBuffer, %rdi
    call puts
    ret

putText:
    movq $outBuffer, %rdx
    cmpb $0, (%rdx)
    je startPt
    movq outBufPointer, %rdx
    call getOutPos
    cmpq $63, %rax
    je ptCallOutImage
    jmp startPt
ptCallOutImage:
    movq %rdi, temp2
    call outImage
    movq temp2, %rdi
    movq $outBuffer, %rdx
startPt:
    movq %rdx, outBufPointer # intialize pointer attempt
    movq %rdx, %rsi
    jmp putTextLoop
putTextLoop:
    mov (%rdi), %edx
    mov %edx, (%rsi)
    incq %rsi
    incq %rdi
    cmpb $0, (%rdi)
    je putTextEnd
    jmp putTextLoop
putTextEnd:
    movq %rsi, outBufPointer
    ret
putTextEndOutImage:
    movq %rsi, outBufPointer
    call outImage
    ret

putChar:
    movq outBufPointer, %rsi
    pushq %rdi
    movq $outBuffer, %rdi
    cmpq $0, (%rdi)
    je setPointer
    call getOutPos
    cmpq $63, %rax
    je pcImage
pcImage:
    call outImage
    leaq outBuffer, %rsi
    jmp pcContinued
setPointer: # intialize pointer attempt
    movq %rdi, outBufPointer
    movq outBufPointer, %rsi
pcContinued:
    popq %rdi
    movq %rdi, (%rsi)
    incq %rsi
    movq %rsi, outBufPointer
    ret

getOutPos:
    movq outBufPointer, %r13
    movq $outBuffer, %r14
    movq $0, %rax
    cmpq $0, (%r14)
    je gopEnd
    jmp gopLoop
gopLoop:
    cmpq %r14, %r13
    je gopEnd
    incq %rax
    decq %r13
    jmp gopLoop
gopEnd:
    ret

setOutPos:
    movq $outBuffer, %r10
    cmpq $0, %rdi
    jle outReqZero
    cmpq $63, %rdi
    jge outReqMaxPos
    jmp outSpLoopStart
outReqMaxPos:
    movq $63, %rdi
    jmp outSpLoopStart
outReqZero:
    movq $0, %rcx
    jmp outSpEnd
outSpLoopStart:
    movq $outBuffer, %r10
    movq $0, %rcx
outSpLoop:
    cmpq %rcx, %rdi
    je outSpEnd
    incq %rcx
    incq %r10
    jmp outSpLoop
outSpEnd:
    addq $'0', %rcx
    movq %rcx, outBufPosition
    movq %r10, outBufPointer
    ret

printOutBufferPosition:
    movq $outBufPosition, %rdi
    call puts
    ret

getOutBufPtr:
    movq outBufPointer, %rax
    ret
getOutBuf:
    movq $outBuffer, %rax
    ret
