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
  double profitPerQuote = 0.0;
  double profitPerQuoteMontly = 0.0;

  double finalValue = 0.0;

  int cotaQuantity = 0;
  double cotaValue = 0.0;

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
    profitPerQuote = widget.formInfo['cotaValue'] * rentability;
    profitPerQuoteMontly = widget.formInfo['cotaValue'] * rentability / 12;
    profit = profitPerQuote * widget.formInfo['cotaQuantity'];

    cotaQuantity = widget.formInfo['cotaQuantity'];
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
              'Valor total investido: R\$ ${widget.formInfo['cotaQuantity'] * widget.formInfo['cotaValue']}',
              style: const TextStyle(fontSize: 22, color: Colors.green),
            ),
            Text(
              'Valor da cota: R\$ ${widget.formInfo['cotaValue']}',
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              'Quantidade de cotas: ${widget.formInfo['cotaQuantity']}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
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
                        'Rentabilidade anual por cota: ${(widget.formInfo['rentability'] * 100).toStringAsFixed(2)} %'),
                    Text(
                      'Lucro liquido anual por cota: R\$ ${(profitPerQuote).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      'Lucro liquido mensal por cota: R\$ ${(profitPerQuoteMontly).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      'Renda mensal: R\$ ${(profit / 12).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    Text(
                      'Lucro liquido anual: R\$ ${(profit).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Para um rendimento mensal aproximada de R\$ ${widget.formInfo['mensalValue']}, com rendimento mensal de R\$ ${(profitPerQuoteMontly).toStringAsFixed(2)} por cota , são necessárias ${((widget.formInfo['mensalValue'] / profitPerQuoteMontly).round()).toStringAsFixed(0)} cotas aproximadamente.',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(
              height: 30,
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
