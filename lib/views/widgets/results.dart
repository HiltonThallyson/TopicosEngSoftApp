import 'dart:math';

import 'package:flutter/material.dart';
import 'package:investapp/views/widgets/lci_cdb_tab.dart';

class Results extends StatefulWidget {
  final Map<String, dynamic> formInfo;
  final Function returnToForm;
  final MODE mode;

  const Results(
      {required this.formInfo,
      required this.returnToForm,
      required this.mode,
      super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  double rentabilityOfCdi = 0.0;

  double profit = 0.0;

  double finalValue = 0.0;
  double bruteValue = 0.0;

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
    rentabilityOfCdi = widget.formInfo['rentability'] * widget.formInfo['cdi'];
    bruteValue = widget.formInfo['value'] *
        pow((1 + rentabilityOfCdi), widget.formInfo['period']);
    profit = bruteValue - widget.formInfo['value'];
    if (widget.mode == MODE.cdb) {
      ir = profit * irPercentage;
    }
    finalValue = bruteValue - ir;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Investimento: ${widget.mode.name.toUpperCase()}'),
            Text('Valor investido: R\$ ${widget.formInfo['value']}'),
            Text(
                'Rentabilidade: ${(widget.formInfo['rentability'] * 100).toStringAsFixed(2)} %'),
            Text(
                'Duração: ${widget.formInfo['period']} ${widget.formInfo['period'] == 1 ? 'ano' : 'anos'}'),
            Text('Valor bruto: R\$ ${bruteValue.toStringAsFixed(2)}'),
            widget.mode == MODE.cdb
                ? Text('Lucro bruto: R\$ ${profit.toStringAsFixed(2)}')
                : const SizedBox(),
            widget.mode == MODE.cdb
                ? Text('IR %: ${irPercentage * 100}%')
                : const SizedBox(),
            widget.mode == MODE.cdb
                ? Text('IR: R\$ ${ir.toStringAsFixed(2)}')
                : const SizedBox(),
            Text('Lucro liquido: R\$ ${(profit - ir).toStringAsFixed(2)}'),
            Text('Valor final: R\$ ${finalValue.toStringAsFixed(2)}'),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text(widget.mode == MODE.lci
                  ? 'Para um lucro igual com CDB seria necessário uma rentabilidade de ${(widget.formInfo['rentability'] / (1 - irPercentage) * 100).toStringAsFixed(2)} %.'
                  : 'Para um lucro igual com LCI seria necessário uma rentabilidade de ${((widget.formInfo['rentability'] * (1 - irPercentage)) * 100).toStringAsFixed(2)} %.'),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35),
            //   child: Text(widget.mode == MODE.lci
            //       ? 'Para um lucro igual com CDB seria necessário uma rentabilidade de ${(widget.formInfo['rentability'] / (1 - irPercentage) * 100).toStringAsFixed(2)} %.'
            //       : 'Para um lucro igual com LCI seria necessário uma rentabilidade de ${((widget.formInfo['rentability'] * (1 - irPercentage)) * 100).toStringAsFixed(2)} %.'),
            // ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: switchToForm, child: const Text("Retornar"))
          ]),
    );
  }
}
