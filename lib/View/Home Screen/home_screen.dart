import 'package:flutter/material.dart';

import 'package:quiz_app_updated/Utils/Color_constants.dart';
import 'package:quiz_app_updated/Utils/Image_constants.dart';
import 'package:quiz_app_updated/View/Questions Screen/questions_screen.dart';
import 'package:quiz_app_updated/dummy_db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = DummyDb.categoryQuestions.keys.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.mainblack,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Hamad",
              style: TextStyle(
                  fontSize: 30,
                  color: ColorConstants.mainwhite,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Let's make this day productive",
              style: TextStyle(fontSize: 18, color: ColorConstants.maingrey),
            )
          ],
        ),
        actions: [
          CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(
                ImageConstants.PROFILE_IMG,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: ColorConstants.lightblack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset(scale: 8, ImageConstants.TROPHY_PNG),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ranking",
                            style: TextStyle(
                                fontSize: 16, color: ColorConstants.maingrey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "348",
                            style: TextStyle(
                                fontSize: 25, color: ColorConstants.textblue),
                          )
                        ],
                      )
                    ],
                  ),
                  VerticalDivider(),
                  Row(
                    children: [
                      Image.asset(scale: 8, ImageConstants.COIN_IMG),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Points",
                            style: TextStyle(
                                fontSize: 16, color: ColorConstants.maingrey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "1209",
                            style: TextStyle(
                                fontSize: 25, color: ColorConstants.textblue),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Let's Play",
              style: TextStyle(
                  fontSize: 25,
                  color: ColorConstants.mainwhite,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsScreen(
                            selectedCategory:
                                category, // pass the selected ctgry
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.category),
                            SizedBox(height: 10),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
