import 'package:doctor_consulting_app/Home/screens/billing_screen.dart';
import 'package:doctor_consulting_app/Home/view_models/patient_details_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:doctor_consulting_app/Home/models/branch_list_model.dart' as branchModel;
import 'package:doctor_consulting_app/Home/models/treatment_list_model.dart' as treatmentModel;

import '../models/branch_list_model.dart';
import '../models/treatment_list_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wtspNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _discountAmntController = TextEditingController();
  final TextEditingController _advanceAmntController = TextEditingController();
  final TextEditingController _balanceAmntController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? selectedLocation;
  String? selectedBranch;
  List<String> locations = ['Location 1', 'Location 2'];
  List<String> branches = ['Branch 1', 'Branch 2'];
  List<String> treatments = ['Couple Combo Package'];
  int maleCount = 1;
  int femaleCount = 1;
  treatmentModel.Treatment ? selectedTreatment ; // Use the prefixed class name here
  List<String>? items = ["Kumarakom","Edappaly","Kozhikode","Alappuzha"];
  List<String>? selectedData = [];
  String? cash;
  String? card;
  String? upi;
  bool isRadioCashEnabled = true;
  bool isRadioCardEnabled = true;
  bool isRadioUpiEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField('Name', 'Enter your full name',_nameController),
              buildTextField('Whatsapp Number', 'Enter your Whatsapp number',_wtspNoController),
              buildTextField('Address', 'Enter your address',_addressController),
              buildDropdown('Location', 'Choose your location', locations, selectedLocation, (String? newValue) {
                setState(() {
                  selectedLocation = newValue;
                });
              }),
            buildDropdown1('Branch', 'Select the branch', locations, selectedBranch, (String? newValue) {
                setState(() {
                  selectedBranch = newValue;
                });
              },
            ),
              Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choose Treatment',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<Treatment>(
                      isExpanded: true,
                      padding: EdgeInsets.zero,
                      value: selectedTreatment,
                      hint: const Text('Choose preferred treatment'),
                      items: context.read<PatientDetailViewModel>().treatmentList!.map((Treatment value) {
                        return DropdownMenuItem<Treatment>(
                          value: value,
                          child: Text(value.name!,),
                        );
                      }).toList(),
                      onChanged: (Treatment? newValue) {
                        setState(() {
                          selectedTreatment = newValue;
                          print("selectedTreatment $selectedTreatment");
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Patients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Male'),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (maleCount > 0) maleCount--;
                            });
                          },
                        ),
                        Text(maleCount.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              maleCount++;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Female'),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (femaleCount > 0) femaleCount--;
                            });
                          },
                        ),
                        Text(femaleCount.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              femaleCount++;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        selectedData!.add(maleCount.toString());
                        selectedData!.add(femaleCount.toString());
                        selectedData!.add(selectedTreatment!.name!);

                        print("list data $selectedData");
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: Colors.green,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              buildTextField('Total Amount', 'Enter total amount',_totalController),
              buildTextField('Discount Amount', 'Enter discount amount',_discountAmntController),
              buildPaymentOption(),
              buildTextField('Advance Amount', 'Enter advance amount',_advanceAmntController),
              buildTextField('Balance Amount', 'Enter balance amount',_balanceAmntController),
              buildDatePicker(context),
              buildTimePicker(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   BillingScreen(
                  name: _nameController.text,
                  whatsappNumber: _wtspNoController.text,
                  address: _addressController.text,
                  location: selectedLocation.toString(),
                  branch: selectedBranch.toString(),
                  treatments: selectedData!.toList(),
                      totalAmount: _totalController.text,
                      discount: _discountAmntController.text,
                      advance: _advanceAmntController.text,
                      balance: _balanceAmntController.text

                  )));
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String label, String hint ,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, String hint, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(

        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        hint: Text(hint),
        value: selectedItem,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildDropdown1(String label, String hint, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        hint: Text(hint),
        value: selectedItem,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
  Widget buildTreatmentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Treatments'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: context.read<PatientDetailViewModel>().treatmentList!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(context.read<PatientDetailViewModel>().treatmentList![index].name!),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Male'),
                        SizedBox(width: 0),
                        buildCounter(maleCount, (value) {
                          setState(() {
                            maleCount = value;
                          });
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Female'),
                        SizedBox(width: 0),
                        buildCounter(femaleCount, (value) {
                          setState(() {
                            femaleCount = value;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      treatments.removeAt(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Add treatment logic here
          },
          child: Text('+ Add Treatments'),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
      ],
    );
  }

  Widget buildCounter(int count, ValueChanged<int> onChanged) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            if (count > 0) {
              onChanged(count - 1);
            }
          },
        ),
        Text('$count'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onChanged(count + 1);
          },
        ),
      ],
    );
  }

  Widget buildPaymentOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Option'),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Cash',),
                  value: "cash",
                  groupValue: cash,
                  onChanged: isRadioCashEnabled
                      ? (String? value) {
                    setState(() {
                      cash = value;
                      print("cash$cash");
                    });
                  }
                      : null,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('Card'),
                  value: 'Card',
                  groupValue: cash,
                  onChanged:   isRadioCashEnabled
                      ? (String? value) {
                    setState(() {
                      cash = value;
                    });
                  }
                  : null,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text('UPI'),
                  value: 'UPI',
                  groupValue: cash,
                  onChanged: isRadioCashEnabled
                      ? (String? value) {
                    setState(() {
                      cash = value;
                    });
                  }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: 'Treatment Date',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              _dateController.text = formattedDate;
            });
          }
        },
      ),
    );
  }

  Widget buildTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _timeController,
        decoration: InputDecoration(
          labelText: 'Treatment Time',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.access_time),
        ),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            String formattedTime = pickedTime.format(context);
            setState(() {
              _timeController.text = formattedTime;
            });
          }
        },
      ),
    );
  }
  Widget renderTreatment(BuildContext context){
 return  AlertDialog(
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
   content: Container(
     width: double.maxFinite,
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Text(
           'Choose Treatment',
           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
         ),
         SizedBox(height: 10),
         context.read<PatientDetailViewModel>().treatmentList != null ?
         DropdownButtonFormField<Treatment>(
           value: selectedTreatment,
           hint: Text('Choose preferred treatment'),
           items: context.read<PatientDetailViewModel>().treatmentList!.map((Treatment value) {
             return DropdownMenuItem<Treatment>(
               value: value,
               child: Text(value.name!,),
             );
           }).toList(),
           onChanged: (Treatment? newValue) {
             setState(() {
               selectedTreatment = newValue;
               print("selectedTreatment $selectedTreatment");
             });
           },
         ) : Container(),
         SizedBox(height: 20),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Add Patients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           ],
         ),
         SizedBox(height: 10),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Male'),
             IconButton(
               icon: Icon(Icons.remove),
               onPressed: () {
                 setState(() {
                   if (maleCount > 0) maleCount--;
                 });
               },
             ),
             Text(maleCount.toString()),
             IconButton(
               icon: Icon(Icons.add),
               onPressed: () {
                 setState(() {
                   maleCount++;
                 });
               },
             ),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Female'),
             IconButton(
               icon: Icon(Icons.remove),
               onPressed: () {
                 setState(() {
                   if (femaleCount > 0) femaleCount--;
                 });
               },
             ),
             Text(femaleCount.toString()),
             IconButton(
               icon: Icon(Icons.add),
               onPressed: () {
                 setState(() {
                   femaleCount++;
                 });
               },
             ),
           ],
         ),
         SizedBox(height: 20),
         ElevatedButton(
           onPressed: () {
             selectedData!.add(maleCount.toString());
             selectedData!.add(femaleCount.toString());
             selectedData!.add(selectedTreatment!.name!);

             print("list data $selectedData");
           },
           child: Text('Save'),
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
             ),
             primary: Colors.green,
             onPrimary: Colors.white,
           ),
         ),
       ],
     ),
   ),
 );
  }

}
class SelectedData {
  final int maleCount;
  final int femaleCount;
  final treatmentModel.Treatment? selectedTreatment;

  SelectedData({
    required this.maleCount,
    required this.femaleCount,
    required this.selectedTreatment,

  });
}

class PatientData {
  final String name;
  final String whatsappNumber;
  final String address;
  final String location;
  final String branch;
  final List<String> treatments;
  final String totalAmount;
  final String discount;
  final String advance;
  final String balance;

  PatientData({
    required this.name,
    required this.whatsappNumber,
    required this.address,
    required this.location,
    required this.branch,
    required this.treatments,
    required this.totalAmount,
    required this.discount,
    required this.advance,
    required this.balance,
  });
}




