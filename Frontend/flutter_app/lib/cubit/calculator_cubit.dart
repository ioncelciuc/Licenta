import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/calculator_data.dart';
import 'package:flutter_app/models/counter.dart';
import 'package:flutter_app/utils/hive_helper.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  List<int> lp1Evo = [8000];
  List<int> lp2Evo = [8000];
  int lp1 = 8000;
  int lp2 = 8000;
  bool lp1Selected = true;
  List<Counter> counters = List<Counter>.filled(24, Counter(), growable: false);

  CalculatorCubit() : super(CalculatorInitial());

  loadCalculatorValues() async {
    emit(CalculatorLoading());
    CalculatorData calculatorData = await HiveHelper.getCalculatorData();
    lp1Evo = calculatorData.lp1Evo;
    lp2Evo = calculatorData.lp2Evo;
    lp1 = calculatorData.lp1;
    lp2 = calculatorData.lp2;
    lp1Selected = calculatorData.lp1Selected;
    counters = calculatorData.counters;
    emit(CalculatorCompleted());
  }

  updateCalculatorValues() async {
    CalculatorData calculatorData = CalculatorData(
      lp1Evo: lp1Evo,
      lp2Evo: lp2Evo,
      lp1: lp1,
      lp2: lp2,
      lp1Selected: lp1Selected,
      counters: counters,
    );
    await HiveHelper.insertCalculatorData(calculatorData);
  }

  resetCalculatorValues() {
    lp1Evo = [8000];
    lp2Evo = [8000];
    lp1 = 8000;
    lp2 = 8000;
    lp1Selected = true;
    counters = List<Counter>.filled(24, Counter(), growable: false);
  }
}
