import 'package:flutter/material.dart';

import 'package:quiz_app_updated/Utils/Color_constants.dart';
import 'package:quiz_app_updated/View/Home%20Screen/home_screen.dart';

import 'package:quiz_app_updated/dummy_db.dart';

class ResultScreen extends StatefulWidget {
  final int righanswercount;
  final String selectedCategory;
  const ResultScreen(
      {super.key,
      required this.righanswercount,
      required this.selectedCategory});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int starCount = 0;
  calculateStarCount() {
    var percentage = (widget.righanswercount /
            DummyDb.categoryQuestions[widget.selectedCategory]!.length) *
        100;

    if (percentage > 80) {
      starCount = 3;
    } else if (percentage > 50) {
      starCount = 2;
    } else if (percentage >= 30) {
      starCount = 1;
    } else {
      starCount = 0;
    }
  }

  @override
  void initState() {
    calculateStarCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: 15, right: 15, bottom: index == 1 ? 30 : 0),
              child: Icon(
                Icons.star,
                color: index < starCount
                    ? ColorConstants.yellowText
                    : ColorConstants.maingrey,
                size: index == 1 ? 80 : 50,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Congratulations",
          style: TextStyle(
              color: ColorConstants.yellowText,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Your Score",
          style: TextStyle(color: ColorConstants.mainwhite, fontSize: 14),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "${widget.righanswercount} / ${DummyDb.categoryQuestions[widget.selectedCategory]!.length}",
          style: TextStyle(
              color: ColorConstants.yellowText,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: InkWell(
            // onTap: () {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => QuestionsScreen()));
            // },
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route route) => false,
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstants.mainwhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorConstants.mainblack,
                      child: Icon(
                        Icons.refresh,
                        color: ColorConstants.mainwhite,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Retry",
                      style: TextStyle(
                          color: ColorConstants.mainblack,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
