import 'dart:convert';

import 'package:evonomix_test/api/random_number_api.dart';
import 'package:evonomix_test/providers/credit_calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'widgets/form_field_item.dart';

enum Clientstatus { angajat, neangajat }

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobNameController = TextEditingController();
  final _revenuController = TextEditingController();

  String? imageName;

  Clientstatus? status;

  String? image;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreditCalculator>(context);

    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Completati datele',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: orientation == Orientation.portrait
              ? size.height - 130
              : size.width * .6,
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: orientation == Orientation.portrait
                  ? size.height * 5
                  : size.width * 5,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  FormFieldItem(
                      keyboardType: TextInputType.name,
                      hintName: 'Numele',
                      validator: (value) => valueValidator(value),
                      onSave: (val) {
                        _lastNameController.text = val as String;
                      }),
                  const SizedBox(height: 10),
                  FormFieldItem(
                    keyboardType: TextInputType.name,
                    hintName: 'Prenume',
                    validator: (value) => valueValidator(value),
                    onSave: (val) {
                      _firstNameController.text = val as String;
                    },
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 90, child: Text('Angajat')),
                      Radio<Clientstatus?>(
                          value: Clientstatus.angajat,
                          groupValue: status,
                          onChanged: (value) {
                            status = value;
                            setState(() {});
                          }),
                      const SizedBox(width: 90, child: Text('Neangajat')),
                      Radio<Clientstatus>(
                          value: Clientstatus.neangajat,
                          groupValue: status,
                          onChanged: (value) {
                            status = value;
                            setState(() {});
                          }),
                    ],
                  ),
                  status == Clientstatus.angajat
                      ? FormFieldItem(
                          keyboardType: TextInputType.text,
                          hintName: 'Titlu Job',
                          validator: (value) => valueValidator(value),
                          onSave: (job) {
                            _jobNameController.text = job as String;
                          },
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  FormFieldItem(
                    keyboardType: TextInputType.number,
                    hintName: 'Suma venitului lunar',
                    validator: (value) => valueValidator(value),
                    onSave: (revenue) {
                      _revenuController.text = revenue as String;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.blueGrey[200]),
                    onPressed: () async {
                      try {
                        final file =
                            await picker.pickImage(source: ImageSource.gallery);
                        imageName = file?.name
                            .replaceAll('image_picker', '')
                            .substring(file.name.length - 20);
                        final bytes = await file?.readAsBytes();
                        image = base64Encode(bytes!.toList());
                        setState(() {});
                      } catch (e) {
                        throw 'Platform Exception:$e';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(imageName ?? 'Poza ultimei facturi'),
                        const Icon(Icons.add_a_photo)
                      ],
                    ),
                  ),
                  orientation == Orientation.portrait
                      ? const Expanded(child: SizedBox())
                      : Container(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (imageName != null) {
                          if (status != null) {
                            try {
                              final creditData = {
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'hasJob': status == Clientstatus.angajat
                                    ? true
                                    : false,
                                'jobName': _jobNameController.text,
                                'revenue': _revenuController.text,
                                'sum': provider.credit,
                                'period': provider.period,
                                'image': image,
                              };
                              final result = await RandomNumberApi()
                                  .getRandomNumberFromApi(creditData);
                              if (result < 6) {
                                showResponseDialog(
                                    title: 'Atentie!',
                                    message:
                                        'Ne pare rau, cerere dumneavoastra nu a fost acceptata');
                              } else {
                                showResponseDialog(
                                  title: 'Felicitari !!!',
                                  message:
                                      'Cererea dumneavoastra a fost acceptata',
                                );
                              }
                            } catch (e) {
                              showResponseDialog(
                                  title: 'Eroare de conexiune',
                                  message:
                                      'Aplicatia nu a putut transmite cererea d-stra din cauza unei erori de conexiune');
                            }
                          } else {
                            showResponseDialog(
                                title: 'Eroare',
                                message:
                                    'Nu ati indicat statutul ocupational. Alege-ti o vrianta din cele propuse si mai incercati o data');
                          }
                        } else {
                          showResponseDialog(
                              title: 'Eroare',
                              message:
                                  'Nu ati atasat poza la o factura emisa pe numele d-stra. Atasati o poza si mai incercati o data.');
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check_circle_outlined),
                        Text('Trimite Cererea'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? valueValidator(String? value) {
    if (value!.isEmpty) {
      return 'Completati cimpul';
    }
  }

  void showResponseDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        const padding = EdgeInsets.all(5);
        return AlertDialog(
          title: Text(title),
          titlePadding: padding,
          content: Text(message),
          contentPadding: padding,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }
}
