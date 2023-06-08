import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/calculator_cubit.dart';
import 'package:flutter_app/models/counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldZone extends StatefulWidget {
  final double size;
  final int index;
  const FieldZone({
    super.key,
    required this.size,
    required this.index,
  });

  @override
  State<FieldZone> createState() => _FieldZoneState();
}

class _FieldZoneState extends State<FieldZone> {
  int greenCounters = 0;
  int blueCounters = 0;
  int redCounters = 0;

  @override
  void initState() {
    greenCounters = BlocProvider.of<CalculatorCubit>(context)
        .counters[widget.index]
        .greenCounters;
    blueCounters = BlocProvider.of<CalculatorCubit>(context)
        .counters[widget.index]
        .blueCounters;
    redCounters = BlocProvider.of<CalculatorCubit>(context)
        .counters[widget.index]
        .redCounters;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Add a counter'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (greenCounters > 0) {
                                greenCounters--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Image.asset(
                          'assets/spell_counter.png',
                          height: 20,
                        ),
                        Text(
                          '$greenCounters',
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (greenCounters < 99) {
                                greenCounters++;
                              }
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (blueCounters > 0) {
                                blueCounters--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Image.asset(
                          'assets/spell_counter.png',
                          color: Colors.blue.withOpacity(0.7),
                          colorBlendMode: BlendMode.modulate,
                          height: 20,
                        ),
                        Text(
                          '$blueCounters',
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (blueCounters < 99) {
                                blueCounters++;
                              }
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (redCounters > 0) {
                                redCounters--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Image.asset(
                          'assets/spell_counter.png',
                          color: Colors.red.withOpacity(0.7),
                          colorBlendMode: BlendMode.modulate,
                          height: 20,
                        ),
                        Text(
                          '$redCounters',
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (redCounters < 99) {
                                redCounters++;
                              }
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          ),
        ).then(
          (value) => setState(
            () {
              BlocProvider.of<CalculatorCubit>(context).counters[widget.index] =
                  Counter(
                greenCounters: greenCounters,
                blueCounters: blueCounters,
                redCounters: redCounters,
              );
              BlocProvider.of<CalculatorCubit>(context)
                  .updateCalculatorValues();
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        height: widget.size - 4,
        width: widget.size - 4,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            greenCounters == 0
                ? Container(height: 20)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/spell_counter.png',
                        height: 20,
                      ),
                      Text(
                        '$greenCounters',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            blueCounters == 0
                ? Container(height: 20)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/spell_counter.png',
                        color: Colors.blue.withOpacity(0.7),
                        colorBlendMode: BlendMode.modulate,
                        height: 20,
                      ),
                      Text(
                        '$blueCounters',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            redCounters == 0
                ? Container(height: 20)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/spell_counter.png',
                        color: Colors.red.withOpacity(0.7),
                        colorBlendMode: BlendMode.modulate,
                        height: 20,
                      ),
                      Text(
                        '$redCounters',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
