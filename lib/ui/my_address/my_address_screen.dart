import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpfeed2/models/address_model.dart';
import 'package:helpfeed2/ui/my_address/my_address_cubit.dart';
import 'package:helpfeed2/utils/toaster.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _state = TextEditingController();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
            child: BlocListener<MyAddressCubit, MyAddressState>(
              listener: (context, state) {
                if (state is StoredSuccessfully) {
                  showToast("Stored successfully !!!", ToastType.success);
                  Navigator.pushReplacementNamed(context, "/dashboard");
                }
                if (state is Error) {
                  showToast("Failed!!!", ToastType.error);
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [



                      TextFormField(
                        controller: _addressLine1,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            label: Text("Address Line 1"),
                            border: OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      TextFormField(
                        controller: _addressLine2,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            label: Text("Address Line 2"),
                            border: OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      TextFormField(
                        controller: _city,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            label: Text("City"),
                            border: OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      TextFormField(
                        controller: _pinCode,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                            label: Text("Pin Code"),
                            border: OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _state,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            label: Text("State"),
                            border: OutlineInputBorder(borderSide: BorderSide())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<MyAddressCubit, MyAddressState>(
                        builder: (context, state) {
                          if (state is Loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                              onPressed: () async {
                                String line1 = _addressLine1.text;
                                String line2 = _addressLine2.text;
                                String city = _city.text;
                                int pinCode = int.parse(_pinCode.text);
                                String state = _state.text;
                                _determinePosition().then((position) => BlocProvider.of<MyAddressCubit>(context)
                                    .storeAddressDetails(AddressModel(
                                    addressLine1: line1,
                                    addressLine2: line2,
                                    city: city,
                                    pincode: pinCode,
                                    state: state,
                                    longitude: position.longitude,
                                    latitude: position.latitude
                                )));


                              },
                              child: const Text("Submit"));
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
