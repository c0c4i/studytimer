import 'dart:io';

get isDesktop {
  return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
}
