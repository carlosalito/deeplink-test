import 'package:deeplink_test/app/domain/entities/named_routes.dart';
import 'package:deeplink_test/app/presentation/app_routes.dart';
import 'package:deeplink_test/app/presentation/handle_deeplink.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  initState() {
    super.initState();
    _initializeDeeplinks();
  }

  Future<void> _initializeDeeplinks() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      print(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        final Uri deepLink = pendingDynamicLinkData.link;
        DeeplinkActions()
            .handle(navigatorKey: navigatorKey, deepLink: deepLink);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Deeplink test',
      routes: appRoutes,
      initialRoute: NamedRoutes.home.path,
    );
  }
}
