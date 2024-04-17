#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int sum_n();
extern int compute_hash(char* input);

int main () {
	
	int result = sum_n(5);
	char input[] = "Ar, PE 2!W";
	
	int hash_value = compute_hash(input);

	printf("Sum of numbers S5 = %d\n", result);
	printf("Hash of %s\n is %d", input, hash_value );
	
	return 0;
}
