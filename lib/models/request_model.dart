import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/utils/date_time_helper.dart';
import 'package:intl/intl.dart';

import '../res/app_colors.dart';

class RequestModel {
  String? requestID;
  String? raisedBy;
  String? acceptedBy;
  String? description;
  int? expireOn;
  int? addedOn;
  Map<String, dynamic>? pickupLocation;
  int? quantity;
  String? status;
  String? contact;
  String? owner;
  String? name;
  bool? isCancel;
  double distance=0.0;

  RequestModel(
      {this.requestID,
      this.raisedBy,
      this.acceptedBy,
      this.description,
      this.expireOn,
      this.addedOn,
      this.pickupLocation,
      this.quantity,
      this.status,
      this.contact,
      this.owner,
      this.name,
      this.isCancel});

  String getDuration() => DateTimeHelper.prettyDuration(
      expireOn! - DateTime.now().millisecondsSinceEpoch);

  String getDistance() => "${distance.toStringAsFixed(2)} KM";

  Color getBackgroundColor() {
    switch (status) {
      case "raised":
        return AppColors.warningLight;
      case "accepted":
        return AppColors.successLight;
      case "expired":
        return AppColors.errorLight;
      case "closed":
        return AppColors.greyLight;
      default:
        return Colors.white;
    }
  }


  Color getForegroundColor() {
    switch (status) {
      case "raised":
        return AppColors.warningDark;
      case "accepted":
        return AppColors.successDark;
      case "expired":
        return AppColors.error;
      case "closed":
        return AppColors.greyDarkest;
      default:
        return Colors.white;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'requestID': this.requestID,
      'raisedBy': this.raisedBy,
      'acceptedBy': this.acceptedBy,
      'description': this.description,
      'expireOn': this.expireOn,
      'addedOn': this.addedOn,
      'pickupLocation': this.pickupLocation,
      'quantity': this.quantity,
      'status': this.status,
      'contact': this.contact,
      'owner': this.owner,
      'name': this.name,
      'isCancel': this.isCancel,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map, String requestId) {
    return RequestModel(
      requestID: requestId,
      raisedBy: map['raisedBy'] as String?,
      acceptedBy: map['acceptedBy'] as String?,
      description: map['description'] as String?,
      expireOn: map['expireOn'] as int?,
      addedOn: map['addedOn'] as int?,
      pickupLocation: map['pickupLocation'] as Map<String, dynamic>?,
      quantity: map['quantity'] as int?,
      status: map['status'] as String?,
      contact: map['contact'] as String?,
      owner: map['owner'] as String?,
      name: map['name'] as String?,
      isCancel: map['isCancel'] as bool?,
    );
  }

  factory RequestModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot snapshot, String requestId) {
    return RequestModel(
      requestID: requestId,
      raisedBy: snapshot.get("raisedBy") as String?,
      acceptedBy: snapshot.get('acceptedBy') as String?,
      description: snapshot.get('description') as String?,
      expireOn: snapshot.get('expireOn') as int?,
      addedOn: snapshot.get('addedOn') as int?,
      pickupLocation: snapshot.get('pickupLocation') as Map<String, dynamic>?,
      quantity: snapshot.get('quantity') as int?,
      status: snapshot.get('status') as String?,
      contact: snapshot.get('contact') as String?,
      owner: snapshot.get('owner') as String?,
      name: snapshot.get('name') as String?,
      isCancel: snapshot.get('isCancel') as bool?,
    );
  }
}
