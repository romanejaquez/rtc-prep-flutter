import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GoogleCloudAnimLogo extends StatefulWidget {
  const GoogleCloudAnimLogo({super.key});

  @override
  State<GoogleCloudAnimLogo> createState() => _GoogleCloudAnimLogoState();
}

class _GoogleCloudAnimLogoState extends State<GoogleCloudAnimLogo> {

  late RiveAnimation anim;
  late StateMachineController ctrl;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.asset('./assets/anims/duupr_logos.riv',
      artboard: 'googlecloud',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'googlecloud')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return anim;
  }
}