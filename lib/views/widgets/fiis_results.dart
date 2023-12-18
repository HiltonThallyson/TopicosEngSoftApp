import 'package:flutter/material.dart';

class FiisResults extends StatefulWidget {
  final Map<String, dynamic> formInfo;
  final Function returnToForm;

  const FiisResults(
      {required this.formInfo, required this.returnToForm, super.key});

  @override
  State<FiisResults> createState() => _FiisState();
}

class _FiisState extends State<FiisResults> {
  double rentability = 0.0;

  double profit = 0.0;

  double finalValue = 0.0;

  @override
  void initState() {
    calculateResults();
    super.initState();
  }

  void switchToForm() {
    widget.returnToForm(false);
  }

  void calculateResults() {
    rentability = widget.formInfo['rentability'];

    profit = widget.formInfo['value'] * rentability * widget.formInfo['period'];

    finalValue = widget.formInfo['value'] + profit;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valor investido: R\$ ${widget.formInfo['value']}',
              style: const TextStyle(fontSize: 22, color: Colors.green),
            ),
            Text(
              'Duração: ${widget.formInfo['period']} ${widget.formInfo['period'] == 1 ? 'ano' : 'anos'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25.0),
                child: Column(
                  children: [
                    Text(
                        'Rentabilidade: ${(widget.formInfo['rentability'] * 100).toStringAsFixed(2)} %'),
                    Text(
                        'Lucro liquido anual: R\$ ${(profit).toStringAsFixed(2)}'),
                    Text('Valor final: R\$ ${finalValue.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: switchToForm, child: const Text("Retornar")),
            )
          ]),
    );
  }
}
