import 'package:bloc/bloc.dart';
import 'package:darsh/layout/news_app/cubit/cubit.dart';
import 'package:darsh/layout/news_app/cubit/states.dart';
import 'package:darsh/layout/news_app/news_layout.dart';
import 'package:darsh/modules/shop_app/login/shop_login_screen.dart';
import 'package:darsh/shared/bloc_observer.dart';
import 'package:darsh/shared/network/local/cache_helper.dart';
import 'package:darsh/shared/network/remote/dio_helper.dart';
import 'package:darsh/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolea(key:'isDark');

  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
          return BlocProvider(
              create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getScience()..changeAppMode(
                fromShared: isDark,
              ),
               child: BlocConsumer<NewsCubit,NewsStates>(
                listener:(context,state){},
                 builder: (context,state)
               {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home:NewsLayout(),
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode:NewsCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
                );
              }
              ));
    }

}

