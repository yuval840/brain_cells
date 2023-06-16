import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/user_model.dart';
import '../../../constants.dart';
import '../../../controllers/profile_controller.dart';
import '../../../repository/authentication_repository.dart';
import '../../Dashbord/Dashbord_screen.dart';

class MemoryMatchGame extends StatefulWidget {
  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  int score = 0;
  int level = 1;
  int maxLevel = 5; // Maximum level to stop
  int numCards = 8;
  List<int> cardIds = [];
  List<bool> cardFlips = [];
  int? firstCardIndex;
  bool gameStarted = false;
  int pairsFound = 0;
  Timer? timer;
  int timeElapsed = 0;
  final db = FirebaseFirestore.instance;
  late final Future<UserModel> _userRepo = controller1.getUserData();
  final controller1 = Get.put(profileController());
  final _authRepo = Get.put(AuthenticationRepository());
  late UserModel userData;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      cardIds = generateCardIds(numCards ~/ 2);
      cardIds
          .addAll(List.from(cardIds)); // Duplicate the card IDs to create pairs
      cardIds.shuffle();
      cardFlips = List<bool>.filled(numCards, false);
      firstCardIndex = null;
      gameStarted = false;
      pairsFound = 0;
      timeElapsed = 0;
    });
    timer?.cancel();
  }

  List<int> generateCardIds(int numPairs) {
    List<int> ids = [];
    for (int i = 0; i < numPairs; i++) {
      ids.add(i + 1);
    }
    return ids;
  }

  void flipCard(int index) {
    if (!gameStarted) {
      gameStarted = true;
      startTimer();
    }

    setState(() {
      if (firstCardIndex == null) {
        // First card flipped
        firstCardIndex = index;
      } else {
        // Second card flipped
        if (cardIds[firstCardIndex!] == cardIds[index]) {
          // Match found
          pairsFound++;
          if (pairsFound == numCards ~/ 2) {
            // Game over
            timer?.cancel();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Congratulations!'),
                content: Text('You found all the pairs!'),
                actions: [
                  TextButton(
                    child: Text('Play Again'),
                    onPressed: () {
                      Navigator.pop(context);
                      startNextLevel();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // TODO: Implement logic for exiting the game
                      final email = _authRepo.firebaseUser.value?.email;
                      final snapshot = await db
                          .collection("Users")
                          .where("Email", isEqualTo: email)
                          .get();
                      final userData = snapshot.docs
                          .map((e) => UserModel.fromSnapshot(e))
                          .single;
                      int userScore = userData.Score as int;
                      score = level + userScore;
                      //_userRepo = auth.currentUser as UserModel;
                      try {
                        final userDoc = FirebaseFirestore.instance
                            .collection('Users')
                            .doc(userData.id);
                        await userDoc.update({'Score': score});
                      } catch (e) {
                        print("Failed to update Score: $e");
                      }
                      Get.offAll(DashbordScreen());
                    },
                    child: Text('Exit'),
                  ),
                ],
              ),
            );
          } else {
            // Reset first card index after a match
            firstCardIndex = null;
          }
        } else {
          // No match
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              cardFlips[firstCardIndex!] = false;
              cardFlips[index] = false;
              firstCardIndex = null;
            });
          });
        }
      }
      cardFlips[index] = true;
    });
  }

  void startNextLevel() {
    if (level < maxLevel) {
      setState(() {
        level++;
        numCards += 2;
      });
      startGame();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Game Over!'),
          content: Text('You completed all levels!'),
          actions: [
            TextButton(
              child: Text('Restart'),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  level = 1;
                  numCards = 8;
                });
                startGame();
              },
            ),
          ],
        ),
      );
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++;
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    int maxCards = ((maxWidth / maxHeight) * numCards).floor();
    if (maxCards > numCards) {
      maxCards = numCards;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Memory Match Game',
          style: TextStyle(color: kPrimaryLightColor),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Level: $level',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (maxCards ~/ 2) + 1,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: maxWidth / (maxHeight / 2),
                ),
                itemCount: numCards,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!cardFlips[index]) {
                        flipCard(index);
                      }
                    },
                    child: Container(
                      color: cardFlips[index] ? Colors.green : Colors.black,
                      child: Center(
                        child: Text(
                          cardFlips[index] ? cardIds[index].toString() : '',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Time: ${formatTime(timeElapsed)}',
              style: TextStyle(fontSize: 20, color: kPrimaryColor),
            ),
          ),
          ElevatedButton(
            child: Text(
              'Restart',
              style: TextStyle(color: Colors.black),
            ),
            style:
                ElevatedButton.styleFrom(backgroundColor: kPrimaryLightColor),
            onPressed: startGame,
          ),
        ],
      ),
    );
  }
}
// import 'dart:async';
// import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// import '../../../components/user_model.dart';
// import '../../../constants.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../../repository/authentication_repository.dart';
// import '../../Dashbord/Dashbord_screen.dart';

// class MemoryMatchGame extends StatefulWidget {
//   @override
//   _MemoryMatchGameState createState() => _MemoryMatchGameState();
// }

