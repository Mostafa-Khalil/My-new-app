import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:darsh/layout/news_app/cubit/cubit.dart';
import 'package:darsh/layout/news_app/cubit/states.dart';
import 'package:darsh/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        NewsCubit cubit= NewsCubit.get(context);
        return buildArticle(
            condition: state is! NewsGetScienceLoadingState,
            list:cubit.science,
        );
      },

    );
  }
}
