import 'package:flutter/material.dart';
import 'package:helpfeed2/ui/registration/about/about_screen.dart';

import 'package:helpfeed2/ui/registration/basic_detail/basic_detail_screen.dart';


import '../address_detail/address_detail_screen.dart';
import '../upload_documents/upload_documents_screen.dart';
import '../upload_images/upload_images_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text("Register"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  BasicDetailScreen(),
                  UploadImagesScreen(),
                  UploadDocumentsScreen(),
                  AddressDetailScreen(),
                  AboutScreen(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ElevatedButton(

                  onPressed: () {
                    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Next'),
                      ), // <-- Text

                      Icon( // <-- Icon
                        Icons.navigate_next_rounded,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
