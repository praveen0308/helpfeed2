import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/res/app_images.dart';


import 'package:helpfeed2/ui/sign_in/sign_in_cubit.dart';
import 'package:helpfeed2/utils/toaster.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8, top: 32, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                image: AssetImage(AppImages.appIcon), width: 200, height: 200,),
              BlocConsumer<SignInCubit, SignInState>(
                listener: (context, state) {


                  if(state is SignInSuccessful){
                    showToast("Successfully logged in !!!",ToastType.success);
                  }
                  if(state is SignInFailed){
                    showToast("Sign In Failed !!!",ToastType.error);
                  }
                  if(state is AlreadyUser){
                    Navigator.pushReplacementNamed(context, "/dashboard");
                  }
                  if(state is NewUserRegistered){
                    Navigator.pushReplacementNamed(context, "/basicDetails");
                  }
                  if(state is ValidationFailed){
                    showToast("Validation Failed !!!",ToastType.error);
                  }

                },
                builder: (context, state) {
                  if(state is SigningIn || state is Validating){
                    return  const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(onPressed: () {
                    // Navigator.pushNamed(context, "/register");
                    BlocProvider.of<SignInCubit>(context).signInWithGoogle();
                  }, child: const Text("Sign In with Google"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
