import 'package:flutter/material.dart';

class CreditPeriodWidget extends StatelessWidget {
  const CreditPeriodWidget({
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
              Text(
                item,
                style: const TextStyle(color: Colors.black45),
              ),
              Text(text),
            ],
          )),
    );
  }
}
