class BudgetCategory {
  final String name;
  final double limit;

  BudgetCategory({required this.name, required this.limit});
}

class DailyBudget {
  final double dailyLimit;
  final List<BudgetCategory> categories;

  DailyBudget({required this.dailyLimit, required this.categories});
}
