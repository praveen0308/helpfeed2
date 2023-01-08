import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/ui/dashboard/dashboard_screen.dart';
import 'package:helpfeed2/ui/dashboard/pages/about_us.dart';
import 'package:helpfeed2/ui/donate/donate_screen.dart';
import 'package:helpfeed2/ui/donate/donate_screen_cubit.dart';
import 'package:helpfeed2/ui/edit_profile/edit_profile.dart';
import 'package:helpfeed2/ui/edit_profile/edit_profile_cubit.dart';
import 'package:helpfeed2/ui/foodmap/foodmap_page.dart';
import 'package:helpfeed2/ui/foodmap/foodmap_page_cubit.dart';
import 'package:helpfeed2/ui/helpmap/helpmap_page.dart';
import 'package:helpfeed2/ui/helpmap/helpmap_page_cubit.dart';
import 'package:helpfeed2/ui/images_screen/images_screen.dart';
import 'package:helpfeed2/ui/images_screen/images_screen_cubit.dart';
import 'package:helpfeed2/ui/my_address/my_address_cubit.dart';
import 'package:helpfeed2/ui/my_address/my_address_screen.dart';
import 'package:helpfeed2/ui/post_review/post_review.dart';
import 'package:helpfeed2/ui/post_review/post_review_cubit.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_detail_screen.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_details_cubit.dart';
import 'package:helpfeed2/ui/registration/register_screen.dart';
import 'package:helpfeed2/ui/request_detail/request_detail_screen.dart';
import 'package:helpfeed2/ui/request_detail/request_detail_screen_cubit.dart';
import 'package:helpfeed2/ui/reviews/user_reviews.dart';
import 'package:helpfeed2/ui/reviews/user_reviews_cubit.dart';
import 'package:helpfeed2/ui/search_page/search_page.dart';
import 'package:helpfeed2/ui/search_page/search_page_cubit.dart';
import 'package:helpfeed2/ui/sign_in/sign_in_cubit.dart';
import 'package:helpfeed2/ui/sign_in/sign_in_screen.dart';
import 'package:helpfeed2/ui/splash/splash_cubit.dart';
import 'package:helpfeed2/ui/upload_images/upload_images_cubit.dart';
import 'package:helpfeed2/ui/upload_images/upload_images_screen.dart';
import 'package:helpfeed2/ui/user_profile/user_profile.dart';
import 'package:helpfeed2/ui/user_profile/user_profile_cubit.dart';

import '../ui/splash/splash_screen.dart';

const String splashScreen = '/';
const String signIn = '/signIn';
const String register = '/register';
const String dashboard = '/dashboard';
const String basicDetails = '/basicDetails';
const String uploadImages = '/uploadImages';
const String imagesScreen = '/imagesScreen';
const String myAddress = '/myAddress';
const String donate = '/donate';
const String requestDetails = '/requestDetails';
const String foodMap = '/foodMap';
const String helpMap = '/helpMap';
const String reviews = '/reviews';
const String postReview = '/postReview';
const String searchPage = '/searchPage';
const String userProfile = '/userProfile';
const String aboutUs = '/aboutUs';
const String editProfile = '/editProfile';


Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(
          builder: (context) =>
          const SplashScreen(), settings: settings);
    case signIn:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => SignInCubit(),
                child: const SignInScreen(),
              ), settings: settings);
    case register:
      return MaterialPageRoute(
          builder: (context) => const RegisterScreen(), settings: settings);
    case dashboard:
      return MaterialPageRoute(
          builder: (context) => const DashboardScreen(), settings: settings);
    case basicDetails:
      return MaterialPageRoute(
          builder: (context) =>
          const BasicDetailScreen(), settings: settings);
    case uploadImages:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => UploadImagesCubit(),
                child: UploadImagesScreen(),
              ), settings: settings);
    case imagesScreen:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => ImagesScreenCubit(),
                child: ImagesScreen(),
              ), settings: settings);

    case myAddress:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => MyAddressCubit(),
                child: MyAddress(),
              ), settings: settings);

    case donate:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => DonateScreenCubit(),
                child: DonateScreen(),
              ), settings: settings);
    case requestDetails:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => RequestDetailScreenCubit(),
                child: RequestDetailScreen(request:args as RequestModel),
              ), settings: settings);
    case foodMap:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => FoodMapPageCubit(),
                child: FoodMapPage(),
              ), settings: settings);
    case helpMap:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => HelpMapPageCubit(),
                child: HelpMapPage(),
              ), settings: settings);
    case reviews:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => UserReviewsCubit(),
                child: UserReviews(),
              ), settings: settings);
    case postReview:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => PostReviewCubit(),
                child: PostReview(),
              ), settings: settings);
    case searchPage:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => SearchPageCubit(),
                child: SearchPage(),
              ), settings: settings);
    case userProfile:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => UserProfileCubit(),
                child: UserProfileScreen(userId: args as String),
              ), settings: settings);
    case editProfile:
      return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => EditProfileCubit(),
                child: const EditProfile(),
              ), settings: settings);
    case aboutUs:
      return MaterialPageRoute(
          builder: (context) =>
              const AboutUsScreen());

    default:
      throw ('this route name does not exist');
  }
}
