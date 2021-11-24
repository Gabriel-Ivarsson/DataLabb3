#include <stdio.h>

int main()
{
    char word[7];
    int number = getText(word, 6);
    printf("Compared number was: %d\n", number);
    printf("Word: %s\n", word);

    number = getText(word, 6);
    printf("Compared number was: %d\n", number);
    printf("Word: %s\n", word);

    return 0;
}
