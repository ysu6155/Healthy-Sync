part of 'bmi_cubit.dart';

abstract class BMICalculatorState {}

class BMICalculatorInitial extends BMICalculatorState {}

class SelectGender extends BMICalculatorState {
  final String selectedGender;
  SelectGender(this.selectedGender);
}

class UpdateHeight extends BMICalculatorState {
  final double height;
  UpdateHeight(this.height);
}

class UpdateWeight extends BMICalculatorState {
  final double weight;
  UpdateWeight(this.weight);
}

class UpdateAge extends BMICalculatorState {
  final int age;
  UpdateAge(this.age);
}

class ShowBMIResult extends BMICalculatorState {
  final double bmi;
  final String bmiCategory;
  final String resultMessage;

  ShowBMIResult(this.bmi, this.bmiCategory, this.resultMessage);
}
