import 'package:doctor_consulting_app/Home/services/patient_list_service.dart';
import 'package:doctor_consulting_app/Home/view_models/home_view_model.dart';
import 'package:doctor_consulting_app/onboarding/models/login_model.dart';
import 'package:doctor_consulting_app/onboarding/screens/login_screen.dart';
import 'package:doctor_consulting_app/onboarding/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Home/models/patient_list_model.dart';
import '../../Home/screens/patients_list_screen.dart';
import '../../common/shared_utils.dart';

class LoginViewModel extends ChangeNotifier {
  LoginModel? loginModel;
  List<UserDetails>? loginData;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<Patient>? patientList;
  bool inProgress = false;
  bool apiCompleted = false;
  navigateToLoginScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  getUserLogged(BuildContext context) async {
    LoginRequestModel loginRequestModel = LoginRequestModel();
    loginRequestModel.username = userNameController.text.toString();
    loginRequestModel.password = passwordController.text.toString();
    await LoginService.userLogged(loginRequestModel).then((value) {
      if (value != null && value.token != null) {
        saveLoginDetails(value.token.toString());
        loginModel = value;
        loginData = [];
        loginData!.add(loginModel!.userDetails!);
        print("list data ${loginData!.first.username}");
      } else {
        print("No data found or tableMenuList is null");
      }
    }).then((value) => {
          context.read<HomeViewModel>().getPatientList(context,loginModel!.token)
        });
    notifyListeners();
  }

  saveLoginDetails(String token) {
    SharedUtils.setString("token", token);
  }

  changeShimmer(bool value) {
    inProgress = value;
  }
}
