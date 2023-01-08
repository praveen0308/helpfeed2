import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpfeed2/local/app_storage.dart';
import 'package:helpfeed2/models/user_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signInWithGoogle() async {
    emit(SigningIn());
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        emit(SignInSuccessful(user!));
        checkUserRegistered(user);
      } catch (e) {
        emit(SignInFailed());
      }
    }
  }

  Future<void> checkUserRegistered(User user) async {
    emit(Validating());
    CollectionReference colUsers =
        FirebaseFirestore.instance.collection('users');
    colUsers.doc(user.email).get().then((snapshot) async {
      if (snapshot.exists) {
        UserModel  userModel = UserModel.fromDSnapshot(snapshot);
        emit(AlreadyUser());
        await AppStorage.setUserId(user.email!);
        await AppStorage.setCategory(userModel.category!);
        await AppStorage.setRole(userModel.role!);
        await AppStorage.setName(userModel.name!);
        await AppStorage.setPersonName(userModel.personName!);
        await AppStorage.setWebUrl(userModel.webUrl.toString());
        await AppStorage.setDescription(userModel.description.toString());
        await AppStorage.setPhoneNumber(userModel.contacts![0]);
        await AppStorage.storeAddress(userModel.address!);
      } else {
        await addNewUser(user);
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ValidationFailed());
    });
  }

  Future<void> addNewUser(User user) async {
    emit(Validating());
    CollectionReference colUsers =
        FirebaseFirestore.instance.collection('users');
    colUsers.doc(user.email).set({
      "userName": user.displayName,
      "email": user.email,
      "joinedOn": DateTime.now().millisecondsSinceEpoch
    }).then((value) {
      emit(NewUserRegistered());
    }).catchError((error) {
      debugPrint(error);
      emit(ValidationFailed());
    });
  }
}
