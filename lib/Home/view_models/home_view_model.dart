import 'package:doctor_consulting_app/Home/services/patient_list_service.dart';
import 'package:doctor_consulting_app/onboarding/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../common/shared_utils.dart';
import '../models/patient_list_model.dart';


class HomeViewModel extends ChangeNotifier {
  List<Patient>? patientList ;
  PatientListModel? patientListModel;
  bool inProgress = false;
  bool apiCompleted = false;
  getPatientList(BuildContext context ,String? token)  async {
    changeShimmer(true);
    notifyListeners();
    if(token != null) {
      PatientListService.getPatientList(token).then((value) {
        if (value != null && value.message == "Success") {
          patientListModel = value;
          patientList = [];
          for (var data in value.patient!) {
            patientList!.add(data);
            print("patient list data ${patientList!.first.user}");
            apiCompleted = true;
            changeShimmer(false);
            notifyListeners();
          }

        } else {
          print("no data found");
        }
        notifyListeners();
      });
    }
    changeShimmer(true);
  }
  String formatDate(String dateTime) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateTime));
  }

  changeShimmer(bool value) {
    inProgress = value;
  }
}