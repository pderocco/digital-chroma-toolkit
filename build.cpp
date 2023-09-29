#include "build.h"

int const   build_day       = __DATE__[4] == ' ' ? __DATE__[5] - '0'
                                : __DATE__[4] * 10 + __DATE__[5] - '0' * 11;
int const   build_hour      = __TIME__[0] * 10 + __TIME__[1] - '0' * 11;
int const   build_minute    = __TIME__[3] * 10 + __TIME__[4] - '0' * 11;
int const   build_month     = __DATE__[2] == 'b' ? 2 
                                : __DATE__[2] == 'c' ? 12 
                                : __DATE__[2] == 'g' ? 8 
                                : __DATE__[2] == 'l' ? 7 
                                : __DATE__[2] == 'n' 
                                    ? __DATE__[1] == 'a' ? 1 : 6 
                                : __DATE__[2] == 'p' ? 9 
                                : __DATE__[2] == 'r' 
                                    ? __DATE__[1] == 'a' ? 3 : 4 
                                : __DATE__[2] == 't' ? 10 
                                : __DATE__[2] == 'v' ? 11 
                                : 5;
int const   build_second    = __TIME__[6] * 10 + __TIME__[7] - '0' * 11;
int const   build_year      = __DATE__[7] * 1000 + __DATE__[8] * 100
                                + __DATE__[9] * 10 + __DATE__[10] - '0' * 1111;
