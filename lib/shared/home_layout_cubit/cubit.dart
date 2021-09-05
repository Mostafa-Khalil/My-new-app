
import 'package:darsh/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:darsh/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:darsh/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:darsh/shared/home_layout_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super (AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
   List<Map> newtasks =[];
   List<Map> donetasks =[];
   List<Map> archivetasks =[];
  bool isBottomShown = false;
  IconData fab = Icons.edit;

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

  void changeIndex(int index)
  {
    currentIndex=index;
    emit(AppChangeBottomNavBarState());

  }

  void changeBottomSheet(
  {
  required bool isBottomShown,
  required IconData fab,
})
  {
  this.isBottomShown = isBottomShown;
  this.fab = fab;
  emit(AppChangeBottomSheetState());
  }


  void createDatabase()
  {
      openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }

        ).catchError((error) {
          print('error when creating table is ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },

    ).then((value)
    {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async
  {
     await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')

          .then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }
      ).catchError((error) {
        print('error when inserting New record is ${error.toString()}');
      });
    }
    );
  }

   getDataFromDatabase(database)
   {
     newtasks=[];
     donetasks=[];
     archivetasks=[];
      database.rawQuery('SELECT * FROM TASKS').then((value) {

      value.forEach((element)
      {
       if(element['status']=='new')
         newtasks.add(element);
       else  if(element['status']=='done')
         donetasks.add(element);
       else archivetasks.add(element);
      });
      
      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase(
  {
    required String status,
    required int id,
})
  async {
     await database.rawUpdate(
        'UPDATE tasks SET status=? Where id=?',
      ['$status',id ]
    ).then((value)
     {
       getDataFromDatabase(database);
       emit(AppUpdateDatabaseState());

     });

  }

  void deleteDatabase(
      {
        required int id,
      })
  async {
     await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
         .then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());

    });

  }


}