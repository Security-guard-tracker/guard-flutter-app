import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/theme/custom_theme.dart';

class CheckPointCompleteSuccess extends StatefulWidget {
  const CheckPointCompleteSuccess({super.key});

  @override
  State<CheckPointCompleteSuccess> createState() => _CheckPointCompleteSuccessState();
}

class _CheckPointCompleteSuccessState extends State<CheckPointCompleteSuccess> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      // Navigator.pop(context);
      screenNavigator(
      context, CheckPointScreen());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
            'assets/green_tick.svg',
            height: 66,
          )),
          SizedBox(
            height: 15,
          ),
          Text('Done',
              textAlign: TextAlign.center,
              style: CustomTheme.blackTextStyle(25)),
          SizedBox(
            height: 20,
          ),
          Text('Task Updated\n successfully!',
              textAlign: TextAlign.center,
              style: CustomTheme.blackTextStyle(17))
        ],
      )),
    );
  }
}
