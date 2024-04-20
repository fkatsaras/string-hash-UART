.global compute_hash
.text

compute_hash:
    // Input: R0 points to the null-terminated input string
    // Output: R1 contains the computed hash value

    mov r1, #0          // Initialize the hash value to zero

.loop:
    ldrb r2, [r0], #1   // Load the next character(byte) from the string
    cmp r2, #0          // Check if it's the null terminator
    beq .done           // If yes, exit the loop

    // Check if it's an uppercase letter
    cmp r2, #'A' // Check ASCII values
    blt .numeric  // Branch less than - (negative flag set in cspr) - Char = Numeric OR special
    cmp r2, #'Z' 
    bgt .lowercase // ASCII value greater than that of Z - Char = Lowercase
	// All checks passed - Char = Uppercase

    // Add the corresponding number for uppercase letters
    sub r2, r2, #'A'  // r2 = index | table[index] = char hash number | To calculate the index (0 to 25), we subtract the ASCII value of 'A' (65) from the character value that is being checked (e.g for K (ASCII : 75) index = 75 -65 = 10th position in table)
	ldr r3, =table // r3 = &table[0] | Point r3 to the start of the table (BASE ADDRESS)
	ldr r2, [r3, r2, LSL #2]  // r2 = table[index] |  Load the checked letter's corresponding number using the table's index | Each entry in table occupies 4 bits (Shift left * 2), so: Effective Address = Base Address (table) + (Index * 4) 
    add r1, r1, r2 // Add value to r1 (Adding to the total hash sum)
    b .loop // Go back to loop to load next char

.lowercase:
    // Subtract the corresponding number for lowercase letters
    cmp r2, #'z'
    bgt .loop // ASCII value greater than that of z - Char = Special - NEXT
    sub r2, r2, #'a' // r2 = index
    ldr r3, =table
    ldr r2, [r3, r2, LSL #2]  // Load the corresponding number | Same logic as above 
    sub r1, r1, r2 // Now subtract
    b .loop // Go back to loop to load next char

.numeric:
    // Add the value of the numeric digit
    cmp r2, #'0' // 
    blt .loop // Special characters are ignored -NEXT Character
    cmp r2, #'9'
    bgt .loop  // More special characters - NEXT
    sub r2, r2, #'0'
    add r1, r1, r2
    b .loop
	

.done:
// // Reduce to a single digit if necessary
//reduce:
//    mov r2, r1          // Copy the hash value to r2
//    cmp r2, #10         // Check if the value is greater than or equal to 10
//    blo .done_reduce    // If not, we are done

    // Sum the digits of the number
//    mov r1, #0          // Reset r1 to zero for the digit sum
//.sum_digits:
//    mov r3, r2, lsr #1  // Divide r2 by 10 (r3 = r2 / 10)
//    add r1, r1, r2, lsr #1  // Add the last digit of r2 to r1
//    and r2, r3, #15     // Extract the last digit of r2
//    cmp r3, #0          // Check if r3 is zero
//    bne .sum_digits     // If not, continue summing digits

//.done_reduce:
//	// Take the absolute value of r1
//	tst r1, r1          // Test if r1 is negative
//	it mi               // Conditionally execute following instruction only if negative
//	rsbmi r1, r1, #0    // If negative, take the absolute value

    // Return the result
    mov r0, r1          // Move the result to r0
    bx lr               // Return from the function

.data
table:
	.word 10, 42, 12, 21, 7, 5, 67, 48, 69, 2, 36, 3, 19, 1, 14, 51, 71, 8, 26, 54, 75, 15, 6, 59, 13, 25
