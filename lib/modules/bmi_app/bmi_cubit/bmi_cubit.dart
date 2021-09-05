import 'package:darsh/modules/bmi_app/bmi_cubit/cubit/cubit.dart';
import 'package:darsh/modules/bmi_app/bmi_cubit/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiCubit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>BCubit(),
      child: BlocConsumer<BCubit,BmiStates>
        (listener:(context,state){},
        builder: (context,state)
        {
          BCubit c = BCubit.get(context);
          return Scaffold(
            appBar:AppBar(
              backgroundColor: Colors.blue,
              titleSpacing: 20,
              title:Text(
                'BMI Calculator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ) ,
            ),
            body:Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                      bottom: 10,
                    ),
                    child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: ()
                          {
                            c.gestureDetectorMale();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:c.isMale? Colors.blue:Colors.grey,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image(
                                    image:AssetImage('assets/images/download.png'),
                                  ),
                                ),
                                Text(
                                  'MALE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: ()
                          {
                            c.gestureDetectorFemale();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: !c.isMale? Colors.blue:Colors.grey,
                            ),
                            child: Column(
                              children: [

                                Expanded(
                                  child: Image(
                                    image:AssetImage('assets/images/2.png'),
                                  ),
                                ),

                                Text(
                                  'FEMALE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            'HEIGHT',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline:TextBaseline.alphabetic,
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                               ' ${c.value.round()}',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,

                                ),
                              ),
                              Text(
                                'CM',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,


                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: c.value,
                            onChanged:(value)
                            {
                            c.sliderOnChange(value: value);
                            },
                            min:120 ,
                            max:250 ,
                            activeColor: Colors.white,
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 10,
                      bottom: 10
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration:BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'WEIGHT',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${c.weight}',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(
                                    onPressed:()
                                    {
                                      c.minusWeight();
                                    },
                                      mini: true,
                                      child: Icon(
                                        Icons.remove,
                                        size: 30,
                                      ),

                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FloatingActionButton(
                                      onPressed:()
                                      {
                                        c.plusWeight();
                                      },
                                      mini:true,
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration:BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'AGE',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${c.age}',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(
                                      onPressed:()
                                      {
                                        c.minusAge();
                                      },
                                      mini: true,
                                      child: Icon(
                                        Icons.remove,
                                        size: 30,
                                      ),

                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FloatingActionButton(
                                      onPressed:()
                                      {
                                        c.plusAge();
                                      },
                                      mini:true,
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    width: double.infinity,
                    child:MaterialButton(
                      onPressed:()
                      {
                       c.calculatePressed(context: context);
                      },
                      child:Text(
                        'CALCULATE',
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ) ,

                    ),
                  ),
                ),
              ],
            ),
          );
        },


      ),

    );
  }
}
