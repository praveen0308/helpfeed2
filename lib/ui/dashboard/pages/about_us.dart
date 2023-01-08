import 'package:flutter/material.dart';
import 'package:helpfeed2/res/app_images.dart';
import 'package:helpfeed2/res/app_strings.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text("About Us"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Image(image: AssetImage(AppImages.appIcon),),
              Text(AppStrings.aboutUs,textAlign: TextAlign.justify,)
            ],
          ),
        ),
      ),
    ));
  }
}
