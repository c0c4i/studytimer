import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'countdown.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.disableFullSizeContentView();
  await Window.hideZoomButton();
  await Window.disableMiniaturizeButton();
  await Window.hideTitle();
  await Window.makeTitlebarTransparent();

  await DesktopWindow.setMaxWindowSize(const Size(360, 256));
  await DesktopWindow.setMinWindowSize(const Size(360, 256));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const CountDownTimerPage(),
    );
  }
}
