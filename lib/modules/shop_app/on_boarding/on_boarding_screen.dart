import 'package:darsh/modules/shop_app/login/shop_login_screen.dart';
import 'package:darsh/shared/components/components.dart';
import 'package:darsh/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding=[
    BoardingModel(
      image: 'assets/images/shop.png',
      title: 'On Board 1 title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/shop.png',
      title: 'On Board 2 title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/shop.png',
      title: 'On Board 3 title',
      body: 'On Board 3 Body',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:()
          {
            navigateAndFinish(context, ShopLoginScreen());
          },
              text: 'skip',
            fontSize: 17,
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder:(context,index)=>buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index)
                {
                  print(boarding.length);
                  if(index==boarding.length-1)
                    {
                      setState(()
                      {
                        isLast = true;
                      });
                    }
                   else
                    {
                      setState(()
                      {
                        isLast = false;
                      });
                    }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  {
                    navigateAndFinish(context, ShopLoginScreen());
                  }
                  else
                    {
                      boardController.nextPage(
                        duration:Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                },
                child:Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel board)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:
  [
  Expanded(
  child: Image(
  image: AssetImage('${board.image}',),
  ),
  ),
  SizedBox(
  height: 20,
  ),
  Text(
  '${board.title}',
  style: TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(
  height: 20,
  ),
  Text(
  '${board.body}',
  style: TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  );
}
