import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            ElevatedButton(
              onPressed: () => _shareDeeplink(),
              child: Text('Compartilhar deeplink'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareDeeplink() async {
    final postId = shortHash(UniqueKey());

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("http://localhost/post?id=$postId"),
      uriPrefix: "https://cacsf.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.example.deeplink_test"),
      iosParameters: const IOSParameters(bundleId: "com.example.deeplink_test"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    print(dynamicLink.shortUrl);
  }
}
