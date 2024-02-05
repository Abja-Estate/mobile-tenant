import 'package:flutter/material.dart';
import 'dart:async';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../dashboard/dashboard.dart';
import '../navbar/nav.dart';

class LoadingAccount extends StatefulWidget {
  const LoadingAccount({Key? key}) : super(key: key);

  @override
  _LoadingAccountScreenState createState() => _LoadingAccountScreenState();
}

class _LoadingAccountScreenState extends State<LoadingAccount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of animation
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.2, end: 0.6) // Range of scale values
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavBar(
                      initialScreen: Dashboard(),
                      initialTab: 0,
                    )),
            (route) => false,
          );
        }
      });

    Timer(Duration(milliseconds: 500), () {
      // Optional delay before starting animation
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(AppImages.bg),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: _getSize.height * 0.43,
                    child: ScaleTransition(
                      scale: _animation,
                      child: Image.asset(AppImages.logo),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
