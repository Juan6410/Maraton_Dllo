import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _foodLimitController = TextEditingController();
    final _foodSpendingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comida'),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          final foodCategory = budgetProvider.categories
              .firstWhere((cat) => cat.name == 'Comida');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Límite de Comida: \$${foodCategory.limit.toStringAsFixed(2)}'),
                TextField(
                  controller: _foodLimitController,
                  decoration: const InputDecoration(
                      labelText: 'Nuevo límite para Comida'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLimit = double.tryParse(_foodLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateCategoryLimit('Comida', newLimit);
                    }
                  },
                  child: const Text('Actualizar límite de Comida'),
                ),
                TextField(
                  controller: _foodSpendingController,
                  decoration:
                      const InputDecoration(labelText: 'Gasto en Comida'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final spending =
                        double.tryParse(_foodSpendingController.text);
                    if (spending != null) {
                      final success =
                          budgetProvider.updateSpending('Comida', spending);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'No hay suficiente presupuesto restante para Comida')),
                        );
                      }
                    }
                  },
                  child: const Text('Añadir Gasto de Comida'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
