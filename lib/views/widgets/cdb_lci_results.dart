import 'dart:math';

import 'package:flutter/material.dart';

class CdbLciResults extends StatefulWidget {
  final Map<String, dynamic> formInfo;
  final Function returnToForm;

  const CdbLciResults(
      {required this.formInfo, required this.returnToForm, super.key});

  @override
  State<CdbLciResults> createState() => _CdbLciResultsState();
}

class _CdbLciResultsState extends State<CdbLciResults> {
  double rentabilityOfCdiFromCdb = 0.0;
  double rentabilityOfCdiFromLci = 0.0;

  double profitCdb = 0.0;
  double profitLci = 0.0;

  double finalValueCdb = 0.0;
  double finalValueLci = 0.0;
  double bruteValueOfCdb = 0.0;
  double bruteValueOfLci = 0.0;

  double irPercentage = 0.0;
  double ir = 0.0;

  @override
  void initState() {
    calculateirIrPercentage();
    calculateResults();
    super.initState();
  }

  void switchToForm() {
    widget.returnToForm(false);
  }

  void calculateirIrPercentage() {
    final duration = widget.formInfo['period'] * 365;

    if (duration <= 180) {
      irPercentage = 22.5 / 100;
    } else if (duration >= 181 && duration <= 360) {
      irPercentage = 20 / 100;
    } else if (duration >= 361 && duration <= 720) {
      irPercentage = 17.5 / 100;
    } else {
      irPercentage = 15 / 100;
    }
  }

  void calculateResults() {
    rentabilityOfCdiFromCdb =
        widget.formInfo['rentabilityCdb'] * widget.formInfo['cdi'];
    rentabilityOfCdiFromLci =
        widget.formInfo['rentabilityLci'] * widget.formInfo['cdi'];
    bruteValueOfCdb = widget.formInfo['value'] *
        pow((1 + rentabilityOfCdiFromCdb), widget.formInfo['period']);
    bruteValueOfLci = widget.formInfo['value'] *
        pow((1 + rentabilityOfCdiFromLci), widget.formInfo['period']);
    profitCdb = bruteValueOfCdb - widget.formInfo['value'];
    profitLci = bruteValueOfLci - widget.formInfo['value'];

    ir = profitCdb * irPercentage;

    finalValueCdb = bruteValueOfCdb - ir;
    finalValueLci = bruteValueOfLci;
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
                    const Text('Investimento: CDB'),
                    Text(
                        'Rentabilidade: ${(widget.formInfo['rentabilityCdb'] * 100).toStringAsFixed(2)} %'),
                    Text(
                        'Valor bruto: R\$ ${bruteValueOfCdb.toStringAsFixed(2)}'),
                    Text('Lucro bruto: R\$ ${profitCdb.toStringAsFixed(2)}'),
                    Text(
                      'IR %: ${irPercentage * 100}%',
                      style: const TextStyle(color: Colors.red),
                    ),
                    Text(
                      'IR: R\$ ${ir.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    Text(
                      'Lucro liquido: R\$ ${(profitCdb - ir).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      'Valor final: R\$ ${finalValueCdb.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
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
                    const Text('Investimento: LCI'),
                    Text(
                        'Rentabilidade: ${(widget.formInfo['rentabilityLci'] * 100).toStringAsFixed(2)} %'),
                    Text(
                        'Valor bruto: R\$ ${bruteValueOfLci.toStringAsFixed(2)}'),
                    Text(
                      'Lucro liquido: R\$ ${(profitLci).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(
                      'Valor final: R\$ ${finalValueLci.toStringAsFixed(2)}',
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
              'Para um lucro próximo ao da LCI com CDB seria necessário, aproximadamente, uma rentabilidade de ${(widget.formInfo['rentabilityLci'] / (1 - irPercentage) * 100).toStringAsFixed(2)} %.',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
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
