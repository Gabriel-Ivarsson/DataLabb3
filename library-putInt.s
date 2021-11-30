.data
    inBuffer:    .space 64
    outBuffer:    .space 64
    bufPointer:   .quad   0
    outBufPointer: .quad   0
    bufPosition:   .quad   0
    temp:   .quad   0
    temp2:   .quad   0
    maxPOS: .quad 0

.text
.global outImage
.global putInt

#; out
outImage:
    movq $outBuffer, %rdi
    call puts
    #; cleans buffer
    movq $0, outBuffer
    ret

#; Denna funkar just nu bara med en siffra behöver mer arbete
putInt:
    movq %rdi, %rax
    movq $0, %rcx #; current char counter
    movq $10, %rdi
stringLoop:
    movq $0, %rdx
    divq %rdi #; divide by 10
    #; rdx har remainder från divisionen
    addq $'0', %rdx
    pushq %rdx
    incq %rcx

    cmpq $0, %rax
    je startPopChars
    jmp stringLoop
startPopChars:
    movq $outBuffer, %rdx
popChars:
    popq %rax
    movb %al, (%rdx)
    decq %rcx
    incq %rdx
    cmpq $0, %rcx
    je callOutimage
    jmp popChars
callOutimage:
    movb $0, (%rdx)
    movq %rdx, outBuffer
    call outImage
    ret
