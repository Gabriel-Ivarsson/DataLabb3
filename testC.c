#include <stdio.h>

int main()
{
    char *word = "";
    int number = getText(word, 5);
    printf("Compared number was: %d\n", number);
    printf("Word: %s", word);
    
    return 0;
}