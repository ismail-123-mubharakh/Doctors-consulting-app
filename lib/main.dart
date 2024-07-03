
import 'package:doctor_consulting_app/Home/view_models/home_view_model.dart';
import 'package:doctor_consulting_app/Home/view_models/patient_details_view_model.dart';
import 'package:doctor_consulting_app/onboarding/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => PatientDetailViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(

          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
