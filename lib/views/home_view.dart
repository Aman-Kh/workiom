import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/constants/route_generator.dart';

class HomeView extends StatelessWidget
{
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () { Navigator.pushNamedAndRemoveUntil(context, RouteNames.welcomeView, (route) => false); },
            icon:Icon(Icons.arrow_back_ios, color: veryDarkBlueColor)),
        title: Text('Home'),
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Container(
        child: const Text('Home'),
      ),
    );
  }
}