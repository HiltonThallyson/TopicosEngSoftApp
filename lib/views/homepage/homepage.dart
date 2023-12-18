import 'package:flutter/material.dart';

import '../widgets/fiis_tab.dart';
import '../widgets/lci_cdb_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Simule seu investimento'),
          bottom: const TabBar(tabs: [
            Tab(text: 'LCI/CDB'),
            Tab(text: 'IMOVÉIS'),
          ]),
        ),
        body: const TabBarView(children: [
          LciCdbTab(),
          FiisTab(),
        ]),
      ),
    );
  }
}
