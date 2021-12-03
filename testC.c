#include <stdio.h>

#define SIZE 12

int main()
{
    // getInt
    int pleaseWork = getInt();
    printf("Message 1 is %d\n", pleaseWork);
    pleaseWork = getInt();
    printf("Message 2 is %d\n", pleaseWork);
    int bajs = getInPos();
    printf("inpos: %d\n", bajs);

    // getText
    printf("setting inpos to 0\n");
    setInPos(0);

    char word1[SIZE+2] = "";
    printf("Enter first word(max %d long):\n",SIZE);
    int number1 = getText(word1, SIZE);

    printf("Compared number1 was: %d\n", number1);
    printf("Word1: %s\n", word1);

    printf("setting inpos to 2\n");
    setInPos(2);

    printf("Enter second word(max %d long):\n",SIZE-2);
    char word2[SIZE] = "";
    int number2 = getText(word2, SIZE-2);

    printf("Compared number2 was: %d\n", number2);
    printf("Word2: %s\n", word2);

    return 0;
}
