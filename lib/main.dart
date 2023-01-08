import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/dashboard/dashboard_cubit.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_details_cubit.dart';
import 'package:helpfeed2/ui/splash/splash_cubit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';
import 'package:helpfeed2/route/route.dart' as route;
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }


        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);


            showSimpleNotification(
              Text(message.notification!.title!),
              subtitle: Text(message.notification!.body!),
              background: Colors.white
            );

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);

          showSimpleNotification(
            Text(message.notification!.title!),
            subtitle: Text(message.notification!.body!),
              background: Colors.white
          );
        }
      },
    );
  }


  void _lightStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _lightStatusAndNavigationBar();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => BasicDetailsCubit()),
        BlocProvider(create: (context) => DashboardCubit()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          title: 'Help Feed',
          theme: ThemeData(
            buttonTheme: ButtonThemeData(
                buttonColor: AppColors.primaryDarkest,
                textTheme: ButtonTextTheme.accent,
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(secondary: Colors.white)),
            iconTheme: const IconThemeData(color: AppColors.primaryDarkest),
            primarySwatch: AppColors.primarySwatchColor,
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: Colors.transparent,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: AppColors.primaryDarkest,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                iconTheme:
                    IconThemeData(color: AppColors.primaryDarkest, size: 32)),
          ).copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      shape:
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),

                          )
                      ,
                      primary: AppColors.primaryDarkest,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      onPrimary: AppColors.white))),
          initialRoute: route.splashScreen,
          onGenerateRoute: route.controller,
        ),
      ),
    );
  }
}
