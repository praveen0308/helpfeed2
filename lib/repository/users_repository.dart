import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpfeed2/models/user_model.dart';

class UserRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> checkUserRegistered(User user) async {
    CollectionReference colUsers =
        FirebaseFirestore.instance.collection('users');
    var result = await colUsers.doc(user.email).get();
    return result.exists;
  }

  Future<dynamic> addNewUser(UserModel userModel) {
    CollectionReference colUsers =
        FirebaseFirestore.instance.collection('users');
    return colUsers
        .doc(userModel.email)
        .set(userModel.toMap())
        .then((value) => true)
        .catchError((error) => error);
  }
}
