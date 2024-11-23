import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Container(
        child: Column(
          children: [
            Image.asset("assets/icon.png"),
          ],
        ),
      ),
    );
  }
}
