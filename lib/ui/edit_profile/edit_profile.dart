import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/local/app_storage.dart';
import 'package:helpfeed2/ui/edit_profile/edit_profile_cubit.dart';
import 'package:helpfeed2/utils/toaster.dart';

import '../../models/user_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ownerName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _webUrl = TextEditingController();
  final TextEditingController _description = TextEditingController();


  @override
  void initState() {
    AppStorage.getName().then((value) => _name.text = value!);
    AppStorage.getPersonName().then((value) => _ownerName.text = value!);
    AppStorage.getPhoneNumber().then((value) => _mobileNumber.text = value!);
    AppStorage.getWebUrl().then((value) => _webUrl.text = value!);
    AppStorage.getDescription().then((value) =>
    _description.text = value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if(state is UpdatedSuccessfully){
              showToast("Profile updated successfully!!!",ToastType.success);
              Navigator.pop(context);
            }
            if(state is Error){
              showToast(state.msg,ToastType.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _ownerName,
                  decoration: const InputDecoration(
                      label: Text("Owner Name"),
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _mobileNumber,
                  decoration: const InputDecoration(
                      label: Text("Mobile Number"),
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),

                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _webUrl,
                  decoration: const InputDecoration(
                      label: Text("Web Url"),
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text("Description *"),
                TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.name,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(height: 24,),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    if (state is Updating) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditProfileCubit>(context)
                              .updateUserProfile(UserModel(

                            name: _name.text.toUpperCase(),
                            personName: _ownerName.text,
                            contacts: [_mobileNumber.text],
                            webUrl: _webUrl.text,
                            description: _description.text,
                          ));
                        },
                        child: const Text("Submit"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
