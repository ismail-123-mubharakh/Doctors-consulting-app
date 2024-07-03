import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_model.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<LoginViewModel>().navigateToLoginScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body: Stack(
       alignment: Alignment.center,
       children:[
         Opacity(
           opacity: 0.5,
           child: Container(
             child: Image.asset(
                 height: MediaQuery.of(context).size.height,
                 width: 1000,
                 "assets/images/img_1.png"
             ),
           ),
         ),
         Container(
           child: Image.asset(
               height: 142,
               width: 134,
               "assets/images/img.png"
           ),
         )
       ]
     )
   );
  }
}