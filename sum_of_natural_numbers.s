.global sum_n
.type	sum_n,%function


sum_n:
	.fnstart
	add r1, r1, r0       //r1 = r1 + r0
    cmp r0, #0            //Compare n with 0
    ble end_recursion     //If n <= 0, end recursion

    sub r0, r0, #1        // r0 = r0 - 1
    bl sum_n  			  // Recursive call to sum_of_natural_numbers

end_recursion:
    pop {r1, pc}          //Restore registers and return
	.fnend