import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter desktopRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Center(
          child: Text("Desktop Home Page"),
        );
      },
    )
  ],
);
