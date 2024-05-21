import 'package:flutter/material.dart';
import '../models/budget.dart';

class BudgetProvider with ChangeNotifier {
  double _dailyLimit = 100.0; // Ejemplo de tope diario
  double _remainingBudget = 100.0;
  List<BudgetCategory> _categories = [
    BudgetCategory(name: 'Transporte', limit: 20.0),
    BudgetCategory(name: 'Comida', limit: 30.0),
    BudgetCategory(name: 'Alojamiento', limit: 50.0),
  ];

  double get dailyLimit => _dailyLimit;
  double get remainingBudget => _remainingBudget;
  List<BudgetCategory> get categories => _categories;

  void updateDailyLimit(double newLimit) {
    _dailyLimit = newLimit;
    _remainingBudget = newLimit;
    notifyListeners();
  }

  void updateCategoryLimit(String name, double newLimit) {
    final index = _categories.indexWhere((cat) => cat.name == name);
    if (index != -1) {
      _categories[index] = BudgetCategory(name: name, limit: newLimit);
      notifyListeners();
    }
  }

  bool updateSpending(String name, double amount) {
    final index = _categories.indexWhere((cat) => cat.name == name);
    if (index != -1 && amount <= _remainingBudget) {
      _categories[index] =
          BudgetCategory(name: name, limit: _categories[index].limit - amount);
      _remainingBudget -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }

  void newDay() {
    _remainingBudget = _dailyLimit;
    for (var i = 0; i < _categories.length; i++) {
      _categories[i] = BudgetCategory(
          name: _categories[i].name, limit: _categories[i].limit);
    }
    notifyListeners();
  }
}
