import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'affichage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Input Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  List<bool> selectedOptions = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Prenom'),
            ),
            SizedBox(height: 20),
            Text('Select an option:'),
            Column(
              children: List.generate(
                3,
                    (index) => CheckboxListTile(
                  title: Text('Option ${index + 1}'),
                  value: selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[index] = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Send data to the API
                await postDataToApi();

                // Navigate to the Display Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AffichagePage(),
                  ),
                );
              },
              child: Text('Voir le résultat'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> postDataToApi() async {
    // Adjust the API endpoint based on your actual API configuration
    final apiUrl = Uri.parse('http://localhost:3000/persons');

    // Prepare the data to send
    final data = {
      'name': nameController.text,
      'surname': surnameController.text,
      'options': selectedOptions,
    };

    // Send a POST request
    await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: data.toString(),
    );
  }
}
