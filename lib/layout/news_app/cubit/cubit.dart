import 'package:darsh/layout/news_app/cubit/states.dart';
import 'package:darsh/modules/news_app/business/business_screen.dart';
import 'package:darsh/modules/news_app/science/science_screen.dart';
import 'package:darsh/modules/news_app/sports/sports_screen.dart';
import 'package:darsh/shared/network/local/cache_helper.dart';
import 'package:darsh/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

 int currentIndex = 0;
 bool isDark = false;

  List<String> titles =
  [
    'Business Screen',
    'Sports Screen',
    'Science Screen',
    'Settings Screen',

  ];

  List<Widget> screens=
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  List<BottomNavigationBarItem> items =
  [
   BottomNavigationBarItem(
      icon:Icon(
      Icons.business,
      ),
    label: 'Business',
  ),
   BottomNavigationBarItem(
      icon:Icon(
      Icons.sports,
      ),
    label: 'Sports',
  ),
   BottomNavigationBarItem(
      icon:Icon(
      Icons.science,
      ),
    label: 'Science',
  ),
  ];

void bottomItemChange(int index)
{
  currentIndex=index;
  emit(NewsBottomNavState());
}

 void changeAppMode({bool? fromShared})
 {
   if(fromShared!=null)
   {
     isDark=fromShared;
     emit(AppChangeModeState());

   }
    else
      {
        isDark=!isDark;
        CacheHelper.putBoolean(key:'isDark', value: isDark).then((value)
        {
          emit(AppChangeModeState());
        });
      }


 }

 void getBusiness()
 {

   emit(NewsGetBusinessLoadingState());
   DioHelper.getData(
     url:'v2/top-headlines',
     query:
     {
       'country':'eg',
       'category':'business',
       'apiKey':'e0fd546ee73544b786b011008f596cb9',
     } ,
   ).then((value){
    business = value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState(error.toString()));
   });
 }

 void getSports()
 {
   emit(NewsGetSportsLoadingState());
   DioHelper.getData(
     url:'v2/top-headlines',
     query:
     {
       'country':'eg',
       'category':'sports',
       'apiKey':'e0fd546ee73544b786b011008f596cb9',
     } ,
   ).then((value){
    sports = value.data['articles'];
    print(sports[0]['title']);
    emit(NewsGetSportsSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetSportsErrorState(error.toString()));
   });
 }

 void getScience()
 {
   emit(NewsGetScienceLoadingState());
   DioHelper.getData(
     url:'v2/top-headlines',
     query:
     {
       'country':'eg',
       'category':'science',
       'apiKey':'e0fd546ee73544b786b011008f596cb9',
     } ,
   ).then((value){
    science = value.data['articles'];
    print(science[0]['title']);
    emit(NewsGetScienceSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetScienceErrorState(error.toString()));
   });
 }

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url:'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'e0fd546ee73544b786b011008f596cb9',
      } ,
    ).then((value){
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }


}