import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpfeed2/models/address_model.dart';
import 'package:intl/intl.dart';

class UserModel{
  String? userId;
  String? role;
  String? category;
  String? name;
  String? personName;
  List<dynamic>? contacts;
  String? email;
  String? webUrl;
  String? description;
  List<dynamic>? images;
  List<dynamic>? docs;
  AddressModel? address;
  int? joinedOn;
  bool? isActive;
  int? donationCount;

  UserModel({
    this.userId,
    this.role,
    this.category,
    this.name,
    this.personName,
    this.contacts,
    this.email,
    this.webUrl,
    this.description,
    this.images,
    this.docs,
    this.address,
    this.joinedOn,
    this.isActive});

  String getJoinedOn() => DateFormat('MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(joinedOn!));
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'role': role,
      'category': category,
      'name': name,
      'personName': personName,
      'contacts': contacts,
      'email': email,
      'webUrl': webUrl,
      'description': description,
      'images': images,
      'docs': docs,
      'address': address,
      'joinedOn': joinedOn,
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      role: map['role'] as String,
      category: map['category'] as String,
      name: map['name'] as String,
      personName: map['personName'] as String,
      contacts: map['contacts'] as List<String>,
      email: map['email'] as String,
      webUrl: map['webUrl'] as String,
      description: map['description'] as String,
      images: map['images'] as List<String>,
      docs: map['docs'] as List<String>,
      address: map['address'] as AddressModel,
      joinedOn: map['joinedOn'] as int,
      isActive: map['isActive'] as bool,
    );
  }

  factory UserModel.fromDSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String,dynamic>;
    return UserModel(
      userId: map['userId'] as String?,
      role: map['role'] as String?,
      category: map['category'] as String?,
      name: map['name'] as String?,
      personName: map['personName'] as String?,
      contacts: map['contacts'] as List<dynamic>?,
      email: map['email'] as String?,
      webUrl: map['webUrl'] as String?,
      description: map['description'] as String?,
      images: map['images'] as List<dynamic>?,
      docs: map['docs'] as List<dynamic>?,
      address: AddressModel.fromMap(map['address']),
      joinedOn: map['joinedOn'] as int?,
      isActive: map['isActive'] as bool?,
    );
  }

  factory UserModel.fromQSnapshot(QueryDocumentSnapshot snapshot,String userId) {

    return UserModel(
      userId: userId,
      role: snapshot.get("role"),
      category: snapshot.get("category"),
      name: snapshot.get("name"),
      personName: snapshot.get('personName'),
      contacts: snapshot.get('contacts'),
      email: snapshot.get('email'),
      webUrl: snapshot.get('webUrl'),
      description: snapshot.get('description'),
      images: [],
      docs: [],
      address: AddressModel.fromMap(snapshot.get("address")),
      joinedOn: snapshot.get("joinedOn"),
      isActive: true,
    );
  }


}