
.text
j _start      

.data
    .word 0,0x0000e000,0x00008000,0x00004000,0x00002000,0,0x00001000,0x0000000f,0x000000f0,0x00000f00,10,0
        #up,down,left,right
.text
_start:
        lw $t0,24($0)   #t0=0 count
        lw $t1,28($0)    #t1=0x00001000 通过加减控制we位
        lw $t2,32($0)    #t2=0x0000000f
        lw $t3,36($0)    #t3=0x000000f0
        lw $t4,40($0)    #t4=0x00000f00
        lw $t5,44($0)    #t5=10 
        j _task1
.text
_task1:
        lw $s1,8($0)    #up without we
        sw $s1,48($0)
        addi $t0,$t0,1   #count++
        bne $t0,$t5,_run1
        lw $t0,24($0)     #count=0
        lw $s1,12($0)    #down without we
        add $s1,$s1,$t1  #we
        j _task2
.text
_task2: 
        sw $s1,48($0)
        addi $t0,$t0,1   #count++
        bne $t0,$t5,_run2
        j _end
.text
_end:
        j _end
_run1:
        j _task1
_run2:
        j _task2
