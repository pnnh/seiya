import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seiya/application/desktop/pages/svg/page.dart';

final GoRouter desktopRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return DesktopSvgPage();
      },
    )
  ],
);
