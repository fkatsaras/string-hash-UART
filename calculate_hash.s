.data
    str:    .asciz ""  // Replace with your input string
    hash:   .word 0                    // Initialize the hash to 0

.text
.global _start

_start:
    ldr r0, =str        // Load the address of the string
    ldr r1, =hash       // Load the address of the hash
    bl calculate_hash   // Call the hash calculation function

    // Exit the program
    mov r7, #1          // Exit syscall
    swi 0

calculate_hash:
    // Initialize registers
    mov r2, #0          // Initialize the hash accumulator
    mov r3, #0          // Initialize the character index

hash_loop:
    ldrb r4, [r0, r3]   // Load the next character from the string
    cmp r4, #0          // Check if it's the null terminator (end of string)
    beq hash_done       // If yes, exit the loop

    // Check if the character is an uppercase letter
    cmp r4, #'A'
    blt lowercase_check
    cmp r4, #'Z'
    bgt lowercase_check

    // Add the corresponding number to the hash
    sub r4, r4, #'A'    // Convert to index (A=0, B=1, ..., Z=25)
    add r2, r2, r4      // Add to the hash

lowercase_check:
    // Check if the character is a lowercase letter
    cmp r4, #'a'
    blt numeric_check
    cmp r4, #'z'
    bgt numeric_check

    // Subtract the corresponding number from the hash
    sub r4, r4, #'a'    // Convert to index (a=0, b=1, ..., z=25)
    sub r2, r2, r4      // Subtract from the hash

numeric_check:
    // Check if the character is a numeric digit
    cmp r4, #'0'
    blt next_char
    cmp r4, #'9'
    bgt next_char

    // Add the numeric value to the hash
    sub r4, r4, #'0'    // Convert to integer value (0=0, 1=1, ..., 9=9)
    add r2, r2, r4      // Add to the hash

next_char:
    add r3, r3, #1      // Move to the next character
    b hash_loop

hash_done:
    str r2, [r1]        // Store the final hash value
    bx lr               // Return from the function
