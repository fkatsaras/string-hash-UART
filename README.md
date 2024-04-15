# ARM Assembly String Hashing

This repository contains an implementation of string hashing and related functions in ARM assembly language, targeting an ARM microcontroller, for a project of the 2024 EE class Microprocessors and Peripherals of the AUTh. (The project was done using the Keil development tools as presented in the class)

## Description
The provided assembly routine generates a hash from a given string according to the following rules:

1. For each uppercase Latin letter, it adds the corresponding number from the provided table.
2. For each lowercase Latin letter, it subtracts the corresponding number from the table.
3. For each numeric digit, it adds its value to the hash.
4. The hash is not affected by any other characters in the string.
5. Finally, it calculates the sum of digits of the hash until it becomes a single-digit number.

## Usage
*main.c*: This file contains a basic main routine in C language. It dynamically takes input from the user via UART for the string to be hashed.

*string_hash.asm*: This file contains the assembly routine to calculate the hash of the given string. It stores the hash value in a selected memory location and returns it to the main routine.

*sum_of_natural_numbers.asm*: This file contains the assembly routine to calculate the sum of natural numbers from the hash value until it becomes a single-digit number. It also stores the result in a chosen memory location and returns it to the main routine.

## Contributing
Feel free to contribute to this project by forking the repository and creating pull requests for any enhancements or fixes.

### License
This project is licensed under the Apache 2.0 License.

