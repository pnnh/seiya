#include "seiyapkg.h"
#include <lunasvg.h>
#include <iostream>
#include <filesystem>
#include <quark/core/string/string.h>

int add(int a, int b)
{
    return a + b;
}

// const  int SEResultOk = 0;
// const  int SEResultError = 1;

const char *SEResultCodeToString(int qkCode) {
    switch (qkCode) {
        case SEResultOk:
            return "OK";
        case SEResultError:
            return "ERROR";
        default:
            return "UNKNOWN";
    }
}

int SEDartSvgToPng(QKString *srcFilePath, QKString *destFilePath, int size) {
    if (srcFilePath == nullptr || destFilePath == nullptr) {
        std::cerr << "Invalid arguments" << std::endl;
        return SEResultError;
    }
    if (size <= 0) {
        size = 256; // Default size if not specified
    }
    if (size > 4096) {
        size = 4096; // Cap size to 4096
    }
    auto stdFullPath = QKStringToStdString(srcFilePath);
    auto document = lunasvg::Document::loadFromFile(stdFullPath);
    if (document == nullptr) {
        std::cerr << "Failed to load SVG: " << stdFullPath << std::endl;
        return SEResultError;
    }
    auto bitmap = document->renderToBitmap(size, size);
    if (bitmap.isNull()) {
        std::cerr << "Failed to render SVG to bitmap" << std::endl;
        return SEResultError;
    }

    // std::filesystem::path filePath(stdFullPath);
    // auto directory = filePath.parent_path();
    // auto filename = filePath.filename().string();
    // std::string nameWithoutExtension = filePath.stem().string();
    // std::string randomName = quark::MTUUID::generateUUID();
    // auto fullOutputPath = directory / (randomName + ".png");
    // std::string outputFilePath = fullOutputPath.string();

    // std::cout << "Output file path: " << outputFilePath << std::endl;
    std::string outputFilePath = QKStringToStdString(destFilePath);
    auto result = bitmap.writeToPng(outputFilePath);
    if (!result) {
        std::cerr << "Failed to write bitmap to PNG" << std::endl;
        return SEResultError;
    }
    return SEResultOk;
}