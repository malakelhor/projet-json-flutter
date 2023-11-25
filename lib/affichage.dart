import 'package:flutter/material.dart';

class AffichagePage extends StatelessWidget {
  final String name;
  final String surname;
  final List<bool> selectedOptions;

  // Define options here
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  AffichagePage({
    required this.name,
    required this.surname,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom: $name'),
            Text('Prenom: $surname'),
            Text('Selected Options:'),
            Column(
              children: selectedOptions
                  .asMap()
                  .entries
                  .where((entry) => entry.value)
                  .map((entry) {
                int index = entry.key;
                String option = options[index];
                return Text(option);
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                // Send data to the API
                await postDataToApi();

                // Navigate to the Display Page with the required parameters
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AffichagePage(
                      name: nameController.text,
                      surname: surnameController.text,
                      selectedOptions: selectedOptions,
                    ),
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
}
