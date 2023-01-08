import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/ui/dashboard/donor/donor_dashboard_data/donor_dashboard_data_cubit.dart';
import 'package:helpfeed2/ui/user_profile/user_profile.dart';
import 'package:helpfeed2/widgets/user_view.dart';

class DonorDashboardData extends StatefulWidget {
  const DonorDashboardData({Key? key}) : super(key: key);

  @override
  State<DonorDashboardData> createState() => _DonorDashboardDataState();
}

class _DonorDashboardDataState extends State<DonorDashboardData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Receivers",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        BlocBuilder<DonorDashboardDataCubit, DonorDashboardDataState>(
            builder: (context, state) {
          if (state is Error) {
            return Center(
              child: Text(state.msg),
            );
          }
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ReceivedData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  UserModel user = state.data[index];
                  return UserView(
                      userModel: user,
                      onClick: () {
                        Navigator.pushNamed(context, "/userProfile",
                            arguments: user.userId);
                      },
                      onCallClick: () {});
                });
          }
          return Container();
        }),
      ],
    );
  }

  @override
  void initState() {
    BlocProvider.of<DonorDashboardDataCubit>(context).fetchData();
  }
}
