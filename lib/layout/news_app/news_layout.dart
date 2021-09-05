import 'package:darsh/layout/news_app/cubit/cubit.dart';
import 'package:darsh/layout/news_app/cubit/states.dart';
import 'package:darsh/modules/news_app/search/search_screen.dart';
import 'package:darsh/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder: (context,state)
      {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
             'News App',
            ),
            titleSpacing:20 ,
            actions: [
            IconButton(
                onPressed: ()
                {
                  navigateTo(context,SearchScreen());
                },
                icon:Icon(Icons.search) ,
            ),
            IconButton(
                onPressed: ()
                {
                  cubit.changeAppMode();
                },
                icon:Icon(
                    Icons.brightness_4_outlined,
                ),
            ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.items ,
            currentIndex:cubit.currentIndex,
            onTap:(index)
            {
             cubit.bottomItemChange(index);
            },
          ),
        );
      },
    );
  }
}
