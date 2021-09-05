import 'package:darsh/shared/components/components.dart';
import 'package:darsh/shared/home_layout_cubit/cubit.dart';
import 'package:darsh/shared/home_layout_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget{
  @override
      Widget build(BuildContext context) {
        return BlocConsumer<AppCubit, AppStates>(
          listener:(context,state){} ,
          builder:(context,state)
          {
            return tasksBuilder(
              context: context,
              tasks: AppCubit.get(context).newtasks,
            );
          }
        );
      }
    }


