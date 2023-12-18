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
  final cotaValueController = TextEditingController();
  final cotaQuantityController = TextEditingController();
  final mensalValueController = TextEditingController();

  @override
  void initState() {
    formInfo['rentability'] = 0.0;
    formInfo['period'] = 1;
    formInfo['cotaValue'] = 0;
    formInfo['cotaQuantity'] = 1;
    formInfo['mensalValue'] = 0;
    rentabilityController.text = '';
    cotaValueController.text = '';
    cotaQuantityController.text = '';
    mensalValueController.text = '';
    isResultMode = false;
    super.initState();
  }

  void validateForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formInfo['rentability'] = double.parse(rentabilityController.text) / 100;
    formInfo['cotaValue'] = double.parse(cotaValueController.text);
    formInfo['cotaQuantity'] = int.parse(cotaQuantityController.text);
    formInfo['mensalValue'] = double.parse(mensalValueController.text);

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
                      keyboardType: TextInputType.number,
                      controller: cotaValueController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'R\$',
                          labelText: 'Valor da cota'),
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
                      controller: cotaQuantityController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'Quantidade',
                          labelText: 'Quantidade de cotas'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um valor';
                        }

                        if (value.isNotEmpty) {
                          if (int.parse(value) <= 0) {
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
                      controller: rentabilityController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '% anual cota',
                          labelText: 'Rentabilidade anual por cota'),
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
                      controller: mensalValueController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'Quanto quer ganhar por mês',
                          labelText: 'Rendimento mensal desejado'),
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

                    ElevatedButton(
                        onPressed: validateForm, child: const Text('SIMULAR'))
                  ],
                )));
    ;
  }
}
