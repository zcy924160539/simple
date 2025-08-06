import 'package:flutter/material.dart';
import 'package:simple/utils/images_constant.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesConstant.START_BG),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
