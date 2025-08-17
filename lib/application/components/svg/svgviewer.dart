import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seiya/application/web/layout/size.dart';
import 'package:seiya/application/web/theme.dart';
import 'package:seiya/models/svg/state.dart';
import 'package:seiya/services/files/files.dart';

class WSvgViewerPartial extends ConsumerWidget {
  const WSvgViewerPartial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SvgModel> svgModelState = ref.watch(svgModelStateProvider);

    return Container(
      width: STAppTheme.rootFontSize * 24,
      height: STAppTheme.rootFontSize * 12,
      decoration: BoxDecoration(
          border: new Border.all(color: Color(0xFFCCCCCC), width: 1),
          borderRadius: new BorderRadius.circular((4.0))),
      padding: const EdgeInsets.all(0),
      child: switch (svgModelState) {
        AsyncData(:final value) => WSvgImage(value.text),
        AsyncError() =>
          const Center(child: Text('Oops, something unexpected happened')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class WSvgImage extends ConsumerWidget {
  final String svgText;
  const WSvgImage(this.svgText, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String>(
      future: convertSvgToImageFile(svgText), // 异步操作的Future对象
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 当Future还未完成时，显示加载中的UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData) {
          // 当Future发生错误时，显示错误提示的UI
          return Text('Error: ${snapshot.error}');
        } else {
          var imgFilePath = snapshot.data!;
          if (imgFilePath.isEmpty) {
            return const Center(child: Text('No SVG data available'));
          }
          return Container(
            padding: EdgeInsets.all(STWebAppTheme.rootFontSize),
            child: Image.file(File(
              imgFilePath,
            )),
          );
          // return Container(
          //   padding: EdgeInsets.all(STWebAppTheme.rootFontSize),
          //   child: Text(
          //     snapshot.data!,
          //     style: TextStyle(fontSize: STAppTheme.rootFontSize),
          //   ),
          // );
        }
      },
    );
  }
}
