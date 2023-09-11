import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GoogleCloudLoadingLogo extends StatefulWidget {
  const GoogleCloudLoadingLogo({super.key});

  @override
  State<GoogleCloudLoadingLogo> createState() => _GoogleCloudLoadingLogoState();
}

class _GoogleCloudLoadingLogoState extends State<GoogleCloudLoadingLogo> {

  late RiveAnimation anim;
  late StateMachineController ctrl;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.asset('./assets/anims/logos.riv',
      artboard: 'googlecloudmono',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'googlecloudmono')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return anim;
  }
}