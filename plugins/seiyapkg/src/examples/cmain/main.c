#include <stdio.h>

#include "seiyapkg/seiyapkg.h"
#include <quark/core/string/string.h>

int main(){
	QKString* srcPath = QKStringCreate("./data/input.svg");
	QKString* targetPath = QKStringCreate("./output/output.png");
	int resultCode = SEDartSvgToPng(srcPath, targetPath, 256);

	if (resultCode != SEResultOk) {
		printf("Error: %d\n", resultCode);
	}
	// QKStringFree(srcPath);
	// QKStringFree(targetPath);
	printf("Result code: %d\n",resultCode);
	return 0;
}