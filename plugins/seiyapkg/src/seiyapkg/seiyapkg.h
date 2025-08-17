#pragma once

#include "quark/core/string/string.h"

#ifdef __cplusplus
extern "C" {
#endif
CXAPI extern const int SEResultOk=0;
CXAPI extern const int SEResultError=1;

CXAPI const char * SEResultCodeToString(int qkCode);

CXAPI int add(int a, int b);
CXAPI int SEDartSvgToPng(QKString *srcFilePath, QKString *destFilePath, int size);
#ifdef __cplusplus
}
#endif
