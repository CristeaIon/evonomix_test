import 'package:evonomix_test/data/random_number_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({Key? key}) : super(key: key);
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Completati datele',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Numele'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Prenume'),
                ),
                Row(
                  children: [
                    const SizedBox(width: 90, child: Text('Angajat')),
                    Checkbox(value: true, onChanged: (v) {}),
                    const SizedBox(width: 90, child: Text('Neangajat')),
                    Checkbox(value: false, onChanged: (v) {}),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Titlu Job'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Suma venitului lunar'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blueGrey[200]),
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    final image = file?.readAsBytes();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Poza ultimei facturi'),
                      Icon(Icons.add_a_photo)
                    ],
                  ),
                ),
                //const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
