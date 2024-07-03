import 'package:doctor_consulting_app/Home/screens/registration_screen.dart';
import 'package:doctor_consulting_app/Home/view_models/home_view_model.dart';
import 'package:doctor_consulting_app/Home/view_models/patient_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientListScreen extends StatefulWidget{
  const PatientListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
   return PatientListScreenState();
  }

}

class PatientListScreenState  extends State<PatientListScreen>{
  @override
  void initState() {
   // context.read<HomeViewModel>().getPatientList(context);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back),
            actions: const [
              Icon(Icons.notifications),
            ],
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search for treatments',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('Search'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sort by :'),
                    DropdownButton<String>(
                      value: 'Date',
                      items: <String>['Date', 'Name'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
            Expanded(
                  child: Stack(
                    children:[
                      Consumer<HomeViewModel>(
                        builder: (context, snapshot ,_) {
                          return  snapshot.patientList != null && snapshot.patientList!.isNotEmpty && !snapshot.inProgress ?
                          Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: snapshot.patientList!.length, // Number of items
                                  itemBuilder: (context, index) {
                                    return  BookingCard(
                                      name: snapshot.patientList![index].name!,
                                      package:snapshot.patientList![index].patientdetailsSet!.first.treatmentName != null ? snapshot.patientList![index].patientdetailsSet!.first.treatmentName!: "",
                                      date: snapshot.formatDate(snapshot.patientList![index].createdAt!.toString()) ,
                                      staff: snapshot.patientList![index].user!,
                                    );
                                  },
                                ),
                              )
                            :SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(child: CupertinoActivityIndicator()));;
                        }
                      ),
                      Positioned(
                        bottom: 16.0,
                        right: 0.0,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            context.read<PatientDetailViewModel>().getBranchList(context);
                            context.read<PatientDetailViewModel>().getTreatmentList(context);
                            if(context.read<PatientDetailViewModel>().treatmentApiCompleted){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const RegistrationScreen()));
                          }
    },
                          label: Text('Register Now'),
                          icon: Icon(Icons.person_add),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),
        );

  }

}
class BookingCard extends StatelessWidget {
  final String name;
  final String package;
  final String date;
  final String staff;
  final bool isRegistered;

  BookingCard({super.key,
    required this.name,
    required this.package,
    required this.date,
    required this.staff,
    this.isRegistered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
     // margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(package),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text(date),
                SizedBox(width: 16),
                Icon(Icons.person, size: 16),
                SizedBox(width: 4),
                Text(staff),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('View Booking details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
