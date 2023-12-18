import 'package:flutter/material.dart';

import 'fiis_results.dart';

class FiisTab extends StatefulWidget {
  const FiisTab({super.key});

  @override
  State<FiisTab> createState() => _FiisTabState();
}

class _FiisTabState extends State<FiisTab> {
  Map<String, dynamic> formInfo = {};
  bool isResultMode = false;
  int duration = 1;
  final formKey = GlobalKey<FormState>();
  final rentabilityController = TextEditingController();
  final valueController = TextEditingController();
  final periodController = TextEditingController();

  @override
  void initState() {
    formInfo['rentability'] = 0.0;
    formInfo['value'] = 0.0;
    formInfo['period'] = 1;
    rentabilityController.text = '';
    valueController.text = '';
    periodController.text = '';
    isResultMode = false;
    super.initState();
  }

  void validateForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formInfo['rentability'] = double.parse(rentabilityController.text) / 100;
    formInfo['value'] = double.parse(valueController.text);
    formInfo['period'] = duration;
    setState(() {
      isResultMode = true;
    });
    showValues();
  }

  void showValues() {
    formInfo.forEach((key, value) {
      print('$key = $value');
    });
  }

  void changeDuration(int selectedDuration) {
    setState(() {
      duration = selectedDuration;
    });
  }

  void changeScreen(bool isResult) {
    setState(() {
      isResultMode = isResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isResultMode
        ? FiisResults(
            formInfo: formInfo,
            returnToForm: changeScreen,
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Row(
                    //     children: [
                    //       const Text('Selecione tipo do investimento: '),
                    //       const SizedBox(
                    //         width: 15,
                    //       ),
                    //       DropdownButton(
                    //           alignment: Alignment.centerLeft,
                    //           value: selectedMode,
                    //           items: const [
                    //             DropdownMenuItem(
                    //                 value: MODE.lci, child: Text('LCI')),
                    //             DropdownMenuItem(
                    //                 value: MODE.cdb, child: Text('CDB')),
                    //           ],
                    //           onChanged: (mode) => switchMode(mode!)),
                    //     ],
                    //   ),
                    // ),
                    TextFormField(
                      controller: valueController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'R\$',
                          labelText: 'Valor'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um valor';
                        }

                        if (value.isNotEmpty) {
                          if (double.parse(value) < 0) {
                            return 'Insira um valor válido';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextFormField(
                      controller: rentabilityController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '% anual',
                          labelText: 'Rentabilidade anual'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um valor';
                        }

                        if (value.isNotEmpty) {
                          if (double.parse(value) < 0) {
                            return 'Insira um valor válido';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text('Selecione a duração: '),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton(
                              alignment: Alignment.centerLeft,
                              value: duration,
                              items: const [
                                DropdownMenuItem(
                                    value: 1, child: Text('1 ano')),
                                DropdownMenuItem(
                                    value: 2, child: Text('2 anos')),
                                DropdownMenuItem(
                                    value: 3, child: Text('3 anos')),
                              ],
                              onChanged: (duration) =>
                                  changeDuration(duration!)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: validateForm, child: const Text('SIMULAR'))
                  ],
                )));
    ;
  }
}
