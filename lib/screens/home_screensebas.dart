import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _dailyLimitController = TextEditingController();
    final _categoryLimitControllerTravel = TextEditingController();
    final _categoryLimitControllerFood = TextEditingController();
    final _categoryLimitControllerHotel = TextEditingController();

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
                TextFieldCategories(_categoryLimitControllerTravel, 'Nuevo límite para la categoría de transporte'),
                buttonCategories(budgetProvider, _categoryLimitControllerTravel, 'Actualizar límite de transporte', 'Transporte'),
                TextFieldCategories(_categoryLimitControllerFood, 'Nuevo límite para la categoría de comida'),
                buttonCategories(budgetProvider, _categoryLimitControllerFood, 'Actualizar límite de comida', 'Comida'),
                TextFieldCategories(_categoryLimitControllerHotel, 'Nuevo límite para la categoría de Alojamiento'),
                buttonCategories(budgetProvider, _categoryLimitControllerHotel, 'Actualizar límite de Alojamiento', 'Alojamiento'),
              ],
            ),
          );
        },
      ),
    );
  }

  TextField TextFieldCategories( TextEditingController _categoryLimitController, label){
    return TextField(
                  controller: _categoryLimitController,
                  decoration: InputDecoration(
                      labelText: label),
                  keyboardType: TextInputType.number,
                );
  }

  ElevatedButton buttonCategories(BudgetProvider budgetProvider, TextEditingController _categoryLimitController, label, String category){
    return ElevatedButton(
                  onPressed: () {
                    final newLimit =
                        double.tryParse(_categoryLimitController.text);
                    if (newLimit != null) {
                      budgetProvider.updateCategoryLimit(
                          category, newLimit);
                    }
                  },
                  child:  Text(label),
                );
  }
}