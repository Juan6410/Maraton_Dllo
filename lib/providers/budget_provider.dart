import 'package:flutter/material.dart';
import '../models/budget.dart';

class BudgetProvider with ChangeNotifier {
  double _dailyLimit = 100.0; // Ejemplo de tope diario
  List<BudgetCategory> _categories = [
    BudgetCategory(name: 'Transporte', limit: 20.0),
    BudgetCategory(name: 'Comida', limit: 30.0),
    BudgetCategory(name: 'Alojamiento', limit: 50.0),
  ];

  double get dailyLimit => _dailyLimit;
  List<BudgetCategory> get categories => _categories;

  void updateDailyLimit(double newLimit) {
    _dailyLimit = newLimit;
    notifyListeners();
  }

  void updateCategoryLimit(String name, double newLimit) {
    final index = _categories.indexWhere((cat) => cat.name == name);
    if (index != -1) {
      _categories[index] = BudgetCategory(name: name, limit: newLimit);
      notifyListeners();
    }
  }
}
