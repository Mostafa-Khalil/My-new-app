import 'package:darsh/modules/counter_app/counter/cubit/cubit.dart';
import 'package:darsh/modules/counter_app/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state){
          if(state is CounterPlusState) {
            print('plus state ${state.counter}');

          }
          if(state is CounterMinusState) print('minus state');
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 20,
              title: Text(
                  'Counter'
              ),

            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed:()
                  {
                    CounterCubit.get(context).minus();

                  },
                    child:Text(
                      'MINUS',
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(onPressed:()
                  {
                    CounterCubit.get(context).plus();

                  },
                    child:Text(
                      'PLUS',
                    ),

                  ),

                ],
              ),
            ),

          );
        },
      ),
    );
  }
}


