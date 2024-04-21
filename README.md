# ARM Assembly String Hashing

This repository contains an implementation of string hashing and related functions in ARM assembly language, targeting an ARM microcontroller, for a project of the 2024 EE class Microprocessors and Peripherals of the AUTh. (The project was done using the Keil development tools as presented in the class)


## Description
The program's purpose is to hash a string received by the user via UART and return a unique integer.

The files included are: 

+ __main.c__: This file contains a basic main routine in C language. It dynamically takes input from the user via UART for the string to be hashed.


+ __calculate_sum.s__: This file contains the assembly routine to calculate the hash of the given string. It stores the hash value in a selected memory location and returns it to the main routine.


The hash is generated from the input string according to the following rules:
1. For each uppercase Latin letter, the corresponding number from the provided table is added to the result.
2. For each lowercase Latin letter, it subtracts the corresponding number from the table.
3. For each numeric digit, it adds its value to the hash.
4. The hash is not affected by any other characters in the string.

| A  | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z |
|----|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|10  |42 |12 |21 | 7 | 5 |67 |48 |69 | 2 |36 | 3 |19 | 1 |14 |51 |71 | 8 |26 |54 |75 |15 | 6 |59 |13 |25 |


+ __sum_of_natural_numbers.asm__: This file contains the assembly routine to perform digit addition of the hash output of *calculate_hash* until it becomes a single-digit integer. Then it calculates the sum of natural numbers of the single-digit integer, stores the result in a chosen memory location and returns it to the main routine.


## Contributing
Feel free to contribute to this project by forking the repository and creating pull requests for any enhancements or fixes.

### License
This project is licensed under the Apache 2.0 License.

