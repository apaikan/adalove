
#include <stdlib.h>
#include "random_num.h"
 
int getRandom(int a, int b) 
{
    return (int)((b-a) * ((double) rand()/RAND_MAX) + a);
}
 

