import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ImageUtils.dart';
import 'package:provider/provider.dart';

import '../ViewModel/MenuViewModel.dart';
import '../config/ColorUtils.dart';
import '../widget/MenuListWidget.dart';

class MenuUI extends StatelessWidget {
  const MenuUI({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight * 0.2, // Set to 20% of screen height
              color: ColorUtils.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<MenuViewModel>(
                        builder: (context, viewModel, child) {
                          return GestureDetector(
                            child:CircleAvatar(
                              radius: screenHeight * 0.07,
                              backgroundColor: ColorUtils.primaryColor,
                              child: CircleAvatar(
                                radius: screenHeight * 0.068,
                                backgroundImage: Image.asset(ImageUtils.logoPath).image,
                              ),
                            ),

                          );
                        },
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<MenuViewModel>(
                            builder: (context, viewModel, child) {
                              return Text(
                                viewModel.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'SmoochSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Consumer<MenuViewModel>(
                            builder: (context, viewModel, child) {
                              return Text(
                                viewModel.email,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'SmoochSans',
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox.fromSize(size: Size.fromHeight(screenHeight * 0.02)),
            Expanded(
            child: MenuListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}