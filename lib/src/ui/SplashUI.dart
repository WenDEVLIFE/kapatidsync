import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/SplashViewModel.dart';
import 'package:provider/provider.dart';

class SplashUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SplashViewModel splashViewModel = Provider.of<SplashViewModel>(context);

    return Scaffold(
      body: FutureBuilder(future: splashViewModel.setLoading(context),
          builder: (context, snapshot){
        return const Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
        );

          }
      )
    );
  }
}