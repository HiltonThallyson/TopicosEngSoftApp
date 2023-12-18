import 'package:flutter/material.dart';

import 'cdb_lci_results.dart';

class LciCdbTab extends StatefulWidget {
  const LciCdbTab({super.key});

  @override
  State<LciCdbTab> createState() => _LciCdbTabState();
}

class _LciCdbTabState extends State<LciCdbTab> {
  Map<String, dynamic> formInfo = {};
  bool isResultMode = false;
  int duration = 1;
  final formKey = GlobalKey<FormState>();
  final rentabilityCdbController = TextEditingController();
  final rentabilityLciController = TextEditingController();
  final valueController = TextEditingController();
  final periodController = TextEditingController();
  final cdiController = TextEditingController();

  @override
  void initState() {
    formInfo['cdi'] = 0.0;
    formInfo['rentabilityCdb'] = 0.0;
    formInfo['rentabilityLci'] = 0.0;
    formInfo['value'] = 0.0;
    formInfo['period'] = 1;
    cdiController.text = '';
    rentabilityCdbController.text = '';
    rentabilityLciController.text = '';
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
    formInfo['rentabilityCdb'] =
        double.parse(rentabilityCdbController.text) / 100;
    formInfo['rentabilityLci'] =
        double.parse(rentabilityLciController.text) / 100;
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

  // void switchMode(MODE mode) {
  //   setState(() {
  //     selectedMode = mode;
  //   });
  // }

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
        ? CdbLciResults(
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
                      controller: rentabilityCdbController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '% cdb',
                          labelText: 'Rentabilidade Cdb'),
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
                      keyboardType: TextInputType.number,
                      controller: rentabilityLciController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '% lci',
                          labelText: 'Rentabilidade Lci'),
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
                      keyboardType: TextInputType.number,
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
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: validateForm, child: const Text('SIMULAR'))
                  ],
                )));
  }
}
