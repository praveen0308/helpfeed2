import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpfeed2/local/app_storage.dart';
import 'package:helpfeed2/ui/donate/donate_screen_cubit.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:helpfeed2/utils/toaster.dart';

import 'package:intl/intl.dart';

import '../../models/request_model.dart';
import '../address_detail/address_detail_screen.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

enum ExpiryType { temp, fixed }

class _DonateScreenState extends State<DonateScreen> {
  late String? name;
  late String? personName;
  late String? contact;
  var _type = ExpiryType.temp;
  final TextEditingController _description = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _noOfDays = TextEditingController();
  final TextEditingController _pickupLocation = TextEditingController();
  DateTime _validTill = DateTime.now();
  late LatLng _pickupLatLong;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _validTill,
        firstDate: _validTill,
        lastDate: DateTime(2032));
    if (picked != null && picked != _validTill) {
      setState(() {
        _validTill = picked;
      });
    }
  }


  @override
  void initState() {
    AppStorage.getName().then((value) => name=value);
    AppStorage.getPersonName().then((value) => personName=value);
    AppStorage.getPhoneNumber().then((value) => contact=value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Donate"),
      ),
      body: BlocListener<DonateScreenCubit, DonateScreenState>(
        listener: (context, state) {
          if (state is Error) {
            showToast(state.msg, ToastType.error);
          }
          if (state is SuccessfullyDonated) {
            showToast("Donation raised successfully !!!", ToastType.success);
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Description"),
                TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text("Quantity(No. of plates/serves)"),
                TextFormField(
                  controller: _qty,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                      counterText: null,
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<ExpiryType>(
                        title: const Text('Days'),
                        value: ExpiryType.temp,
                        groupValue: _type,
                        onChanged: (ExpiryType? value) {
                          setState(() {
                            _validTill = DateTime.now();
                            _type = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<ExpiryType>(
                        title: const Text('Fixed'),
                        value: ExpiryType.fixed,
                        groupValue: _type,
                        onChanged: (ExpiryType? value) {
                          setState(() {
                            _validTill = DateTime.now();
                            _type = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _type == ExpiryType.temp,
                  child: TextFormField(
                    controller: _noOfDays,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (v) {
                      setState(() {
                        if (v.isNotEmpty) {
                          _validTill = DateTime(_validTill.year,
                              _validTill.month, _validTill.day + int.parse(v));
                        } else {
                          _validTill = DateTime.now();
                        }
                      });
                    },
                    decoration: const InputDecoration(
                        counterText: null,
                        border: OutlineInputBorder(borderSide: BorderSide())),
                  ),
                ),
                Visibility(
                  visible: _type == ExpiryType.fixed,
                  child: OutlinedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: const Text("Pick Date")),
                ),
                const Text("Valid till"),
                Text(
                  DateFormat('dd MMM yyyy').format(_validTill),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                    onPressed: () async {
                      LatLng result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressDetailScreen()));
                      _pickupLatLong = result;
                    },
                    child: const Text("Get Pickup Location")),
                const SizedBox(
                  height: 16,
                ),
                const Text("Pickup Location"),
                TextFormField(
                  controller: _pickupLocation,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 32,
                ),
                BlocBuilder<DonateScreenCubit, DonateScreenState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<DonateScreenCubit>(context)
                              .addDonation(
                            RequestModel(
                                raisedBy:
                                    FirebaseAuth.instance.currentUser!.email,
                                acceptedBy: null,
                                description: _description.text,

                                expireOn: _validTill.millisecondsSinceEpoch,
                                addedOn: DateTime.now().millisecondsSinceEpoch,
                                pickupLocation: {
                                  "lat": _pickupLatLong.latitude,
                                  "long": _pickupLatLong.longitude,
                                  "address": _pickupLocation.text
                                },
                                quantity: int.parse(_qty.text),
                                status: RequestStatus.raised.name,
                                contact: contact,
                                name: name,
                                owner: personName,
                                isCancel: false),
                          );
                        },
                        child: const Text("Donate Now"));
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
