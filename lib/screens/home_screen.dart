import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import 'transport_screen.dart';
import 'food_screen.dart';
import 'accommodation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _dailyLimitController = TextEditingController();

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
                Text(
                    'Presupuesto Restante: \$${budgetProvider.remainingBudget.toStringAsFixed(2)}'),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransportScreen()),
                    );
                  },
                  child: const Text('Gestión de Transporte'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FoodScreen()),
                    );
                  },
                  child: const Text('Gestión de Comida'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccommodationScreen()),
                    );
                  },
                  child: const Text('Gestión de Alojamiento'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    budgetProvider.newDay();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Nuevo día iniciado. Presupuesto restablecido.')),
                    );
                  },
                  child: const Text('Nuevo Día'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}