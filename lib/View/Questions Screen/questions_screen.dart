import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import 'package:lottie/lottie.dart';

import 'package:quiz_app_updated/Utils/Animation_constants.dart';
import 'package:quiz_app_updated/Utils/Color_constants.dart';
import 'package:quiz_app_updated/View/Result Screen/result_screen.dart';

import 'package:quiz_app_updated/dummy_db.dart';

class QuestionsScreen extends StatefulWidget {
  final String selectedCategory;

  const QuestionsScreen({super.key, required this.selectedCategory});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;
  int? selectedAnswerIndex;
  double _currentValue = 10;
  CountDownController timercontroller = CountDownController();

  void progressbar() {
    setState(() {
      if (_currentValue + 10 <= 100) {
        _currentValue += 10;
      } else {
        _currentValue = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> questions =
        DummyDb.categoryQuestions[widget.selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedCategory),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.mainblack,
                    border:
                        Border.all(width: 1, color: ColorConstants.maingrey),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: ColorConstants.mainwhite,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: EdgeInsets.all(17),
                        child: Row(
                          children: [
                            Expanded(
                              child: FAProgressBar(
                                size: 20,
                                backgroundColor: Colors.grey,
                                currentValue: _currentValue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${questionIndex + 1} / ${questions.length}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Container(
              height: 320,
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    Container(
                      height: 280,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          questions[questionIndex]["question"],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    if (selectedAnswerIndex ==
                        questions[questionIndex]["answerIndex"])
                      Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                              AnimationConstants.RIGHT_ANSWER_ANIMATION)),
                  ]),
                ),
                Positioned(
                  left: 140,
                  top: 20,
                  child: CircularCountDownTimer(
                    isReverseAnimation: true,

                    duration: 10, // Set your duration
                    initialDuration: 0,
                    controller: timercontroller,
                    width: 70,
                    height: 70,
                    ringColor: Colors.grey,
                    fillColor: Colors.blue,
                    backgroundColor: Colors.white,
                    strokeWidth: 15.0,
                    strokeCap: StrokeCap.round,
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    isReverse: true, // Timer will count down
                    isTimerTextShown: true,
                    onComplete: () {
                      progressbar();
                      selectedAnswerIndex = null;
                      if (questionIndex < questions.length - 1) {
                        questionIndex++;
                        setState(() {});
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                      righanswercount: 4,
                                    )));
                      }
                      timercontroller.restart();
                    },
                  ),
                ),
              ]),
            ),
            Column(
              children: List.generate(
                questions[questionIndex]["options"].length,
                (optionIndex) {
                  var currentQuestion = questions[questionIndex];

                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        if (selectedAnswerIndex == null) {
                          selectedAnswerIndex = optionIndex;
                          setState(() {});
                          print(selectedAnswerIndex);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: getColor(optionIndex),
                              width: 2,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentQuestion["options"][optionIndex],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            if (selectedAnswerIndex != null)
              InkWell(
                onTap: () {
                  {
                    progressbar();
                  }
                  selectedAnswerIndex = null;
                  if (questionIndex < questions.length - 1) {
                    questionIndex++;
                    setState(() {});
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  righanswercount: 4,
                                )));
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Color getColor(int currentOptinIndex) {
    List<Map<String, dynamic>> questions =
        DummyDb.categoryQuestions[widget.selectedCategory]!;

    if (selectedAnswerIndex != null &&
        currentOptinIndex == questions[questionIndex]["answerIndex"]) {
      return Colors.green;
    }

    if (selectedAnswerIndex == currentOptinIndex) {
      if (selectedAnswerIndex == questions[questionIndex]["answerIndex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.white;
    }
  }
}
