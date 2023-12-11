import 'package:flutter/material.dart';

import 'results.dart';

enum MODE {
  lci,
  cdb,
}

class LciCdbTab extends StatefulWidget {
  const LciCdbTab({super.key});

  @override
  State<LciCdbTab> createState() => _LciCdbTabState();
}

class _LciCdbTabState extends State<LciCdbTab> {
  Map<String, dynamic> formInfo = {};
  bool isResultMode = false;
  var selectedMode = MODE.lci;
  int duration = 1;
  final formKey = GlobalKey<FormState>();
  final rentabilityController = TextEditingController();
  final valueController = TextEditingController();
  final periodController = TextEditingController();
  final cdiController = TextEditingController();

  @override
  void initState() {
    formInfo['cdi'] = 0.0;
    formInfo['rentability'] = 0.0;
    formInfo['mode'] = MODE.lci;
    formInfo['value'] = 0.0;
    formInfo['period'] = 1;
    cdiController.text = '';
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
    formInfo['cdi'] = double.parse(cdiController.text) / 100;
    formInfo['rentability'] = double.parse(rentabilityController.text) / 100;
    formInfo['mode'] = MODE.lci;
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

  void switchMode(MODE mode) {
    setState(() {
      selectedMode = mode;
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
        ? Results(
            formInfo: formInfo, returnToForm: changeScreen, mode: selectedMode)
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text('Selecione tipo do investimento: '),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton(
                              alignment: Alignment.centerLeft,
                              value: selectedMode,
                              items: const [
                                DropdownMenuItem(
                                    value: MODE.lci, child: Text('LCI')),
                                DropdownMenuItem(
                                    value: MODE.cdb, child: Text('CDB')),
                              ],
                              onChanged: (mode) => switchMode(mode!)),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: cdiController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '% cdi',
                          labelText: 'CDI'),
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
                          hintText: '% cdb',
                          labelText: 'Rentabilidade'),
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
                    // TextFormField(
                    //   controller: periodController,
                    //   decoration: const InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(15))),
                    //       hintText: 'Período',
                    //       labelText: 'Anos'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Insira um valor';
                    //     }

                    //     if (value.isNotEmpty) {
                    //       if (int.parse(value) < 1) {
                    //         return 'Insira um valor válido';
                    //       }
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: validateForm, child: const Text('SIMULAR'))
                  ],
                )));
  }
}
