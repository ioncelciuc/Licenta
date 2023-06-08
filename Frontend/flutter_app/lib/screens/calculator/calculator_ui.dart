import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_drawer.dart';
import 'package:flutter_app/components/calculator_button.dart';
import 'package:flutter_app/components/utility_button.dart';
import 'package:flutter_app/cubit/calculator_cubit.dart';
import 'package:flutter_app/screens/calculator/counters_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int lpToSubstract = 0;
  String operation = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDrawer(
        title: 'Calculator',
        homeScaffoldState: widget.homeScaffoldState,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset calculator data?'),
                  content: const Text(
                    'Be aware, the current state of the game will be lost',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<CalculatorCubit>(context)
                            .resetCalculatorValues();
                        BlocProvider.of<CalculatorCubit>(context)
                            .updateCalculatorValues();
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<CalculatorCubit>(context).lp1Selected =
                            true;
                        BlocProvider.of<CalculatorCubit>(context)
                            .updateCalculatorValues();
                      });
                    },
                    child: Center(
                      child: Text(
                        '${BlocProvider.of<CalculatorCubit>(context).lp1}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: BlocProvider.of<CalculatorCubit>(context)
                                  .lp1Selected
                              ? FontWeight.bold
                              : FontWeight.w300,
                          decoration: BlocProvider.of<CalculatorCubit>(context)
                                  .lp1Selected
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: BlocProvider.of<CalculatorCubit>(context)
                                .lp1Evo
                                .length ==
                            1
                        ? null
                        : () {
                            BlocProvider.of<CalculatorCubit>(context)
                                .lp1Evo
                                .removeLast();
                            BlocProvider.of<CalculatorCubit>(context)
                                .lp2Evo
                                .removeLast();
                            BlocProvider.of<CalculatorCubit>(context).lp1 =
                                BlocProvider.of<CalculatorCubit>(context)
                                    .lp1Evo
                                    .last;
                            BlocProvider.of<CalculatorCubit>(context).lp2 =
                                BlocProvider.of<CalculatorCubit>(context)
                                    .lp2Evo
                                    .last;
                            lpToSubstract = 0;
                            operation = '';
                            BlocProvider.of<CalculatorCubit>(context)
                                .updateCalculatorValues();
                            setState(() {});
                          },
                    child: const Text('Undo'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<CalculatorCubit>(context).lp1Selected =
                            false;
                        BlocProvider.of<CalculatorCubit>(context)
                            .updateCalculatorValues();
                      });
                    },
                    child: Center(
                      child: Text(
                        '${BlocProvider.of<CalculatorCubit>(context).lp2}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: !BlocProvider.of<CalculatorCubit>(context)
                                  .lp1Selected
                              ? FontWeight.bold
                              : FontWeight.w300,
                          decoration: !BlocProvider.of<CalculatorCubit>(context)
                                  .lp1Selected
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
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${BlocProvider.of<CalculatorCubit>(context).lp1Selected ? BlocProvider.of<CalculatorCubit>(context).lp1 : BlocProvider.of<CalculatorCubit>(context).lp2}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' $operation ',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  operation.isNotEmpty && lpToSubstract != 0
                      ? lpToSubstract.toString()
                      : '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2),
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
                    if (BlocProvider.of<CalculatorCubit>(context).lp1Selected) {
                      BlocProvider.of<CalculatorCubit>(context).lp1 ~/= 2;
                    } else {
                      BlocProvider.of<CalculatorCubit>(context).lp2 ~/= 2;
                    }
                    BlocProvider.of<CalculatorCubit>(context)
                        .lp1Evo
                        .add(BlocProvider.of<CalculatorCubit>(context).lp1);
                    BlocProvider.of<CalculatorCubit>(context)
                        .lp2Evo
                        .add(BlocProvider.of<CalculatorCubit>(context).lp2);
                    lpToSubstract = 0;
                    operation = '';
                    BlocProvider.of<CalculatorCubit>(context)
                        .updateCalculatorValues();
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
                    if (BlocProvider.of<CalculatorCubit>(context).lp1Selected) {
                      if (operation == '-') {
                        BlocProvider.of<CalculatorCubit>(context).lp1 -=
                            lpToSubstract;
                      } else if (operation == '+') {
                        BlocProvider.of<CalculatorCubit>(context).lp1 +=
                            lpToSubstract;
                      }
                      BlocProvider.of<CalculatorCubit>(context).lp1 =
                          BlocProvider.of<CalculatorCubit>(context).lp1 > 0
                              ? BlocProvider.of<CalculatorCubit>(context).lp1
                              : 0;
                    } else {
                      if (operation == '-') {
                        BlocProvider.of<CalculatorCubit>(context).lp2 -=
                            lpToSubstract;
                      } else if (operation == '+') {
                        BlocProvider.of<CalculatorCubit>(context).lp2 +=
                            lpToSubstract;
                      }
                      BlocProvider.of<CalculatorCubit>(context).lp2 =
                          BlocProvider.of<CalculatorCubit>(context).lp2 > 0
                              ? BlocProvider.of<CalculatorCubit>(context).lp2
                              : 0;
                    }
                    setState(() {
                      operation = '';
                      lpToSubstract = 0;
                      BlocProvider.of<CalculatorCubit>(context)
                          .lp1Evo
                          .add(BlocProvider.of<CalculatorCubit>(context).lp1);
                      BlocProvider.of<CalculatorCubit>(context)
                          .lp2Evo
                          .add(BlocProvider.of<CalculatorCubit>(context).lp2);
                    });
                    BlocProvider.of<CalculatorCubit>(context)
                        .updateCalculatorValues();
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
                  icon: const Icon(Icons.grid_on),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CountersUi(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
