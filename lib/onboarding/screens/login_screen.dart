 import 'package:doctor_consulting_app/onboarding/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';

import '../../Home/screens/patients_list_screen.dart';
import '../../Home/view_models/home_view_model.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
  return LoginScreenState();
  }

}

class LoginScreenState  extends State<LoginScreen>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Consumer<LoginViewModel>(
     builder: (context, snapshot, _) {
       return Scaffold(
         backgroundColor: Colors.white,
         resizeToAvoidBottomInset: true,
         body: SingleChildScrollView(
           child: Center(
             child: Padding(
               padding: const EdgeInsets.only(bottom: 80.0,),
               child: Container(
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Spacer(),
                     Stack(
                       alignment: Alignment.center,
                       children: [
                       Image.asset("assets/images/img_2.png", height: 217,width: 617,),
                       Image.asset("assets/images/img.png", height: 84,width: 80,)
                     ], ), // Replace with your logo asset

                     const Padding(
                       padding: EdgeInsets.only(left: 18.0),
                       child: Text(
                         'Login Or Register To Book Your Appointments',
                         textAlign: TextAlign.start,
                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       ),
                     ),
                     const SizedBox(height: 20),
                      Padding(
                       padding: const EdgeInsets.only(left: 18.0,right: 18),
                       child: TextField(
                         controller: snapshot.userNameController,
                         decoration: const InputDecoration(
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(12))                   ),
                           labelText: 'Enter your E-mail',
                             labelStyle: TextStyle(
                                 fontFamily:"inter",
                                 fontSize: 14
                             )

                         ),
                       ),
                     ),
                     const SizedBox(height: 10),
                      Padding(
                       padding: const EdgeInsets.only(left: 18.0,right: 18),
                       child: TextField(
                         controller: snapshot.passwordController,
                         decoration: const InputDecoration(
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(12))),
                           labelText: 'Enter your Password',
                           labelStyle: TextStyle(
                             fontFamily:"inter",
                             fontSize: 14
                           )
                         ),
                         obscureText: true,
                       ),
                     ),
                     const SizedBox(height: 25),
                     InkWell(
                       onTap: (){
                         context.read<LoginViewModel>().getUserLogged(context);
                        // if(context.read<HomeViewModel>().apiCompleted){
                           Navigator.push(context, MaterialPageRoute(builder: (context) =>  const PatientListScreen()));
                         //}
                       },
                       child: Container(
                         width: 355,
                         height: 50,
                         decoration: const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(12)),
                           color: Color(0xFF006837)
                         ),
                         child: const Center(child: Text("Login",style: TextStyle(
                           color: Colors.white
                         ),)),
                       ),
                     ),
                     Spacer(),
                     const Padding(
                       padding: EdgeInsets.only(left: 18.0,right: 18),
                       child: Text(
                         'By creating or logging into an account you are agreeing with our',
                         textAlign: TextAlign.center,
                       ),
                     ),
                     GestureDetector(
                       onTap: () {
                         // Add your terms and conditions navigation here
                       },
                       child: const Text(
                         'Terms and Conditions',
                         style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                       ),
                     ),
                     Text(' and '),
                     GestureDetector(
                       onTap: () {
                         // Add your privacy policy navigation here
                       },
                       child: const Text(
                         'Privacy Policy',
                         style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                       ),
                     ),
                     SizedBox(height: 20),
                   ],
                 ),
               ),
             ),
           ),
         ),
       );
     }
   );  }
}