import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobigic_test/utils.dart';

class SplashScreen extends StatefulWidget {
  static const routeName ="/splash-screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: SvgPicture.asset(AssetPaths.mobigicLogoPath,height:screenSize.height/4, width: screenSize.width/4,),
        ),
      ),
    );
  }
}
