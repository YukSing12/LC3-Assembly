////////////////////////////////////////////////////////////////////////
// Define a function multiplyByShiftAndAdd
// input unsigned short a , unsigned short b
// ouput return unsigned result
// authors XieYusheng
// revision histroy 1.0
////////////////////////////////////////////////////////////////////////
#include <stdio.h>
#include <stdlib.h>
// This is your function to implement shift-and-add multiplication
unsigned multiplyByShiftAndAdd(unsigned short a, unsigned short b)
{
	unsigned product=0;
 // Task 1:
 // Please implement the algorithm of shift_and_add here.
	for (int i = 0; (b>>i)!=0; ++i)
	{
		if(((b>>i)&1)==0) continue;
		else
			product+=a<<i;
	}
	return product;
}
// This is your main function
int main(int argv, char** argc)
{
	int a, b;
	printf("Please input the two numbers to multiply: ");
	// scanf("%d%d", &a, &b);
	// Task 2:
	// Verify that 'a' and 'b' can be represented with 16-bit unsigned short.
	// That is, they must be between 0 and 65535 (2^16-1).
	scanf("%d",&a);
	scanf("%d",&b);
	if (!(a>=0&&a<=65535))
	{
		printf("a out of range \n");
	}
	if (!(b>=0&&a<=65535))
	{
		printf("b out of range \n");
	}
	unsigned p = multiplyByShiftAndAdd((unsigned short)a, (unsigned short)b);
	printf("The product is: %u\n", p);
	if( p != (a * b)) {
		printf("Whoops! Something is wrong.\n");
	}
	return 0;
}