import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/user_profile/user_profile_cubit.dart';
import 'package:helpfeed2/utils/launcher_utils.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;


  const UserProfileScreen({Key? key,required this.userId}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserModel user;

  @override
  void initState() {
    BlocProvider.of<UserProfileCubit>(context).fetchUserDetail(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if(state is LoadingProfile){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is ReceivedUserDetails){
            user = state.user;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          child: Text(user.name![0],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(user.name!,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700)),
                              Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      user.role!.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.successDarkest),
                                    ),
                                    backgroundColor: AppColors.successLightest,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Chip(
                                    label: Text(
                                      user.category!.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.warningDarkest),
                                    ),
                                    backgroundColor: AppColors.warningLight,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (user.role == "donor")
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightest,
                          border: Border.all(color: AppColors.primaryDarkest),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          "Donations : ${user.donationCount}",
                          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.primaryDarkest),
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(user.description ?? "N.A."),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Address & Location",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(user.address.toString()),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Other Details",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text("${user.personName}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                    ListTile(
                      leading: const Icon(Icons.call),
                      title: Text("${user.contacts![0]}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        LauncherUtils.openPhone(user.contacts![0]);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text("${user.email}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        LauncherUtils.openEmail(user.email!,"Hello ${user.name}","Thank you for your help!!!");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language_rounded),
                      title: Text("${user.webUrl}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        LauncherUtils.openWebsite(user.webUrl!);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.handshake_rounded),
                      title: Text("Joined On ${user.getJoinedOn()}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                    const SizedBox(height: 32,),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Something went wrong !!!"),);
        },
      ),
    ));
  }
}
