#include <stdio.h>

int main()
{
    int pleaseWork = getInt();
    printf("Message 1 is %d\n", pleaseWork);

    pleaseWork = getInt();
    printf("Message 2 is %d\n", pleaseWork);

    return 0;
}