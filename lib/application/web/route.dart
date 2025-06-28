import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suzaku/application/web/pages/svg/page.dart';

final GoRouter webRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return WSvgPage();
      },
    )
  ],
);
