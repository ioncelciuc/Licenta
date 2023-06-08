import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_drawer.dart';
import 'package:flutter_app/components/calculator_button.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/components/utility_button.dart';

class CalculatorUi extends StatefulWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const CalculatorUi({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  bool isTimeRunning = false;
  int seconds = 0;

  int lp1 = 8000;
  int lp2 = 8000;
  int lpToSubstract = 0;
  String operation = '';
  bool lp1Selected = true;
  List<int> lp1Evo = [8000];
  List<int> lp2Evo = [8000];
  List<String> dice = [
    'assets/d1.png',
    'assets/d2.png',
    'assets/d3.png',
    'assets/d4.png',
    'assets/d5.png',
    'assets/d6.png',
  ];
  int diceValue = 0;
  List<String> coin = [
    'assets/c1.png',
    'assets/c2.png',
    'assets/question_mark.png',
  ];
  int coinValue = 0;

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isTimeRunning && seconds < 40 * 60) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDrawer(
        title: 'Calculator',
        homeScaffoldState: widget.homeScaffoldState,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('B1'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isTimeRunning = !isTimeRunning;
                          });
                        },
                        icon: Icon(
                          isTimeRunning
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 32),
                      Text(
                        '${seconds / 60 < 10 ? '0${seconds ~/ 60}' : seconds ~/ 60}:${seconds % 60 < 10 ? '0${seconds % 60}' : seconds % 60}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text('B2'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        lp1Selected = true;
                      });
                    },
                    child: Center(
                      child: Text(
                        '$lp1',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight:
                              lp1Selected ? FontWeight.bold : FontWeight.w300,
                          decoration: lp1Selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: lp1Evo.length == 1
                        ? null
                        : () {
                            lp1Evo.removeLast();
                            lp2Evo.removeLast();
                            lp1 = lp1Evo.last;
                            lp2 = lp2Evo.last;
                            lpToSubstract = 0;
                            operation = '';
                            setState(() {});
                          },
                    child: Text('Undo'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        lp1Selected = false;
                      });
                    },
                    child: Center(
                      child: Text(
                        '$lp2',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight:
                              !lp1Selected ? FontWeight.bold : FontWeight.w300,
                          decoration: !lp1Selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${lp1Selected ? lp1 : lp2}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' $operation ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  operation.isNotEmpty && lpToSubstract != 0
                      ? lpToSubstract.toString()
                      : '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: 'CLR',
                  onPressed: () {
                    lpToSubstract = 0;
                    setState(() {});
                  },
                ),
                CalculatorButton(
                  text: '7',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 7;
                    });
                  },
                ),
                CalculatorButton(
                  text: '8',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 8;
                    });
                  },
                ),
                CalculatorButton(
                  text: '9',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 9;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: '+',
                  onPressed: () {
                    setState(() {
                      operation = '+';
                      lpToSubstract = 0;
                    });
                  },
                ),
                CalculatorButton(
                  text: '4',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 4;
                    });
                  },
                ),
                CalculatorButton(
                  text: '5',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 5;
                    });
                  },
                ),
                CalculatorButton(
                  text: '6',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 6;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: '-',
                  onPressed: () {
                    setState(() {
                      operation = '-';
                      lpToSubstract = 0;
                    });
                  },
                ),
                CalculatorButton(
                  text: '1',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 1;
                    });
                  },
                ),
                CalculatorButton(
                  text: '2',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 2;
                    });
                  },
                ),
                CalculatorButton(
                  text: '3',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10 + 3;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: '%2',
                  onPressed: () {
                    if (lp1Selected) {
                      lp1 ~/= 2;
                    } else {
                      lp2 ~/= 2;
                    }
                    lp1Evo.add(lp1);
                    lp2Evo.add(lp2);
                    lpToSubstract = 0;
                    operation = '';
                    setState(() {});
                  },
                ),
                CalculatorButton(
                  text: '0',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 10;
                    });
                  },
                ),
                CalculatorButton(
                  text: '00',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 100;
                    });
                  },
                ),
                CalculatorButton(
                  text: '000',
                  onPressed: () {
                    setState(() {
                      lpToSubstract = lpToSubstract * 1000;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton(
                  text: '=',
                  onPressed: () {
                    if (lp1Selected) {
                      if (operation == '-') {
                        lp1 -= lpToSubstract;
                      } else if (operation == '+') {
                        lp1 += lpToSubstract;
                      }
                      lp1 = lp1 > 0 ? lp1 : 0;
                    } else {
                      if (operation == '-') {
                        lp2 -= lpToSubstract;
                      } else if (operation == '+') {
                        lp2 += lpToSubstract;
                      }
                      lp2 = lp2 > 0 ? lp2 : 0;
                    }
                    setState(() {
                      operation = '';
                      lpToSubstract = 0;
                      lp1Evo.add(lp1);
                      lp2Evo.add(lp2);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UtilityButton(
                  icon: Icon(
                    Icons.casino,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    setState(() {
                      diceValue = Random().nextInt(6);
                    });
                    int counter = 0;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Roll a die!"),
                              content: Image.asset(
                                dice[diceValue],
                                height: 100,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Timer.periodic(
                                      const Duration(microseconds: 100),
                                      (timer) {
                                        counter++;
                                        setState(() {
                                          diceValue = Random().nextInt(6);
                                        });
                                        if (counter >= 15) {
                                          timer.cancel();
                                          setState(() {
                                            counter = 1;
                                          });
                                        }
                                      },
                                    );
                                  },
                                  child: const Text("Roll"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                UtilityButton(
                  icon: CircleAvatar(
                    minRadius: 12,
                    maxRadius: 12,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Icon(
                      Icons.euro,
                      size: 14,
                    ),
                  ),
                  onPressed: () {
                    int counter = 1;
                    setState(() {
                      coinValue = Random().nextInt(2);
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Flip a coin!"),
                              content: Image.asset(
                                coin[coinValue],
                                height: 100,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      coinValue = 2;
                                    });
                                    Timer.periodic(
                                      const Duration(milliseconds: 500),
                                      (timer) {
                                        counter++;
                                        if (counter >= 2) {
                                          timer.cancel();
                                          setState(() {
                                            counter = 1;
                                            coinValue = Random().nextInt(2);
                                          });
                                        }
                                      },
                                    );
                                  },
                                  child: const Text("Flip"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                UtilityButton(
                  icon: Icon(Icons.grid_on),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
