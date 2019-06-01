
.text
j _start      

.data
    .word 0,0x0000e000,0x00008000,0x00004000,0x00002000,0,0x00001000,0x0000000f,0x000000f0,0x00000f00,0,0,0x0000f000,0x00009000,0x00005000,0x00003000
        #960 up 964    down 968  left 972 rignt 976  980      984       988      992         996 1000 1004 1008     1012        1016         1020
.text
_start:                    #初始化
        lw $t0,980($0)    #t0=0 count
        lw $t1,984($0)    #t1=0x00001000 通过加减控制we位
        lw $t2,988($0)    #t2=0x0000000f
        lw $t3,992($0)    #t3=0x000000f0
        lw $t4,996($0)    #t4=0x00000f00
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,24    #t5=24 for _task1
        j _task1
.text
_task1:
        lw $s1,972($0)    #left without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run1
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,8    #t5=8 for _task2
        j _task2
.text
_task2:
        lw $s1,964($0)    #up without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run2
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,15    #t5=15 for _task3
        j _task3
.text
_task3:
        lw $s1,1012($0)    #down + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run3
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,10    #t5=10 for _task4
        j _task4
.text
_task4:
        lw $s1,1020($0)    #rignt + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run4
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,15    #t5=15 for _task5
        j _task5
.text
_task5:
        lw $s1,1008($0)    #up + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run5
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,14    #t5=14 for _task6
        j _task6
.text
_task6:
        lw $s1,976($0)    #right without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run6
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,10    #t5=10 for _task7
        j _task7
.text
_task7:
        lw $s1,1016($0)    #left + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run7
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,8    #t5=8 for _task8
        j _task8
.text
_task8:
        lw $s1,1012($0)    #down + we                                         
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++   
        bne $t0,$t5,_run8                                         
        lw $t0,980($0)    #count=0                                                      
        lw $t5,1000($0)    #t5=0                                                             
        addi $t5,$t5,10    #t5=10 for _task9                                                 
        j _task9 
.text               
_task9:         
        lw $s1,1020($0)    #rignt + we 
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run9
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,7    #t5=7 for _task10
        j _task10
.text
_task10:
        lw $s1,1012($0)    #down + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run10
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,10    #t5=10 for _task11
        j _task11
.text
_task11:
        lw $s1,1016($0)    #left + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run11
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,19    #t5=19 for _task12
        j _task12
.text
_task12:
        lw $s1,976($0)    #right without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run12
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,15    #t5=15 for _task13
        j _task13
.text
_task13:
        lw $s1,1008($0)    #up + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run13
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,5    #t5=5 for _task14
        j _task14
.text
_task14:
        lw $s1,972($0)    #left without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run14
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,10    #t5=10 for _task15
        j _task15
.text
_task15:
        lw $s1,1020($0)    #rignt + we 
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run15
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,14    #t5=14 for _task16
        j _task16
.text
_task16:
        lw $s1,976($0)    #right without we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run16
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,9    #t5=9 for _task17
        j _task17
.text
_task17:
        lw $s1,1016($0)    #left + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run17
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,15    #t5=15 for _task18
        j _task18
.text
_task18:
        lw $s1,1012($0)    #down + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run18
        lw $t0,980($0)    #count=0
        lw $t5,1000($0)    #t5=0 
        addi $t5,$t5,9    #t5=9 for _task19
        j _task19
.text
_task19:
        lw $s1,1020($0)    #rignt + we
        sw $s1,1004($0)
        addi $t0,$t0,1     #count++
        bne $t0,$t5,_run19
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
.text
_run6:
        j _task6
.text
_run7:
        j _task7
.text
_run8:
        j _task8
.text
_run9:
        j _task9
.text
_run10:
        j _task10
.text
_run11:
        j _task11
.text
_run12:
        j _task12
.text
_run13:
        j _task13
.text
_run14:
        j _task14
.text
_run15:
        j _task15
.text
_run16:
        j _task16
.text
_run17:
        j _task17
.text
_run18:
        j _task18
.text
_run19:
        j _task19
