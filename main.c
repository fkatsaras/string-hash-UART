#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "platform.h"
#include "queue.h"
#include "uart.h"

#define BUFF_SIZE 128 //define buffer length

// Function prototypes 
void uart_rx_isr(uint8_t rx);
char uart_input();

extern int sum_n();
extern int compute_hash(char* input);

Queue rx_queue; // Queue for storing received characters

// Interrupt Service Routine for UART receive
void uart_rx_isr(uint8_t rx) {
	// Check if the received character is a printable ASCII character
	if (rx >= 0x0 && rx <= 0x7F ) {
		// Store the received character
		queue_enqueue(&rx_queue, rx);
	}
}

char uart_input() {
	
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
	return input;
}

int main () {
	
	int result = sum_n(5);
	// char input[] = "C";
	char input = uart_input();
	
	int hash_value = compute_hash(input);

	printf("Sum of numbers S5 = %d\n", result);
	printf("Hash of %s\n is %d", input, hash_value );
	
	return 0;
}
