part of 'calculator_cubit.dart';

abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorCompleted extends CalculatorState {}

class CalculatorFailed extends CalculatorState {}
