import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text("About Yourself"),
           TextFormField(
             minLines: 10,
          )
        ],
      ),
    );
  }
}
