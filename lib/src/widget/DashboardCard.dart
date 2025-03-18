import 'package:flutter/material.dart';

import '../config/ColorUtils.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Stream<int> stream;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.label,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: ColorUtils.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 50),
              SizedBox(height: screenHeight * 0.01),
              Text(label, style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              )),
              SizedBox(height: screenHeight * 0.01),
              StreamBuilder<int>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data}', style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ));
                  } else {
                    return const Text('0', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}