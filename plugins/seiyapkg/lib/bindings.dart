import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'generated_bindings.dart';

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

class FFIBindings {
  static late final SeiyapkgNative seiyapkgNative = loadNativeLibrary();

  static SeiyapkgNative loadNativeLibrary() {
    var dylib = _openNativeLibrary('MTSeiyapkg');
    return SeiyapkgNative(dylib);
  }

  static ffi.DynamicLibrary _openNativeLibrary(String libName) {
    debugPrint("current dir: ${Directory.current}");
    if (Platform.isMacOS || Platform.isIOS) {
      return ffi.DynamicLibrary.process();
    }
    if (Platform.isAndroid || Platform.isLinux) {
      return ffi.DynamicLibrary.open('lib$libName.so');
    }
    if (Platform.isWindows) {
      return ffi.DynamicLibrary.open('$libName.dll');
    }
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }

  static int nativeAdd(int a, int b) {
    return seiyapkgNative.add(a, b);
  }

  static Future convertSvgToPng(String svgFilePath, String destFilePath) async {
    if (!File(svgFilePath).existsSync()) {
      throw Exception("SVG file does not exist: $svgFilePath");
    }
    final int size = 512; // Default size for the PNG image
    // Ensure the destination directory exists
    ffi.Pointer<ffi.Char> ffiSrcFilePath = svgFilePath
        .toNativeUtf8()
        .cast<ffi.Char>();
    ffi.Pointer<ffi.Char> ffiDestFilePath = destFilePath
        .toNativeUtf8()
        .cast<ffi.Char>();

    var qkSrcFilePath = seiyapkgNative.QKStringCreate(ffiSrcFilePath);
    var qkDestFilePath = seiyapkgNative.QKStringCreate(ffiDestFilePath);

    var resultCode = seiyapkgNative.SEDartSvgToPng(
      qkSrcFilePath,
      qkDestFilePath,
      size,
    );
    if (resultCode != seiyapkgNative.SEResultOk) {
      var errorMessage = seiyapkgNative.SEResultCodeToString(resultCode);
      throw Exception("Failed to convert SVG to PNG: $errorMessage");
    }
  }
}
