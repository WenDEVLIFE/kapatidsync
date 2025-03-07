import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/SplashViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';

import '../config/ImageUtils.dart';

class SplashUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SplashViewModel splashViewModel = Provider.of<SplashViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: FutureBuilder(future: splashViewModel.setLoading(context),
          builder: (context, snapshot){
        return Center(
            child: Center(
              child: Center(
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
                    const Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            ),
        );

          }
      )
    );
  }
}