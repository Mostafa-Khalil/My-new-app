import 'package:flutter/material.dart';
class BmiResultCubit extends StatelessWidget {
  final int result;
  BmiResultCubit(
  {
    required this.result,
});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleSpacing: 20,
          title: Text(
            'Result',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 120,
            child: Column(
              children: [
                Text(
                  'RESULT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50
                  ),
                ),
                Text(
                  '$result',
                  style: TextStyle(
                    fontSize: 40,

                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
