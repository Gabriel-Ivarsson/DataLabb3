.data
    buffert:    .asciz ""

.text
.global inImage
.global getInt

inImage:
    movq stdin, %rdx
    call fgets
    ret
<<<<<<< HEAD

getInt:
    
=======
>>>>>>> 21d0a4d610d31b60c7ae77b317a51c2c7f20da10
