import 'package:flutter/material.dart';
import 'package:flutter_app/components/field_zone.dart';

class CountersUi extends StatefulWidget {
  const CountersUi({super.key});

  @override
  State<CountersUi> createState() => _CountersUiState();
}

class _CountersUiState extends State<CountersUi> {
  late double size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width / 5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage counters'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              FieldZone(size: size, index: 0),
              FieldZone(size: size, index: 1),
              FieldZone(size: size, index: 2),
              FieldZone(size: size, index: 3),
              FieldZone(size: size, index: 4),
            ],
          ),
          Row(
            children: [
              FieldZone(size: size, index: 5),
              FieldZone(size: size, index: 6),
              FieldZone(size: size, index: 7),
              FieldZone(size: size, index: 8),
              FieldZone(size: size, index: 9),
            ],
          ),
          Row(
            children: [
              SizedBox(width: size, height: size),
              FieldZone(size: size, index: 10),
              SizedBox(width: size, height: size),
              FieldZone(size: size, index: 11),
              SizedBox(width: size, height: size),
            ],
          ),
          Row(
            children: [
              FieldZone(size: size, index: 12),
              FieldZone(size: size, index: 13),
              FieldZone(size: size, index: 14),
              FieldZone(size: size, index: 15),
              FieldZone(size: size, index: 16),
            ],
          ),
          Row(
            children: [
              FieldZone(size: size, index: 17),
              FieldZone(size: size, index: 18),
              FieldZone(size: size, index: 19),
              FieldZone(size: size, index: 20),
              FieldZone(size: size, index: 21),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FieldZone(size: size, index: 22),
              FieldZone(size: size, index: 23),
            ],
          ),
        ],
      ),
    );
  }
}
