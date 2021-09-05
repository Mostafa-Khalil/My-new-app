import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:darsh/modules/bmi_app/bmi_cubit/bmi_result_cubit.dart';
import 'package:darsh/modules/bmi_app/bmi_cubit/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BCubit extends Cubit<BmiStates>
{
  BCubit() : super(BmiInitialState());

  static BCubit get(context)=>BlocProvider.of(context);

  double value =150;
  int result=15;
  bool isMale =true;
  int weight = 40;
  int age = 16;


  void sliderOnChange({required double value})
  {
    this.value =value;
    emit(BmiSliderChangeState());

  }

  void gestureDetectorMale()
  {
   isMale =true;
    emit(BmiGestureClickedState());

  }

  void gestureDetectorFemale()
  {
    isMale =false;
    emit(BmiGestureClickedState());

  }

  void plusWeight()
  {
   weight++;
   emit(WeightChangedState());
  }

  void minusWeight()
  {
    weight--;
    emit(WeightChangedState());
  }

  void plusAge()
  {
    age++;
    emit(AgeChangedState());
  }

  void minusAge()
  {
    age--;
    emit(AgeChangedState());
  }

   void calculatePressed(
  {
    required context,

})
  {
    result = (weight / pow(value / 100, 2)).round();
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>BmiResultCubit(result: result,)));
     emit(CalculatePressedState());

  }

}
