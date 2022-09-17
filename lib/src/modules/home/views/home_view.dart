import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<int> tapeValues;

  @override
  void initState() {
    super.initState();
    tapeValues = [0, 1, 0, 0, 1];
    roll();
  }

  void roll() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 800));
      int last = tapeValues.removeLast();
      tapeValues = [last, ...tapeValues];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: List.generate(
                    tapeValues.length,
                    (i) => Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text('${tapeValues[i]}'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
