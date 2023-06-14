import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data Layer/ManageVaccinationModel/VaccinationRegistrationModel.dart';
import '../../Services Layer/ManageVaccinationUserController/userVaccinationRegistration_bloc.dart';
import 'ViewVaccinationRegistration.dart';


class VaccinationRegistrationPage extends StatelessWidget {
  const VaccinationRegistrationPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _name = TextEditingController();
    TextEditingController _icnum = TextEditingController();
    TextEditingController _date = TextEditingController();
    TextEditingController _time = TextEditingController();
    TextEditingController _location = TextEditingController();
    final UserVaccinationRegistrationBloc regBloc = UserVaccinationRegistrationBloc();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Register COVID-19 Vaccine'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocProvider(
              create: (_) => regBloc,
              child:  ListView(
                children: [
                  const SizedBox(height: 30,),
                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 10, right: 10,top: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Personal Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),),
                                
                                TextFormField(
                                  controller: _name,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter full name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter full name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                               
                                TextFormField(
                                  controller: _icnum,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter identity card no.',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter I/C no.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                // Vaccination Date
                                TextFormField(
                                  controller: _date,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Select vaccination date',
                                  ),
                                  onTap: () async {
                                    // Show date picker and set selected date to the text field
                                    final DateTime? selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2024),
                                    );
                                    if (selectedDate != null) {
                                      _selectedDate.text = selectedDate.toString();
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a date';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                // Vaccination Time
                                TextFormField(
                                  controller: _time,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Select vaccination time',
                                  ),
                                  onTap: () async {
                                    // Show time picker and set

                                TextFormField(
                                controller: _location,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter location',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter location';
                                  }
                                  return null;
                                },
                                ),
                                const SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      70, 30, 70, 10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        //add to model
                                        VaccinationRegistrationModel regModel = VaccinationRegistrationModel(
                                            name: _name.text,
                                            icnum: _icnum.text,
                                            );

                                        //add to bloc
                                        regBloc
                                            .add(InsertRegData(regModel));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Data Added Successfully'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );

                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => const ViewRegistrationPage()),
                                      );

                                      }
                                     
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ],
              ),),
        ),
      ),
    );
  }
}
