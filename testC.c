#include <stdio.h>

int main()
{
    // getInt
/*
 *    int pleaseWork = getInt();
 *    printf("Message 1 is %d\n", pleaseWork);
 *
 *    pleaseWork = getInt();
 *    printf("Message 2 is %d\n", pleaseWork);
 */

    // getText
    char word1[7];
    int number1 = getText(&word1, 5);

    printf("Compared number1 was: %d\n", number1);
    printf("Word: %s\n", word1);

    char word2[7];
    int number2 = getText(&word2, 5);

    printf("Compared number2 was: %d\n", number2);
    printf("Word: %s\n", word2);

    return 0;
}
