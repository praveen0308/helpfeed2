import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReviewModel {
  String? reviewId;
  String? title;
  String? description;
  int? addedOn;
  String? addedBy;
  String? name;

  ReviewModel(
      {this.reviewId,
      this.title,
      this.description,
      this.addedOn,
      this.addedBy,
      this.name});
  String getAddedOn() => DateFormat('dd MMM yy').format(DateTime.fromMillisecondsSinceEpoch(addedOn!));
  Map<String, dynamic> toMap() {
    return {
      'reviewId': this.reviewId,
      'title': this.title,
      'description': this.description,
      'addedOn': this.addedOn,
      'addedBy': this.addedBy,
      'name':this.name
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      addedOn: map['addedOn'] as int,
      addedBy: map['addedBy'] as String,
      name: map['name'] as String,
    );
  }

  factory ReviewModel.fromQSnapshot(QueryDocumentSnapshot snapshot,String reviewId) {
    return ReviewModel(
      reviewId: reviewId,
      title: snapshot.get('title') as String,
      description: snapshot.get('description') as String,
      addedOn:snapshot.get('addedOn') as int,
      addedBy: snapshot.get('addedBy') as String,
      name: snapshot.get('name') as String,
    );
  }
}
