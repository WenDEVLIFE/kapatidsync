import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/SplashViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';

import '../config/ImageUtils.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashViewModel>(context, listen: false).setLoading(context);
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animation = IntTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Consumer<SplashViewModel>(
        builder: (context, splashViewModel, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageUtils.logoPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: screenHeight * 0.02),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    String dots = '.' * (_animation.value + 1);
                    return Text(
                      'Loading$dots',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}