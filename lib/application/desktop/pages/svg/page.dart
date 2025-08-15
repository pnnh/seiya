import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seiya/application/components/svg/action.dart';
import 'package:seiya/application/components/svg/export.dart';
import 'package:seiya/application/components/svg/source.dart';
import 'package:seiya/application/components/svg/svgeditor.dart';
import 'package:seiya/application/components/svg/svgviewer.dart';

class DesktopSvgPage extends ConsumerStatefulWidget {
  const DesktopSvgPage({super.key});

  @override
  ConsumerState<DesktopSvgPage> createState() => _DPasswordPageState();
}

class _DPasswordPageState extends ConsumerState<DesktopSvgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.white,
            child: Column(
              children: [
                WFromSourcePartial(),
                WSvgEditorPartial(),
                WSvgViewerPartial(),
                WSvgActionPartial(),
                WSvgExportPartial()
              ],
            ),
          ))
        ],
      ),
    )));
  }
}
