import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';

class AccommodationScreen extends StatelessWidget {
  const AccommodationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _accommodationLimitController = TextEditingController();
    final _accommodationSpendingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alojamiento'),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          final accommodationCategory = budgetProvider.categories
              .firstWhere((cat) => cat.name == 'Alojamiento');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Límite de Alojamiento: \$${accommodationCategory.limit.toStringAsFixed(2)}'),
                TextField(
                  controller: _accommodationLimitController,
                  decoration: const InputDecoration(
                      labelText: 'Nuevo límite para Alojamiento'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLimit =
                        double.tryParse(_accommodationLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateCategoryLimit(
                          'Alojamiento', newLimit);
                    }
                  },
                  child: const Text('Actualizar límite de Alojamiento'),
                ),
                TextField(
                  controller: _accommodationSpendingController,
                  decoration:
                      const InputDecoration(labelText: 'Gasto en Alojamiento'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final spending =
                        double.tryParse(_accommodationSpendingController.text);
                    if (spending != null) {
                      final success = budgetProvider.updateSpending(
                          'Alojamiento', spending);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'No hay suficiente presupuesto restante para Alojamiento')),
                        );
                      }
                    }
                  },
                  child: const Text('Añadir Gasto de Alojamiento'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
