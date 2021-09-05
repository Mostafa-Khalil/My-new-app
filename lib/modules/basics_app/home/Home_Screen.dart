import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle:true ,
          backgroundColor: Colors.teal,
          elevation: 0,
          leading: Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          title: Text(
            'Aya Elsherbiny',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.purple,
            ),
          ),
          actions: [
            IconButton(
              padding:EdgeInsets.all(20),
              alignment: Alignment.center,
              icon:Icon(
                Icons.notification_important,
              ) ,
              onPressed: (){
                print('Aya My Love');
              },
            ),
            Icon(
              Icons.search,
              size: 30,
              textDirection: TextDirection.rtl,
            ),
          Text(
            'Mostafa',
          ),
          ],
        ),
        body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(80),
            child: Container(clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd:Radius.circular(50) ,
                  topStart: Radius.circular(40)
                      
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children:[

                  Image(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512_960_720.jpg',
                  ),
                  width:200 ,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                  Container(width: 200,
                    color: Colors.black.withOpacity(.2),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white ,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  ],
              ),
            ),
          ),

        ],

        ),

    );
}
}
