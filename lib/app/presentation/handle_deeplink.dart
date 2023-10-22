import 'package:deeplink_test/app/domain/entities/deeplink_types.dart';
import 'package:deeplink_test/app/domain/entities/named_routes.dart';
import 'package:deeplink_test/posts/domain/entities/post_navigator_arguments.dart';
import 'package:flutter/material.dart';

class DeeplinkActions {
  static const baseUri = 'http://localhost/';

  Future<void> _handlePostLink(
      GlobalKey<NavigatorState> navigatorKey, Uri deeplink) async {
    final postId = deeplink.toString().split('id=')[1];

    navigatorKey.currentState?.pushNamed(
      NamedRoutes.postScreen.path,
      arguments: PostNavigatorArguments(postId: postId),
    );
  }

  Future<void> _handleUnknownLink(
      GlobalKey<NavigatorState> navigatorKey, Uri deeplink) async {
    // TODO(deeplink): Do something like an external log...
  }

  Future<void> handle(
      {required GlobalKey<NavigatorState> navigatorKey,
      required Uri deepLink}) async {
    final Map<String, void Function()> targets = <String, void Function()>{
      DeeplinkTypes.post.path: () async =>
          await _handlePostLink(navigatorKey, deepLink),
    };

    bool wasProcessed = false;
    for (final target in targets.entries) {
      if (deepLink.path.contains(target.key)) {
        target.value();
        wasProcessed = true;
      }
    }

    if (!wasProcessed) {
      _handleUnknownLink(navigatorKey, deepLink);
    }
  }
}
