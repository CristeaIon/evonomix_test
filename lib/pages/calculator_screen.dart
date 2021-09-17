import 'package:evonomix_test/pages/client_personal_data_screen.dart';
import 'package:evonomix_test/providers/credit_calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'widgets/credit_period_widget.dart';

class CreditCalculatorScreen extends StatelessWidget {
  const CreditCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final provider = Provider.of<CreditCalculator>(context);
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: orientation == Orientation.portrait
              ? size.height - 100
              : size.width * .55,
          child: Column(
            children: [
              Container(
                height: orientation == Orientation.portrait
                    ? size.height * .31
                    : size.width * .31,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Alege-ti suma:',
                            style: TextStyle(color: Colors.blue))),
                    Slider(
                        label: provider.credit.toString(),
                        value: provider.credit,
                        divisions: 18,
                        min: 100,
                        max: 1000,
                        onChanged: (val) {
                          provider.credit = val;
                          provider.getMonthInterest();
                          provider.getTotalSum();
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
                    const SizedBox(height: 10),
                    ToggleButtons(
                      children: const [
                        Text('1 luna'),
                        Text('3 luni'),
                        Text('6 luni'),
                        Text('12 luni'),
                      ],
                      constraints:
                          const BoxConstraints(minWidth: 90, minHeight: 45),
                      renderBorder: false,
                      isSelected: provider.terms,
                      onPressed: (index) {
                        for (int buttonIndex = 0;
                            buttonIndex < provider.terms.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            provider.terms[buttonIndex] =
                                !provider.terms[buttonIndex];
                            provider.period = provider.buttons[index];
                            provider.getMonthInterest();
                            provider.getTotalSum();
                          } else {
                            provider.terms[buttonIndex] = false;
                          }
                        }
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
                    CreditPeriodWidget(
                        item: 'Suma Totala', text: '${provider.sum}'),
                    CreditPeriodWidget(item: 'Termenul', text: provider.period),
                    CreditPeriodWidget(
                        item: 'Rata Lunara',
                        text: provider.interest.toStringAsFixed(2)),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>const PersonalDataScreen()));
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
        ),
      ),
    );
  }
}
