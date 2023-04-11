import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive().centered();
  }
}
