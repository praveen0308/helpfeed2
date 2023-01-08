import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_details_cubit.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:helpfeed2/utils/toaster.dart';

import '../../../res/app_colors.dart';

class BasicDetailScreen extends StatefulWidget {
  const BasicDetailScreen({Key? key}) : super(key: key);

  @override
  State<BasicDetailScreen> createState() => _BasicDetailScreenState();
}

class _BasicDetailScreenState extends State<BasicDetailScreen> {
  UserRole _role = UserRole.donor;
  final List<String> _categories = [
    "Restaurant",
    "Hotel",
    "Super Market",
    "Other"
  ];
  var _category = "Restaurant";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _ownerName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _webUrl = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  void updateCategories(UserRole role) {
    _categories.clear();
    if (_role == UserRole.donor) {
      _category = "Restaurant";
      _categories.addAll(["Restaurant", "Super Market", "Caterers", "Other"]);
    } else {
      _category = "NGO";
      _categories.addAll(["NGO", "School", "Other"]);
    }
  }

  @override
  void initState() {
    _ownerName.text = user?.displayName ?? "";
    _email.text = user?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
              child: BlocListener<BasicDetailsCubit, BasicDetailsState>(
  listener: (context, state) {
    if (state is AddedSuccessfully) {
      showToast("Stored successfully !!!", ToastType.success);
      Navigator.pushReplacementNamed(context, "/myAddress");
    }
    if (state is Failed) {
      showToast("Failed!!!", ToastType.error);
    }
  },
  child: SingleChildScrollView(
    child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<UserRole>(
                        title: const Text('Donor'),
                        value: UserRole.donor,
                        groupValue: _role,
                        onChanged: (UserRole? value) {
                          setState(() {
                            _role = value!;
                            updateCategories(_role);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<UserRole>(
                        title: const Text('Receiver'),
                        value: UserRole.receiver,
                        groupValue: _role,
                        onChanged: (UserRole? value) {
                          setState(() {
                            _role = value!;

                            updateCategories(_role);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton2(
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: _categories
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ))
                      .toList(),
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      _category = value as String;
                    });
                  },
                  buttonHeight: 40,
                  itemHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: AppColors.primaryDarkest, width: 1.5),
                    color: Colors.white,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                )),
                const SizedBox(
                  height: 8,
                ),
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
                  controller: _email,
                  decoration: const InputDecoration(
                      label: Text("Email"),
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
                BlocBuilder<BasicDetailsCubit, BasicDetailsState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<BasicDetailsCubit>(context)
                              .addBasicDetails(UserModel(
                            role: _role.name,
                            category: _category,
                            email: user!.email,
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
)),
        ),
      ),
    );
  }
}
