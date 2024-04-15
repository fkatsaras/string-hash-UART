#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "platform.h"
#include "queue.h"
#include "uart.h"

// Function prototypes 
void uart_rx_isr(uint8_t rx);

// Function prototypes for assembly routines
extern int calculate_hash(char *input); // Assembly routine to calculate hash
extern int calculate_digit_sum(int hash); // Assembly routine to calculate digit sum

#define BUFF_SIZE 128 //read buffer length

Queue rx_queue; // Queue for storing received characters

// Interrupt Service Routine for UART receive
void uart_rx_isr(uint8_t rx) {
	// Check if the received character is a printable ASCII character
	if (rx >= 0x0 && rx <= 0x7F ) {
		// Store the received character
		queue_enqueue(&rx_queue, rx);
	}
}


int main() {
		uint8_t rx_char = 0;
    char input[BUFF_SIZE]; // Define a buffer to store input alphanumeric string
		uint32_t buff_index;
    // int hash, digit_sum;
	
		// Initialize the receive queue and UART
		queue_init(&rx_queue, BUFF_SIZE);
		uart_init(115200);
		uart_set_rx_callback(uart_rx_isr); // Set the UART receive callback function
		uart_enable();
	
		__enable_irq(); // Enable interrupts
	
		uart_print("\r\n");
    
		while(1) {
		
		// Prompt the user to enter the alphanumeric string
		uart_print("Enter your alphanumeric string:");
		buff_index = 0; // Reset buffer index
		
		do {
			// Wait until a character is received in the queue
			while (!queue_dequeue(&rx_queue, &rx_char))
				__WFI(); // Wait for Interrupt

			if (rx_char == 0x7F) { // Handle backspace character
				if (buff_index > 0) {
					buff_index--; // Move buffer index back
					uart_tx(rx_char); // Send backspace character to erase on terminal
				}
			} else {
				// Store and echo the received character back
				input[buff_index++] = (char)rx_char; // Store character in buffer
				uart_tx(rx_char); // Echo character back to terminal
			}
		} while (rx_char != '\r' && buff_index < BUFF_SIZE); // Continue until Enter key or buffer full
		
		// Replace the last character with null terminator to make it a valid C string
		input[buff_index - 1] = '\0';
		uart_print("\r\n"); // Print newline
		
		// Check if buffer overflow occurred
		if (buff_index > BUFF_SIZE) {
			uart_print("Stop trying to overflow my buffer! I resent that!\r\n");
		}
	}
    
    // For testing purposes, simulate input
    strcpy(input, "sAr, PE 2!W");

    // Call the assembly routine to calculate the hash
		char hash[BUFF_SIZE];
    hash = calculate_hash(input);

    // Print the calculated hash
    printf("Hash of the input string: %d\n", hash);

    // Call the assembly routine to calculate the digit sum
    digit_sum = calculate_digit_sum(hash);

    // Print the digit sum
    printf("Single-digit sum from the hash: %d\n", digit_sum);

    // Call the provided C function to calculate the result
    int result = sum_of_natural_numbers(digit_sum);

    // Print the final result
    printf("Result after sum_of_natural_numbers: %d\n", result);

    // End of the main routine
    return 0;
}