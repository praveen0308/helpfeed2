import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/local/app_storage.dart';
import 'package:helpfeed2/res/app_constants.dart';
import 'package:helpfeed2/ui/dashboard/donor/donor_dashboard_data/donor_dashboard_data.dart';
import 'package:helpfeed2/ui/dashboard/donor/donor_dashboard_data/donor_dashboard_data_cubit.dart';
import 'package:helpfeed2/ui/dashboard/donor/donor_quick_actions.dart';
import 'package:helpfeed2/ui/dashboard/receiver/receiver_dashboard_data/receiver_dashboard_data.dart';
import 'package:helpfeed2/ui/dashboard/receiver/receiver_dashboard_data/receiver_dashboard_data_cubit.dart';

import '../../receiver/receiver_quick_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String role = "";

  @override
  void initState() {
    AppStorage.getRole().then((value) async {

      setState((){
        role = value!;
      });

      await FirebaseMessaging.instance.subscribeToTopic(role);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (role.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${AppConstants.appName}(${role.toUpperCase()})",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            if (role == "receiver") const ReceiverQuickActions(),
            if (role == "donor") const DonorQuickActions(),
            const SizedBox(
              height: 16,
            ),
            if (role == "donor")
              BlocProvider(
                create: (context) => DonorDashboardDataCubit(),
                child: const DonorDashboardData(),
              ),
            if (role == "receiver")
              BlocProvider(
                create: (context) => ReceiverDashboardDataCubit(),
                child: const ReceiverDashboardData(),
              ),

          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator(),);
    }
  }
}
