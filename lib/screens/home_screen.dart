import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _dailyLimitController = TextEditingController();
    final _categoryLimitController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Budget App'),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Tope Diario: \$${budgetProvider.dailyLimit.toStringAsFixed(2)}'),
                TextField(
                  controller: _dailyLimitController,
                  decoration:
                      const InputDecoration(labelText: 'Nuevo tope diario'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLimit =
                        double.tryParse(_dailyLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateDailyLimit(newLimit);
                    }
                  },
                  child: const Text('Actualizar tope diario'),
                ),
                const SizedBox(height: 20),
                Text('Categorías:'),
                ...budgetProvider.categories.map((category) {
                  return ListTile(
                    title: Text(category.name),
                    trailing: Text('\$${category.limit.toStringAsFixed(2)}'),
                  );
                }).toList(),
                TextField(
                  controller: _categoryLimitController,
                  decoration: const InputDecoration(
                      labelText: 'Nuevo límite para la categoría Transporte'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLimit =
                        double.tryParse(_categoryLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateCategoryLimit(
                          'Transporte', newLimit);
                    }
                  },
                  child: const Text('Actualizar límite de Transporte'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
