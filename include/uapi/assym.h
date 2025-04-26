#pragma once

#define ASSYM_BIAS 0x10000 /* avoid zero-length arrays */
#define ASSYM_ABS(value) ((value) < 0 ? -((value) + 1) + 1ULL : (value))

#define ASSYM(name, value) \
    char name##_value[(value) + 1]
