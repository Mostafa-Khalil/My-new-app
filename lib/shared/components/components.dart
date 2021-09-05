import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:darsh/modules/news_app/web_view/web_view_screen.dart';

import 'package:darsh/shared/home_layout_cubit/cubit.dart';
import 'package:flutter/material.dart';

 Widget defaultButton({
   double width = double.infinity,
   Color background = Colors.blue,
   double radius = 0,
   bool  isUpperCase = true,
   required  function,
   required String text,

 }) =>  Container(
   decoration: BoxDecoration(color:background,
      borderRadius: BorderRadius.circular(radius),
   ),
 width: width,
 height: 40,
 child: MaterialButton(onPressed:function,
 child: Text(
  isUpperCase? text.toUpperCase():text,
 style: TextStyle(
 color: Colors.white,
 ),
 ),
 ),
 );

 Widget defaultTextButton({
  required function,
   required String text,
   double? fontSize ,
})=>TextButton(
     onPressed:function ,
     child: Text(text.toUpperCase(),
     style: TextStyle(
       fontSize: fontSize,
     ),
     ),
 );

Widget defaultFormField({

  required TextEditingController controller ,
  required TextInputType type,
  bool obSecure = false,
   suffixPressed,
   onSubmit ,
   onChanged ,
   onTap,
  required  validate,
  required String  label,
  required IconData prefix,
    IconData? suffix,
  color

}) => TextFormField(
  controller: controller,
  keyboardType:type ,
  obscureText: obSecure,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap:onTap ,
  validator:validate,
  decoration:InputDecoration(
    labelText: label,
    border:OutlineInputBorder(
      borderRadius:BorderRadius.all(Radius.circular(15)) ,
    ),
    hoverColor: color,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon:IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
        suffix,
      ),
    ),
  ),
  cursorColor: color,

);

Widget buildTaskItem(Map model,context) => Dismissible(
   key: Key(model['id'].toString()),
   onDismissed: (direction)
   {
     AppCubit.get(context).deleteDatabase(id:model['id'] );
   },
   child: Padding(
     padding: const EdgeInsets.all(16.0),
     child: Row(
       children: [
         CircleAvatar(
           radius: 40,
           child: Text(
               '${model['time']}'
           ),
         ),
         SizedBox(
           width: 15,
         ),
         Expanded(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${model['title']}',
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               SizedBox(
                 height: 3,
               ),
               Text(
                 '${model['date']}',
                 style: TextStyle(
                   fontSize: 16,
                   color: Colors.grey,
                 ),
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
               ),
             ],
           ),
         ),
         SizedBox(
           width: 15,
         ),
         IconButton(
             onPressed:()
             {
               AppCubit.get(context).updateDatabase(status: 'done', id:model['id']);
             },
             icon:Icon(
               Icons.check_box,
             ),
             color:Colors.green ,
              ),
         SizedBox(
           width: 15,
         ),
         IconButton(
             onPressed:()
             {
               AppCubit.get(context).updateDatabase(status: 'Archived', id:model['id']);
             },
             icon:Icon(
               Icons.archive,
             ),
             color: Colors.grey[600],
              ),

       ],
     ),
   ),
 );

Widget tasksBuilder(
{required context,
  required List<Map> tasks,

}) =>tasks.length>0? ListView.separated(
itemBuilder: (context,index){
  return buildTaskItem(tasks[index],context);
},
separatorBuilder:(context,index)=> Padding(
padding: const EdgeInsets.symmetric(
horizontal: 16,
),
child: Container(
width: double.infinity,
height: 1,
color: Colors.grey[300],
),
),
itemCount:tasks.length,
) :Center(
  child:   Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

  Icon(

  Icons.menu,

  size: 100,
    color:Colors.grey[500] ,

  ),

  Text(

  'No ${AppCubit.get(context).titles[AppCubit.get(context).currentIndex]} Yet, Please add some Tasks',

  style: TextStyle(

  fontSize: 18,
    color: Colors.grey[500],
  ),

  ),

  ],

  ),
);

Widget buildArticleItem( Map business,context)=>InkWell(
  onTap:()
  {
    navigateTo(context, WebViewScreen(business['url']));
  },
  child:  Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  children: [

  Container(

  width: 120,

  height: 120,

  decoration: BoxDecoration(

  borderRadius: BorderRadius.circular(10),

  image:DecorationImage(

  image: NetworkImage('${business['urlToImage']}'),

  fit:BoxFit.cover

  ),

  ),

  ),

  SizedBox(

  width: 20,

  ),

  Expanded(

  child: Container(

  height: 120,

  child: Column(

  mainAxisSize: MainAxisSize.max,

  crossAxisAlignment: CrossAxisAlignment.start,

  mainAxisAlignment: MainAxisAlignment.start,

  children: [

  Expanded(

  child: Text(

  '${business['title']} ',

  style: Theme.of(context).textTheme.bodyText1,

  maxLines: 3,

  overflow: TextOverflow.ellipsis,

  ),

  ),

  Text(

  '${business['publishedAt']}'.toString(),

  style: TextStyle(

  color: Colors.grey,

  fontSize: 15

  ),

  maxLines: 2,

  overflow: TextOverflow.ellipsis,

  ),

  ],

  ),

  ),

  ),

  ],

  ),

  ),
);

Widget buildArticle({
  required bool condition,
  required list,

})=> ConditionalBuilder (
  condition: condition ,
  builder:(context)=>ListView.separated(
    physics:BouncingScrollPhysics(),
    itemBuilder:(context,index)=>buildArticleItem(list[index],context),
    separatorBuilder:(context,index)=> Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    ),
    itemCount:list.length,
  ),
  fallback:(context)=> Center(child: CircularProgressIndicator(
    color: Colors.deepOrange,
  )),
);

void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      return Widget;
    },
  ),
);

void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=>Widget,),
        (route) => false,
);
