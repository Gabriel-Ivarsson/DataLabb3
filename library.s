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
    
