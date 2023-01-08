import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/res/app_images.dart';
import 'package:helpfeed2/ui/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).verifyAuthentication();
    /*  Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, "/signIn");
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, "/dashboard");
          }
          if (state is UnAuthenticated) {
            Navigator.pushReplacementNamed(context, "/signIn");
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage(AppImages.appIcon),
              width: 200,
              height: 200,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    ));
  }
}
