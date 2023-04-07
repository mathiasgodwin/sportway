import 'package:flutter/material.dart';

class OnboardImage extends StatelessWidget {
  const OnboardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Tennis.png',
      width: 200,
      height: 200,
    );
  }
}
