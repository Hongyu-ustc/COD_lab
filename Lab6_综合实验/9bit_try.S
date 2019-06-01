
.text
j _start      

.data
    .word 0,0x0000e000,0x00008000,0x00004000,0x00002000,0,0x00001000,0x0000000f,0x000000f0,0x00000f00,0,0,0x0000f000,0x00009000,0x00005000,0x00003000
        #1024 up1028    down1032  left1036  rignt1040  1044 1048           1052     1056        1060 1064 1068 1072     1076     1080            1084
.text
_start:                    #初始化
        lw $t0,1044($0)    #t0=0 count
        lw $t1,1048($0)    #t1=0x00001000 通过加减控制we位
        lw $t2,1052($0)    #t2=0x0000000f
        lw $t3,1056($0)    #t3=0x000000f0
        lw $t4,1060($0)    #t4=0x00000f00
        lw $t5,1064($0)    #t5=0 
        addi $t5,$t5,48    #t5=48 for _task1
        j _task1
.text
_task1:
        lw $s1,1036($0)    #left without we
        sw $s1,1068($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run1
        lw $t0,1044($0)    #count=0
        lw $t5,1064($0)    #t5=0 
        addi $t5,$t5,15    #t5=15 for _task2
        j _task2
.text
_task2:
        lw $s1,1028($0)    #up without we
        sw $s1,1068($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run2
        lw $t0,1044($0)    #count=0
        lw $t5,1064($0)    #t5=0 
        addi $t5,$t5,30    #t5=30 for _task3
        j _task3
.text
_task3:
        lw $s1,1076($0)    #down + we
        sw $s1,1068($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run3
        lw $t0,1044($0)    #count=0
        lw $t5,1064($0)    #t5=0 
        addi $t5,$t5,20    #t5=20 for _task4
        j _task4
.text
_task4:
        lw $s1,1084($0)    #rignt + we
        sw $s1,1068($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run4
        lw $t0,1044($0)    #count=0
        lw $t5,1064($0)    #t5=0 
        addi $t5,$t5,30    #t5=30 for _task5
        j _task5
.text
_task5:
        lw $s1,1072($0)    #up + we
        sw $s1,1068($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run5
        j _end
.text
_end:
        j _end
.text
_run1:
        j _task1
.text
_run2:
        j _task2
.text
_run3:
        j _task3
.text
_run4:
        j _task4
.text
_run5:
        j _task5