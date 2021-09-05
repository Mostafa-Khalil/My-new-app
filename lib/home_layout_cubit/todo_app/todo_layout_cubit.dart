import 'package:darsh/shared/components/components.dart';
import 'package:darsh/shared/home_layout_cubit/cubit.dart';
import 'package:darsh/shared/home_layout_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomeLayoutCubit extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create:(context)=>AppCubit()..createDatabase(),
        child:BlocConsumer<AppCubit,AppStates>
          (
          listener: (context, state){},
          builder:(context, state)
          {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
              ),
              body: cubit.screens[cubit.currentIndex] ,
              floatingActionButton: FloatingActionButton(
                onPressed: ()
                {
                  if(cubit.isBottomShown)
                  {
                    if(formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                          title:titleController.text,
                          time: timeController.text,
                          date:dateController.text,
                      );
                      cubit.changeBottomSheet(isBottomShown: false, fab:Icons.edit );
                      Navigator.pop(context);
                    }
                  }
                  else
                  {
                    scaffoldKey.currentState!.showBottomSheet((context) =>
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:[
                                defaultFormField(
                                  controller:titleController ,
                                  type: TextInputType.text,
                                  validate: ( value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return('Title must not be empty');
                                    }
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: timeController ,
                                  type: TextInputType.datetime,
                                  validate: ( value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return('Title must not be empty');
                                    }
                                  },
                                  onTap: ()
                                  {
                                    showTimePicker(
                                      context: context,
                                      initialTime:TimeOfDay.now(),
                                    ).then((value)
                                    {
                                      print(value!.format(context));
                                      timeController.text = value.format(context);
                                    }
                                    );
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ), SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: dateController ,
                                  type: TextInputType.datetime,
                                  validate: ( value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return('Date must not be empty');
                                    }
                                  },
                                  onTap: ()
                                  {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-09-22'),
                                    ).then((value)
                                    {
                                      dateController.text=DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.date_range_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                      elevation: 50,
                    ).closed.then((value)
                    {
                     cubit.changeBottomSheet(isBottomShown:false , fab:Icons.edit );
                    });
                      cubit.changeBottomSheet(isBottomShown:true , fab: Icons.add);
                  }

                  // insertToDatabase();
                },
                child: Icon(
                  cubit.fab,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeIndex(index);
                },
                items:
                [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ],

              ),

            );
          } ,
        ) ,
    );

  }
}