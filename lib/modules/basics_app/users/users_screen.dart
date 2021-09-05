import 'package:darsh/models/users/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UsersScreen extends StatelessWidget {

  List<UserModel> users= [
    UserModel(
      id: 1,
      name: 'Mostafa Khalil',
      phone: '+201202342326',
    ),
    UserModel(
      id: 2,
      name: 'Kareem Elsayed',
      phone: '+20111142326',
    ),
    UserModel(
      id: 3,
      name: 'Hassan Mohamed',
      phone: '+20152351446',
    ),
    UserModel(
      id: 1,
      name: 'Mostafa Khalil',
      phone: '+201202342326',
    ),
    UserModel(
      id: 2,
      name: 'Kareem Elsayed',
      phone: '+20111142326',
    ),
    UserModel(
      id: 3,
      name: 'Hassan Mohamed',
      phone: '+20152351446',
    ),

  ];

  Widget buildUserItem(UserModel user)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          child:
          Text(
            '${user.id}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),

            ],

          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Text(
          'Users',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>buildUserItem(users[index]),
          separatorBuilder :(context,index)=>Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
            width:double.infinity,
              height: 3,
              color: Colors.grey[300],
      ),
          ),
          itemCount:users.length,
      )

    );
  }
}
