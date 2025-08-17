import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seiyapkg/seiyapkg.dart';
import 'package:uuid/uuid.dart';

Future<String> saveImage(String cacheFile) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  var homeDir = join(appDocPath, "images");

  await touchDirectory(homeDir);
  var uuid = const Uuid();
  var fileName = uuid.v4();
  var extName = extension(cacheFile);
  fileName = "$fileName$extName";
  var fullPath = join(homeDir, fileName);
  debugPrint("fullPath2: $fullPath");
  var srcFile = File(cacheFile);
  var destFile = File(fullPath);
  if (destFile.existsSync()) {
    return fullPath;
  }
  await srcFile.copy(fullPath);
  return fullPath;
}

Future touchDirectory(String path) async {
  var dir = Directory(path);
  var isExists = await dir.exists();
  if (!isExists) {
    await dir.create(recursive: true);
  }
}

Future<String> convertSvgToImageFile(String svgText) async {
  if (svgText.isEmpty) {
    return "";
  }
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var fileName = "${const Uuid().v4()}.txt";
  var tempDirPath = join(tempPath, "svgFiles");
  await touchDirectory(tempDirPath);
  var fullPath = join(tempDirPath, fileName);
  debugPrint("fullPath: $fullPath");
  var file = File(fullPath);
  await file.writeAsString(svgText);
  // return fullPath;
  var md5sum = md5.convert(utf8.encode(svgText)).toString();
  var imgFilePath = join(tempDirPath, "$md5sum.png");
  debugPrint("imgFilePath: $imgFilePath");
  var dir = Directory(imgFilePath);
  var isExists = await dir.exists();
  if (isExists) {
    return imgFilePath;
  }
  // Convert SVG to PNG using seiyapkg
  var seiyapkg = Seiyapkg();
  await seiyapkg.convertSvgToPng(fullPath, imgFilePath);
  return imgFilePath;
}
