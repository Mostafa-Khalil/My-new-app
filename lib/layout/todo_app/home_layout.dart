import 'package:darsh/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:darsh/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:darsh/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:darsh/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

      int currentIndex = 0;
     late Database database;
      late List<Map> tasks=[];
      var scaffoldKey = GlobalKey<ScaffoldState>();
     var formKey = GlobalKey<FormState>();
     bool isBottomShown = false;
    IconData fab = Icons.edit;
    var titleController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: tasks.length>0? screens[currentIndex] : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
         onPressed: ()
          {
            if(isBottomShown)
            {
              if(formKey.currentState!.validate())
              {
                insertToDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text,
                ).then((value) {

                  Navigator.pop(context);
                  isBottomShown = false;
                  setState(() {
                    fab = Icons.edit;
                  });
                });

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
                  isBottomShown = false;
                  setState(() {
                    fab = Icons.edit;
                  });
                });
                isBottomShown = true;
                setState(() {
                  fab = Icons.add;
                });
              }

            // insertToDatabase();
          },
          child: Icon(
            fab,
      ),
          ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index)
          {
            setState(() {
              currentIndex=index;
            });
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
  }
  Future<String> getName() async
  {
    return 'Mostafa Khalil';
  }

  void createDatabase() async
  {
     database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version)
      {
        print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value)
          {
            print('table created');
          }

          ).catchError((error)
          {
            print('error when creating table is ${error.toString()}');

          });

      },
      onOpen: (database)
        {
          getDataFromDatabase(database).then((value)
          {
            setState(() {
              value = tasks;
            });
          });
          print('database opened');
        },

    );
  }
  Future insertToDatabase({
  required String title,
  required String time,
  required String date,
}) async
  {
   return await database.transaction((txn)
   {
    return txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title","$time","$date","new")').
   then((value)
   {
     print('$value inserted successfully');
   }
   ).
   catchError((error)
   {
   print('error when inserting New record is ${error.toString()}');

   });
   }
   );

  }

  Future<List<Map>> getDataFromDatabase(database) async
  {
    return tasks = await database.rawQuery('SELECT * FROM TASKS');
  }
}