// class _MemoryMatchGameState extends State<MemoryMatchGame> {
//   int score = 0;
//   int level = 1;
//   int maxLevel = 5; // Maximum level to stop
//   int numCards = 8;
//   List<int> cardIds = [];
//   List<bool> cardFlips = [];
//   int? firstCardIndex;
//   bool gameStarted = false;
//   int pairsFound = 0;
//   Timer? timer;
//   int timeElapsed = 0;
//   final db = FirebaseFirestore.instance;
//   late final Future<UserModel> _userRepo = controller1.getUserData();
//   final controller1 = Get.put(profileController());
//   final _authRepo = Get.put(AuthenticationRepository());
//   late UserModel userData;

//   @override
//   void initState() {
//     super.initState();
//     startGame();
//   }

//   void startGame() {
//     setState(() {
//       cardIds = generateCardIds(numCards ~/ 2);
//       cardIds
//           .addAll(List.from(cardIds)); // Duplicate the card IDs to create pairs
//       cardIds.shuffle();
//       cardFlips = List<bool>.filled(numCards, false);
//       firstCardIndex = null;
//       gameStarted = false;
//       pairsFound = 0;
//       timeElapsed = 0;
//     });
//     timer?.cancel();
//   }

//   List<int> generateCardIds(int numPairs) {
//     List<int> ids = [];
//     for (int i = 0; i < numPairs; i++) {
//       ids.add(i + 1);
//     }
//     return ids;
//   }

//   void flipCard(int index) {
//     if (!gameStarted) {
//       gameStarted = true;
//       startTimer();
//     }

//     setState(() {
//       if (firstCardIndex == null) {
//         // First card flipped
//         firstCardIndex = index;
//       } else {
//         // Second card flipped
//         if (cardIds[firstCardIndex!] == cardIds[index]) {
//           // Match found
//           pairsFound++;
//           if (pairsFound == numCards ~/ 2) {
//             // Game over
//             timer?.cancel();
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Congratulations!'),
//                 content: Text('You found all the pairs!'),
//                 actions: [
//                   TextButton(
//                     child: Text('Play Again'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       startGame();
//                     },
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       // TODO: Implement logic for exiting the game
//                       final email = _authRepo.firebaseUser.value?.email;
//                       final snapshot = await db
//                           .collection("Users")
//                           .where("Email", isEqualTo: email)
//                           .get();
//                       final userData = snapshot.docs
//                           .map((e) => UserModel.fromSnapshot(e))
//                           .single;
//                       int userScore = userData.Score as int;
//                       score = level + userScore;
//                       //_userRepo = auth.currentUser as UserModel;
//                       try {
//                         final userDoc = FirebaseFirestore.instance
//                             .collection('Users')
//                             .doc(userData.id);
//                         await userDoc.update({'Score': score});
//                       } catch (e) {
//                         print("Faild to update Score' $e");
//                       }
//                       Get.offAll(DashbordScreen());
//                     },
//                     child: Text('Exit'),
//                   ),
//                 ],
//               ),
//             );
//             if (level < maxLevel) {
//               setState(() {
//                 level++;
//                 numCards += 2;
//               });
//               startGame();
//             } else {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Game Over!'),
//                   content: Text('You completed all levels!'),
//                   actions: [
//                     TextButton(
//                       child: Text('Restart'),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         setState(() {
//                           level = 1;
//                           numCards = 8;
//                         });
//                         startGame();
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }
//           }
//           // Reset first card index after a match
//           firstCardIndex = null;
//         } else {
//           // No match
//           Future.delayed(Duration(milliseconds: 500), () {
//             setState(() {
//               cardFlips[firstCardIndex!] = false;
//               cardFlips[index] = false;
//               firstCardIndex = null;
//             });
//           });
//         }
//       }
//       cardFlips[index] = true;
//     });
//   }

//   void startTimer() {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         timeElapsed++;
//       });
//     });
//   }

//   String formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;
//     double maxHeight = MediaQuery.of(context).size.height;

//     int maxCards = ((maxWidth / maxHeight) * numCards).floor();
//     if (maxCards > numCards) {
//       maxCards = numCards;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Memory Match Game',
//           style: TextStyle(color: kPrimaryLightColor),
//         ),
//         backgroundColor: kPrimaryColor,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Level: $level',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: kPrimaryColor,
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: (maxCards ~/ 2) + 1,
//                   mainAxisSpacing: 4,
//                   crossAxisSpacing: 4,
//                   childAspectRatio: maxWidth / (maxHeight / 2),
//                 ),
//                 itemCount: numCards,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       if (!cardFlips[index]) {
//                         flipCard(index);
//                       }
//                     },
//                     child: Container(
//                       color: cardFlips[index] ? Colors.green : Colors.black,
//                       child: Center(
//                         child: Text(
//                           cardFlips[index] ? cardIds[index].toString() : '',
//                           style: TextStyle(fontSize: 24, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Time: ${formatTime(timeElapsed)}',
//               style: TextStyle(fontSize: 20, color: kPrimaryColor),
//             ),
//           ),
//           ElevatedButton(
//             child: Text(
//               'Restart',
//               style: TextStyle(color: Colors.black),
//             ),
//             style: ElevatedButton.styleFrom(primary: kPrimaryLightColor),
//             onPressed: startGame,
//           ),
//         ],
//       ),
//     );
//   }
// }
