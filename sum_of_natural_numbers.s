.global sum_n

sum_n:
	.fnstart
    mov r4, r0          // Move n into r4

    // Calculate the sum
    mov r1, r4          // Move n into r1
    add r1, #1          // Add 1 to n
    mul r4, r1          // Multiply n by (n+1) - n*(n + 1)
	lsr r4, r4, #1		// LSR r4, divide by 2 - n*(n-1)/2

    // Return the result
    mov r0, r4          // Move the result to r0

    // Function epilogue
    bx lr
	.fnend

