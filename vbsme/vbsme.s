.text
.globl  vbsme

vbsme:  
	addi	$sp,$sp,-4
	nop
	
    li      $v0, 0   
    sw		$ra,0($sp)
	
    li      $v1, 0
	nop
	
	add		$t7,$a1,$0	
	lw      $t0, 0($a0)              #asize[0]
	
	add		$t8,$a2,$0	
	lw      $t2, 8($a0)              #asize[2]
	
	sub		$s3, $t0, $t2    #final x  
    lw      $t1, 4($a0)              #asize[1]
	
	sll		$t9, $t0, 2		
    lw      $t3, 12($a0)             #asize[3]
	
    sub		$s4, $t1, $t3    #final y
	nop
	
	jal 	SAD
	nop
	
	add		$s0,$v0,$0	#minSAD
	nop
	
	add		$s6,$0,$0	#minX
	nop
	
	add		$s7,$0,$0	#minY
	nop
	
	add		$s1,$0,$0	#current X
	nop
	
	add		$s2,$0,$0	#current Y
	nop
vbsmeLoop:
	slt	$t0,$s1,$s4	
	nop
	
	slt	$t1,$s2,$s3 
	nop
	
	add	$t0,$t0,$t1 
	nop
	
	beq	$t0,$0,vbsmeEnd 
	nop
	
	add	$a1,$s1,$0
	nop
	
	add	$a2,$s2,$0
	nop
	
	jal	moveWindow
	nop
	
	add	$s1,$s1,$v0
	nop
	
	add	$s2,$s2,$v1
	nop
	
	sll	$v0,$v0,2
	nop
	
	add	$t7,$t7,$v0
	nop
	
	beq	$v1,$0,zeroY
	nop
	
	slt	$v1,$v1,$0	
	nop
	
	bne	$v1,$0,negY
	nop
	
	add	$t7,$t7,$t9 
	nop
	
	j	zeroY
	nop
negY:
	sub	$t7,$t7,$t9
	nop
zeroY:
	add	$a1,$t7,$0
	nop
	
	add	$a2,$t8,$0
	nop
	
	jal SAD
	nop
	
	slt	$t0,$s0,$v0  # if the new SAD value is the minimum
	nop
	
	bne	$t0,$0,notMin 
	nop
	
	add	$s0,$v0,$0 # set minSAD to the new value
	nop
	
	add	$s6,$s1,$0 # set minX to the current X value
	nop
	
	add	$s7,$s2,$0 # set minY to the current Y value
	nop
notMin:

	j	vbsmeLoop
	nop
	
vbsmeEnd:
	add		$v1,$s6,$0 # set the results to minX and minY
	nop
	
	add		$v0,$s7,$0
	lw		$ra,0($sp)
	
	addi	$sp,$sp,4
	nop
	
	jr	$ra
	nop
SAD:
	addi	$v0,$0,0	# v0 = 0 to keep track of the current sum
	lw		$t1,4($a0)	
	
	addi	$t4,$0,0
	lw		$t2,8($a0)	
	
	nop
	lw		$t3,12($a0)	
	
SADRowLoop:

	addi	$t5,$0,0
	nop
	
SADColLoop:

	sll		$t0,$t5,2	
	nop
	
	add		$t6,$t0,$a1	
		
	add		$t0,$t0,$a2	
	lw		$t6,0($t6)
	
	nop
	lw		$t0,0($t0)	
	
	sub		$t0,$t6,$t0	
	nop
	
	slt		$t6,$t0,$0	
	nop
	
	beq		$t6,$0,skipAbs 
	nop
	
	sub		$t0,$0,$t0	
	nop
	
skipAbs:
	add		$v0,$v0,$t0	
	nop
	
	addi	$t5,$t5,1	
	nop
	
	slt		$t6,$t5,$t3 
	nop
	
	bne		$t6,$0,SADColLoop 
	nop
	
	sll		$t0,$t1,2	
	nop
	
	add		$a1,$a1,$t0 
	nop
	
	sll		$t0,$t3,2	
	nop
	
	add		$a2,$a2,$t0 
	nop
	
	addi	$t4,$t4,1	
	nop
	
	slt		$t6,$t4,$t2	
	nop
	
	bne		$t6,$0,SADRowLoop 
	nop
	
	jr		$ra			# Return v0
	nop
	

moveWindow:

	slt $t0, $s1, $s3
	nop
	
	beq $t0, $0, moveRight
	nop
	
moveDown:

   addi $v1, $0, 1 
   nop
   
   add	$v0, $0, $0 
   nop
   
   jr   $ra 
   nop
   
moveRight:

   addi $v0, $0, 1
   nop
   
   add	$v1, $0, $0 
   nop
   
   jr   $ra                        
   nop
                     