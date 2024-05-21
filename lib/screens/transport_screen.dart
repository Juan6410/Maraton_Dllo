import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _transportLimitController = TextEditingController();
    final _transportSpendingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transporte'),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          final transportCategory = budgetProvider.categories
              .firstWhere((cat) => cat.name == 'Transporte');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Límite de Transporte: \$${transportCategory.limit.toStringAsFixed(2)}'),
                TextField(
                  controller: _transportLimitController,
                  decoration: const InputDecoration(
                      labelText: 'Nuevo límite para Transporte'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLimit =
                        double.tryParse(_transportLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateCategoryLimit(
                          'Transporte', newLimit);
                    }
                  },
                  child: const Text('Actualizar límite de Transporte'),
                ),
                TextField(
                  controller: _transportSpendingController,
                  decoration:
                      const InputDecoration(labelText: 'Gasto en Transporte'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    final spending =
                        double.tryParse(_transportSpendingController.text);
                    if (spending != null) {
                      final success =
                          budgetProvider.updateSpending('Transporte', spending);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'No hay suficiente presupuesto restante para Transporte')),
                        );
                      }
                    }
                  },
                  child: const Text('Añadir Gasto de Transporte'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
