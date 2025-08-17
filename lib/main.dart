import 'package:flutter/material.dart';
import 'package:seiyapkg/seiyapkg.dart';

import 'application/application.dart'
    if (dart.library.html) 'application/application_web.dart'
    if (dart.library.io) 'application/application_native.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var seiyapkg = Seiyapkg();
  var pkgVersion = seiyapkg.getPlatformVersion();
  print('SeiyaPkg version: $pkgVersion');

  var sum = await seiyapkg.calcSum(1, 2);
  print('Sum of 1 and 2 using FFI: $sum');

  var app = await initApp();

  runApp(app);
}
