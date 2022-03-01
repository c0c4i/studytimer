import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';

import 'countdown.dart';
import 'utils/is_desktop.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktop) {
    await Window.initialize();
    await windowManager.ensureInitialized();
    // await windowManager.setTitleBarStyle('hidden');
    if (Platform.isMacOS) {
      await Window.disableFullSizeContentView();
      await Window.disableMiniaturizeButton();
      await Window.hideZoomButton();
      await Window.hideTitle();
      await Window.makeTitlebarTransparent();
    }

    if (Platform.isWindows) {
      // await Window.hideWindowControls();
    }

    await DesktopWindow.setMaxWindowSize(const Size(360, 264));
    await DesktopWindow.setMinWindowSize(const Size(360, 264));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'Poppins'),
      home: const CountDownTimerPage(),
    );
  }
}
