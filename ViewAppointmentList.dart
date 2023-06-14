import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_care/Application%20Layer/ManageVaccinationMOHStaffView/AddAppointment.dart';
import 'package:my_care/Application%20Layer/ManageVaccinationMOHStaffView/EditAppointment.dart';

import '../../Services Layer/ManageVaccinationMOHStaffController/MOHStaffAppointment_bloc.dart';



class ViewAppointmentPage extends StatefulWidget {
  const ViewAppointmentPage({Key? key}) : super(key: key);

  @override
  State<ViewAppointmentPage> createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  final AppointmentBloc appointmentBloc = AppointmentBloc();

  //get data when initial this state
  @override
  void initState() {
    appointmentBloc.add(GetAppointmentList());
    super.initState();
  }

  refresh() {
    setState(() {
      initState();
    });
  }

  //refresh when pop
  onGoBack(dynamic value) {
    setState(() {
      initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointment List'),
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          alignment: const FractionalOffset(1.0, 0.3),
          children: [
            Container(
              height: 40.0,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAppointmentPage()),
                  ).then(onGoBack);
                },
                child: const Text('Add More Appointment'),
              ),
            ),
          ],
        ),
        
        body: Container(
          margin: const EdgeInsets.all(8),
          child: BlocProvider(
              create: (_) => appointmentBloc,
              child:
              BlocBuilder<AppointmentBloc, AppointmentState>(builder: (context, state) {
                if (state is AppointmentInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppointmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is IndexAppointmentLoad) {
                  return _UI(
                      context, state.appointmentModel, onGoBack, refresh, appointmentBloc);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
        ),
        


      ),
    );
  }
}


//display list data
Widget _UI(BuildContext context, state, onGoBack, refresh, appointmentBloc) {
  return ListView.builder(
      itemCount: state == null ? 0 : state.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      
                      child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [     
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 8, right: 8),
                                child: Row(children:[
                                  const Text("Name: "),    
                                  Text(
                                  state[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                                ]),
                              ),
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => const UpdateAppointmentPage(),
                                                  settings: RouteSettings(
                                                    arguments: {
                                                      "id": state[index].id.toString(),
                                                    },
                                                  ))).then(onGoBack);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          appointmentBloc.add(DeleteAppointmentData(state[index].id));
                                          refresh();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(children:[
                                  const Text("I/C No.: "),    
                                  Text(
                                  state[index].icnum.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                                ]),
                              ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(children:[
                                  const Text("Date: "),    
                                  Text(
                                  state[index].date.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                                ]),
                              ),

                           Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(children:[
                                  const Text("Time: "),    
                                  Text(
                                  state[index].time.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                                ]),
                              ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(children:[
                                  const Text("Location: "),    
                                  Text(
                                  state[index].location.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                                ]),
                              ),

                            ElevatedButton(
                              onPressed: () {
                                // Handle approve button action
                              },
                              child: const Text('Approve'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Handle reject button action
                              },
                              child: const Text('Reject'),
                            ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
