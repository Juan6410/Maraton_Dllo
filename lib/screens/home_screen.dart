import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Travel Budget App',
            style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, budgetProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueGrey[900],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Tope Diario: \$${budgetProvider.dailyLimit.toStringAsFixed(2)}',
                                    selectionColor: Colors.white,
                                    style: budgetBarStyle(),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      'Presupuesto Restante: \$${budgetProvider.remainingBudget.toStringAsFixed(2)}',
                                      style: budgetBarStyle()),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _dailyLimitController,
                    decoration:
                        const InputDecoration(labelText: 'Nuevo tope diario'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: diaryAmmountButton(),
                      onPressed: () {
                        final newLimit =
                            double.tryParse(_dailyLimitController.text);
                        if (newLimit != null) {
                          budgetProvider.updateDailyLimit(newLimit);
                        }
                      },
                      child: const Text('Actualizar tope diario',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueGrey[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: menuOptionsButton(),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TransportScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Gestión de Transporte',
                                    style: menuOptionsButtonText(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: menuOptionsButton(),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FoodScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Gestión de Comida',
                                    style: menuOptionsButtonText(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: menuOptionsButton(),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AccommodationScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Gestión de Alojamiento',
                                    style: menuOptionsButtonText(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: diaryAmmountButton(),
                          onPressed: () {
                            budgetProvider.newDay();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Nuevo día iniciado. Presupuesto restablecido.')),
                            );
                          },
                          child:
                              Text('Nuevo Día', style: menuOptionsButtonText()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle menuOptionsButtonText() => TextStyle(color: Colors.white);

  ButtonStyle menuOptionsButton() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blueGrey[600]),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  ButtonStyle diaryAmmountButton() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900]),
    );
  }

  TextStyle budgetBarStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
  }
}
