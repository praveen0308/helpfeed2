import 'dart:convert';
import 'package:http/http.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:meta/meta.dart';

part 'donate_screen_state.dart';

class DonateScreenCubit extends Cubit<DonateScreenState> {
  DonateScreenCubit() : super(DonateScreenInitial());

  Future<void> addDonation(RequestModel requestModel) async {
    emit(Loading());
    CollectionReference colUsers =
    FirebaseFirestore.instance.collection('requests');

    colUsers.add(requestModel.toMap()).then((value) async {
      await makePostRequest(requestModel);
      emit(SuccessfullyDonated());
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }



  Future<bool> makePostRequest(RequestModel request) async {

    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {'Authorization':'key=AAAAyU5Zkbw:APA91bGBufVG1rFm_7bNauWiVCGpmdsCm54_LC5fnxfLPD1KDn_KJPjXe7Fle2cnuQoHUBkjRp6-cGyPrdKHyoHu_dKY5KBTMTE-xg13jWTu9LsktccFLN9KO3R9fFqIQbmeOkzHXEaQ','Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "to":"/topics/receiver",
      "notification":{
        "title":"New Donation",
        "body":"${request.description} by ${request.name}",
        "sound":"default"
      }
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    debugPrint("Status Code >> $statusCode");
    debugPrint("Response Body >> $responseBody");
    return statusCode==200;
  }
}
