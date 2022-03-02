import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum DotStatus { empty, active, end }

class Dot extends StatelessWidget {
  const Dot({Key? key, required this.status}) : super(key: key);
  final DotStatus status;

  get statusDotPath {
    String name = status.toString().split(".")[1];
    return "assets/dot-status/$name.svg";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SvgPicture.asset(
        statusDotPath,
        semanticsLabel: 'status',
        width: 12,
        height: 12,
      ),
    );
  }
}
