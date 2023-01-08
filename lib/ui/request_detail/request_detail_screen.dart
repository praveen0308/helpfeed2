import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/request_detail/request_detail_screen_cubit.dart';
import 'package:helpfeed2/ui/user_profile/user_profile.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:helpfeed2/utils/launcher_utils.dart';
import 'package:helpfeed2/utils/toaster.dart';

import '../../utils/util_methods.dart';

class RequestDetailScreen extends StatefulWidget {
  final RequestModel request;

  const RequestDetailScreen({Key? key, required this.request})
      : super(key: key);

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  late RequestModel request;

  @override
  void initState() {
    request = widget.request;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
      ),
      body: BlocConsumer<RequestDetailScreenCubit, RequestDetailScreenState>(
        listener: (context, state) {
          if (state is AcceptedSuccessfully) {
            showToast("Accepted Successfully!!!", ToastType.success);
            BlocProvider.of<RequestDetailScreenCubit>(context)
                .getRequestById(request.requestID!);
          }
          if (state is ReceivedDetail) {
            request = state.requestModel;
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 55,
                    child: Text(
                      request.name![0],
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  Text(
                    request.name!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Text(request.pickupLocation!["address"],
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(request.quantity.toString()),
                          const Icon(
                            Icons.person,
                            size: 32,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(request.getDuration()),
                          const Icon(
                            Icons.timelapse,
                            size: 32,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("${request.distance.toStringAsFixed(2)} KM"),
                          const Icon(
                            Icons.location_on,
                            size: 32,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton.icon(
                        onPressed: () {
                          UtilMethods.openPhone(request.contact ?? "");
                        },
                        label: const Text("Call"),
                        icon: const Icon(Icons.call),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ElevatedButton.icon(
                        onPressed: () {
                          LauncherUtils.openMap(request.pickupLocation!["lat"],
                              request.pickupLocation!["long"]);
                        },
                        icon: const Icon(
                          Icons.location_searching,
                          color: Colors.black,
                        ),
                        label: const Text("Locate",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFF8F8FA),
                        ),
                      ))
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(request.description ?? "No Description"),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state is Accepting)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state is! Accepting &&
                      request.status == RequestStatus.raised.name)
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RequestDetailScreenCubit>(context)
                              .acceptRequest(request.requestID!);
                        },
                        child: const Text("Accept")),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const Text("User Details"),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text("${request.owner}"),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Navigator.pushNamed(context, "/userProfile",
                          arguments: request.raisedBy);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: Text(request.contact ?? "N.A."),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      LauncherUtils.openPhone(request.contact!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
