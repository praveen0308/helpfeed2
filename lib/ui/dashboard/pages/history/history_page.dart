import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/ui/dashboard/pages/history/history_page_cubit.dart';
import 'package:helpfeed2/widgets/history_view.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, right: 8, left: 8, bottom: 8),
          child: Text(
            "History",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        const Divider(),
        BlocConsumer<HistoryPageCubit, HistoryPageState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NoHistory) {
                return const Center(
                  child: Text("No History"),
                );
              }
              if (state is ReceivedRequests) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,

                      itemCount: state.requests.length,
                      itemBuilder: (context, index) {
                        return HistoryView(request: state.requests[index], onClick: (){});
                      }),
                );
              }
              return Container();
            })
      ],
    );
  }

  @override
  void initState() {
    BlocProvider.of<HistoryPageCubit>(context).fetchRequests();
    super.initState();
  }
}
