import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/res/app_colors.dart';

import '../../../../local/app_storage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String name = " " ;
  String locationTag = "" ;


  @override
  void initState() {
     AppStorage.getName().then((value){
        setState((){
          name = value.toString();
        });
    });

     AppStorage.getLocationTag().then((value){
       setState((){
         locationTag = value.toString();
       });
     });
     super.initState();
  }

  _showLogOutDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: const Text("LogOut?"),
          content: const Text("Do you really want to log out?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context1).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                Navigator.of(context1).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if(value){

        FirebaseAuth.instance.signOut().then((value) async {
          await FirebaseMessaging.instance.unsubscribeFromTopic("receiver");
          await FirebaseMessaging.instance.unsubscribeFromTopic("donor");
          Navigator.popAndPushNamed(context, "/");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, right: 8, left: 8, bottom: 8),
          child: Text(
            "Profile",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                // backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                radius: 28,
                // backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                child: Text(name[0],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      locationTag,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {
                Navigator.pushNamed(context, "/editProfile");
              }, icon: const Icon(Icons.edit_note_rounded))
            ],
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text(
                "My Images",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pushNamed(context, "/imagesScreen");
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "My Documents",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                // todo navigate to all documents
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Address and Location",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                // todo navigate to all address
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "About Us",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pushNamed(context, "/aboutUs");
              },
            ),
            /*const Divider(),
            ListTile(
              title: const Text(
                "Contact Us",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                // todo navigate to all images
              },
            ),*/
            const Divider(),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDarkest),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                _showLogOutDialog(context);
              },
            ),
          ],
        ),

      ],
    );
  }
}
