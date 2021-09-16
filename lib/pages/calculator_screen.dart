import 'package:evonomix_test/pages/client_personal_data_screen.dart';
import 'package:flutter/material.dart';

class CreditCalculatorScreen extends StatefulWidget {
  const CreditCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CreditCalculatorScreen> createState() => _CreditCalculatorScreenState();
}

class _CreditCalculatorScreenState extends State<CreditCalculatorScreen> {
  double value = 100;
  //int _buttonIndex = 0;
  final List<bool> _selections = [true, false, false, false];
  final List<String> _buttons = const ['1 luna', '3 luni', '6 luni', '12 luni'];
  String period = '';
  double interest = 0;
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Calculator Credit',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * .27,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Alege-ti suma:',
                        style: TextStyle(color: Colors.blue))),
                Slider(
                    // activeColor: Colors.white,
                    // inactiveColor: Colors.white,
                    label: value.toString(),
                    value: value,
                    divisions: 18,
                    min: 100,
                    max: 1000,
                    onChanged: (val) {
                      setState(() {
                        value = val;
                        interest = getMonthInterest();
                        sum = getTotalSum();
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '100 RON',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      Text(
                        '1000 RON',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Alege-ti Perioada:',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
                const SizedBox(height:10),
                ToggleButtons(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('1 luna'),
                    ),
                    
                    Container(
                      decoration: BoxDecoration(),
                      child: Text('3 luni')),
                    Text('6 luni'),
                    Text('12 luni'),
                  ],
                  constraints:const BoxConstraints(minWidth: 90,minHeight: 45),
                  renderBorder: false,
                  isSelected: _selections,
                  onPressed: (index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _selections.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selections[buttonIndex] = !_selections[buttonIndex];
                          period = _buttons[index];
                          interest = getMonthInterest();
                          sum = getTotalSum();
                        } else {
                          _selections[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CreditTermenWidget(item: 'Suma Totala', text: '$sum'),
                CreditTermenWidget(item: 'Termenul', text: period),
                CreditTermenWidget(
                    item: 'Rata Lunara', text: interest.toStringAsFixed(2)),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalDataScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.check_circle_outlined),
                Text('Solicita Credit'),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  double getTotalSum() {
    if (period.isNotEmpty) {
      return value + (value * .01 * int.parse(period.split(' ').first));
    }
    return value + value * .01;
  }

  double getMonthInterest() {
    if (period.isNotEmpty) {
      return value / int.parse(period.characters.first) + value * .01;
    }
    return value / 1 + value * .01;
  }
}

class CreditTermenWidget extends StatelessWidget {
  const CreditTermenWidget({
    Key? key,
    required this.item,
    required this.text,
  }) : super(key: key);

  final String item;
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: 60,
          width: size.width * .28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(item),
              Text(text),
            ],
          )),
    );
  }
}
