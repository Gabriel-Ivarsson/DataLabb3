.text
.global inImage

inImage:
    movq stdin, %rdx
    call fgets
    ret
