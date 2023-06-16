import 'dart:async';
import 'package:brain_cells/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/user_model.dart';
import '../../../repository/authentication_repository.dart';
import '../../Dashbord/Dashbord_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<Body> {
  List<int> numbers = [];
  int move = 0;
  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;
  bool showSolvedPuzzle = false;
  List<int> previousNumbers = [];
  bool isSolving = false;
  final _authRepo = Get.put(AuthenticationRepository());
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  int score = 0;

  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(
      duration,
      (Timer t) {
        startTime();
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Game', style: TextStyle(color: kPrimaryLightColor)),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: solvePuzzle,
            icon: Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Expanded(
                child: GridView.builder(
                  itemCount: 16,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (numbers[index] == 0) {
                      return InkWell(
                        onTap: () => moveNumber(index),
                        child: Container(
                          color: kPrimaryLightColor,
                          child: Center(
                            child: Text(
                              '',
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () => moveNumber(index),
                        child: Container(
                          color: kPrimaryColor,
                          child: Center(
                            child: Text(
                              numbers[index].toString(),
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Moves: $move',
                style: TextStyle(fontSize: 20, color: kPrimaryColor),
              ),
              Text('Time: $secondsPassed seconds',
                  style: TextStyle(fontSize: 20, color: kPrimaryColor)),
              ElevatedButton(
                onPressed: reset,
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryLightColor),
                child: Text(
                  'Restart',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 15];
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void moveNumber(int index) {
    if (isSolving) {
      return;
    }

    if (secondsPassed == 0) {
      isActive = true;
    }

    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }

    checkWin();
  }

  void checkWin() {
    if (numbers
        .sublist(0, 14)
        .every((number) => number == numbers.indexOf(number) + 1)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You solved the puzzle in $move moves.'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final email = _authRepo.firebaseUser.value?.email;
                  final snapshot = await db
                      .collection("Users")
                      .where("Email", isEqualTo: email)
                      .get();
                  final userData = snapshot.docs
                      .map((e) => UserModel.fromSnapshot(e))
                      .single;
                  int userScore = userData.Score as int;
                  score = 10 + userScore;
                  try {
                    final userDoc = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userData.id);
                    await userDoc.update({'Score': score});
                  } catch (e) {
                    print("Faild to update Score' $e");
                  }
                  reset();
                },
                child: Text('Play Again'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final email = _authRepo.firebaseUser.value?.email;
                  final snapshot = await db
                      .collection("Users")
                      .where("Email", isEqualTo: email)
                      .get();
                  final userData = snapshot.docs
                      .map((e) => UserModel.fromSnapshot(e))
                      .single;
                  int userScore = userData.Score as int;
                  score = 10 + userScore;
                  try {
                    final userDoc = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userData.id);
                    await userDoc.update({'Score': score});
                  } catch (e) {
                    print("Faild to update Score' $e");
                  }
                  Get.offAll(DashbordScreen());
                },
                child: Text('Exit'),
              ),
            ],
          );
        },
      );
    }
  }

  void solvePuzzle() {
    setState(() {
      if (!showSolvedPuzzle) {
        if (isSolving) {
          return; // Prevent solving while already solving
        }
        previousNumbers = List.from(numbers);
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
        move = 0;
        secondsPassed = 0;
        isActive = false;
        isSolving =
            true; // Set isSolving to true to prevent moving during solving

        // Simulate solving process with delay
        Timer(const Duration(seconds: 2), () {
          setState(() {
            numbers = List.from(previousNumbers);
            isSolving = false; // Reset isSolving after solving is completed
          });
        });
      } else {
        numbers = List.from(previousNumbers);
      }

      showSolvedPuzzle = !showSolvedPuzzle;
    });
  }
}
