import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/MenuViewModel.dart';
import '../config/ColorUtils.dart';
import '../widget/MenuListWidget.dart';

class MenuUI extends StatefulWidget {
  final Function(int) onItemSelected;

  const MenuUI({super.key, required this.onItemSelected});

  @override
  MenuUIState createState() => MenuUIState();
}

class MenuUIState extends State<MenuUI> {
  late MenuViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MenuViewModel>(context, listen: false).getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MenuViewModel viewModel = Provider.of<MenuViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
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
                            child: CircleAvatar(
                              radius: screenHeight * 0.04,
                              backgroundColor: ColorUtils.secondaryColor,
                              child: CircleAvatar(
                                radius: screenHeight * 0.068,
                                backgroundImage: AssetImage(viewModel.profilepath),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<MenuViewModel>(
                              builder: (context, viewModel, child) {
                                return Text(
                                  viewModel.name,
                                  style: TextStyle(
                                    color: ColorUtils.secondaryColor,
                                    fontSize: screenHeight * 0.02,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Consumer<MenuViewModel>(
                              builder: (context, viewModel, child) {
                                return Text(
                                  viewModel.email,
                                  style: TextStyle(
                                    color: ColorUtils.secondaryColor,
                                    fontSize: screenHeight * 0.02,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Consumer<MenuViewModel>(
                              builder: (context, viewModel, child) {
                                return Text(
                                  viewModel.role,
                                  style: TextStyle(
                                    color: ColorUtils.secondaryColor,
                                    fontSize: screenHeight * 0.02,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorUtils.primaryColor,
                ),
                child: MenuListWidget(
                  onItemSelected: widget.onItemSelected,
                  role: viewModel.role,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}