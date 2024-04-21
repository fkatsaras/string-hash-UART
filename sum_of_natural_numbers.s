.global sum_n
.text

sum_n:
// Input r0 :  hash string 
// Output r0: Natural sum of single digit value from hash string

    // Initialize r1 to 0
	mov r1, #0
	
loop:
	// Check if the input is single digit
	cmp r0, #10
	blt done
	
	// Extract next digit - divide by 10 - Divident is in r0
	mov r2, #10 // Load divisor (10) into r3
	mov r3, #0 // Initialize remainder (r2) to 0
	udiv r1, r0, r2 // Perform unsigned division and store quotient in r1
	// Find remainder
	mul r4, r1, r2 // Quotient * Divisor
	sub r5, r0, r4 // Remainder = Divident - Quotient * Divisor
	
	add r0, r1, r5 // Input is now Quotient + Remainder
	
	b loop // Loop again until input is single digit
	
done:
    // The sum of digits is now in r1
    // Calculate the natural sum of the single digit result
    mov r4, r0          // Move n into r4

    // Calculate the sum
    mov r1, r4          // Move n into r1
    add r1, #1          // Add 1 to n
    mul r4, r1          // Multiply n by (n+1) - n*(n + 1)
	lsr r4, r4, #1		// LSR r4, divide by 2 - n*(n + 1)/2

    // Return the result
    mov r0, r4          // Move the result to r0

    // Function epilogue
    bx lr

