import 'package:doctor_consulting_app/Home/models/branch_list_model.dart' as branch_list_model;
import 'package:doctor_consulting_app/Home/models/treatment_list_model.dart' as treatment_list_model;
import 'package:doctor_consulting_app/Home/services/branch_list_service.dart';
import 'package:doctor_consulting_app/Home/services/treatment_list_service.dart';
import 'package:doctor_consulting_app/onboarding/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../common/shared_utils.dart';
import '../models/treatment_list_model.dart';

class PatientDetailViewModel extends ChangeNotifier {
  List<branch_list_model.Branch>? branchList;
  List<Treatment>? treatmentList;
  LoginViewModel? _loginViewModel;
  List<String> selectedDataList = [];
  bool treatmentApiCompleted = false;
  getBranchList(BuildContext context) async {
    String token = await SharedUtils.getString("token");
    await BranchListService.fetchBranchList(token).then((value) {
      if (value != null && value.message == "Success") {
        branchList = [];
        for (var branchData in value.branches!) {
          branchList!.add(branchData);
          print("branch data ${branchList!.first.address}");
        }
      } else {
        print("no data found");
      }
    });
    notifyListeners();
  }

  getTreatmentList(BuildContext context)async{
    String token = await SharedUtils.getString("token");
    await TreatmentListService.fetchTreatmentList(token).then((value) {
      if(value != null ){
        treatmentList = [];
        for(var treatmentData in value.treatments!){
          treatmentList!.add(treatmentData);
          print("treatment list data${treatmentList!.first.price}");
          treatmentApiCompleted = true;
        }
      }else{
        print("no data found");
      }
    });
  }


}
