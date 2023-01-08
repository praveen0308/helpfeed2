import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/ui/dashboard/receiver/receiver_dashboard_data/receiver_dashboard_data_cubit.dart';

import '../../../../utils/util_methods.dart';
import '../../../../widgets/request_view.dart';

class ReceiverDashboardData extends StatefulWidget {
  const ReceiverDashboardData({Key? key}) : super(key: key);

  @override
  State<ReceiverDashboardData> createState() => _ReceiverDashboardDataState();
}

class _ReceiverDashboardDataState extends State<ReceiverDashboardData> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Recent Requests",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        BlocBuilder<ReceiverDashboardDataCubit, ReceiverDashboardDataState>(
            builder: (context, state) {
              if(state is Error){
                return Center(child: Text(state.msg),);
              }
              if(state is LoadingRequests){
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is NoRequests) {
                return const Center(
                  child: Text("No Requests"),
                );
              }
              if (state is ReceivedRequests) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RequestView(
                      request: state.requests[index],
                      onClick: () {
                        Navigator.pushNamed(context, "/requestDetails",
                            arguments: state.requests[index]);
                      },
                      onCallClick: () {
                        UtilMethods.openPhone(state.requests[index].contact??"");
                      },
                    );
                  },
                  itemCount: state.requests.length,
                );
              }

              return Container();
            }),
      ],
    );
  }

  @override
  void initState() {
    BlocProvider.of<ReceiverDashboardDataCubit>(context).fetchRequests();
    super.initState();
  }
}
