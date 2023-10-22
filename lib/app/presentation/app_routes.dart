import 'package:deeplink_test/app/domain/entities/named_routes.dart';
import 'package:deeplink_test/home/presentation/home_screen.dart';
import 'package:deeplink_test/posts/domain/entities/post_navigator_arguments.dart';
import 'package:deeplink_test/posts/presentation/post_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes =
    <String, Widget Function(BuildContext)>{
  NamedRoutes.home.path: (BuildContext context) => const HomeScreen(),
  NamedRoutes.postScreen.path: (BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments == null || arguments is! PostNavigatorArguments) {
      return const HomeScreen();
    }

    return PostScreen(postId: arguments.postId);
  },
};
