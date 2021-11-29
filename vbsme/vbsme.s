.text
.globl  vbsme

vbsme:  
	addi	$sp,$sp,-4
	sw		$ra,0($sp)
    li      $v0, 0              
    li      $v1, 0
	add		$t7,$a1,$0	
	add		$t8,$a2,$0	
	lw      $t0, 0($a0)              #asize[0]
    lw      $t1, 4($a0)              #asize[1]
    lw      $t2, 8($a0)              #asize[2]
    lw      $t3, 12($a0)             #asize[3]
	# Get Final Location
    sub		$s3, $t0, $t2    #final x            
    sub		$s4, $t1, $t3    #final y
	sll		$t9, $t0, 2		
	jal 	SAD
	add		$s0,$v0,$0	#minSAD
	add		$s6,$0,$0	#minX
	add		$s7,$0,$0	#minY
	
	add		$s1,$0,$0	#current X
	add		$s2,$0,$0	#current Y
vbsmeLoop:
	slt	$t0,$s1,$s4	
	slt	$t1,$s2,$s3 
	add	$t0,$t0,$t1 
	beq	$t0,$0,vbsmeEnd 
	
	add	$a1,$s1,$0
	add	$a2,$s2,$0
	jal	moveWindow
	
	add	$s1,$s1,$v0
	add	$s2,$s2,$v1
	sll	$v0,$v0,2
	add	$t7,$t7,$v0
	beq	$v1,$0,zeroY
	slt	$v1,$v1,$0	
	bne	$v1,$0,negY
	add	$t7,$t7,$t9 
	j	zeroY
negY:
	sub	$t7,$t7,$t9
zeroY:
	add	$a1,$t7,$0
	add	$a2,$t8,$0
	jal SAD
	
	slt	$t0,$s0,$v0  # if the new SAD value is the minimum
	bne	$t0,$0,notMin 
	add	$s0,$v0,$0 # set minSAD to the new value
	add	$s6,$s1,$0 # set minX to the current X value
	add	$s7,$s2,$0 # set minY to the current Y value
notMin:
	j	vbsmeLoop
vbsmeEnd:
	add		$v1,$s6,$0 # set the results to minX and minY
	add		$v0,$s7,$0
	lw		$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra

SAD:
	addi	$v0,$0,0	# v0 = 0 to keep track of the current sum
	lw		$t1,4($a0)	
	lw		$t2,8($a0)	
	lw		$t3,12($a0)	
	addi	$t4,$0,0	
SADRowLoop:
	addi	$t5,$0,0	
SADColLoop:
	sll		$t0,$t5,2	
	add		$t6,$t0,$a1	
	lw		$t6,0($t6)	
	add		$t0,$t0,$a2	
	lw		$t0,0($t0)	
	sub		$t0,$t6,$t0	
	slt		$t6,$t0,$0	
	beq		$t6,$0,skipAbs 
	sub		$t0,$0,$t0	
skipAbs:
	add		$v0,$v0,$t0	
	addi	$t5,$t5,1	
	slt		$t6,$t5,$t3 
	bne		$t6,$0,SADColLoop 
	sll		$t0,$t1,2	
	add		$a1,$a1,$t0 
	sll		$t0,$t3,2	
	add		$a2,$a2,$t0 
	addi	$t4,$t4,1	
	slt		$t6,$t4,$t2	
	bne		$t6,$0,SADRowLoop 
	jr		$ra			# Return v0
	
	

moveWindow:
	slt $t0, $s1, $s3
	beq $t0, $0, moveRight
	
moveDown:
   addi $v1, $0, 1 
   add	$v0, $0, $0  
   jr   $ra 
   
moveRight:
   addi $v0, $0, 1
   add	$v1, $0, $0 
   jr   $ra                        

                     