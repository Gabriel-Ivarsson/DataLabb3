.data
    buf:    .space 64
    zero:   .asciz "Is zero\n"
    one:    .asciz "is one\n"

.global main
.text
main:
    leaq buf, %r13
    movq $101111, %r12
    call printEachDigit

printEachDigit:
    movq $0, %rdx ; Första registret till täljaren, behövs ej får våra tal storlekar
    movq %r12, %rax ; Täljare
    movq $10, %r14 ; divider
    divq %r14 ; division
    movq %rax, %r12 ; Nya talet som är 10 ggr mindre (e.g., 200 -> 20)
    movq %rdx, (%r13) ; Vad jag tror lägger in i bufferten, not sure
    incq %r13
    cmpq $0, %rax ; Kollar om vi är nere på sista tecknet än
    je end
    cmpq $0, %rdx ; kollar om tecknet vi är på är noll
    je isZero
    cmpq $1, %rdx ; kollar om tecknet vi är på är ett
    je isOne
    jmp printEachDigit
isZero:
    movq $zero, %rdi
    call puts
    jmp printEachDigit
endisZero:
    movq $zero, %rdi
    call puts
    ret
isOne:
    movq $one, %rdi
    call puts
    jmp printEachDigit
endisOne:
    movq $one, %rdi
    call puts
    ret
end:
    cmpq $0, %rdx
    je endisZero
    cmpq $1, %rdx
    je endisOne
