import 'package:flutter/material.dart';

class AboutUi extends StatefulWidget {
  const AboutUi({super.key});

  @override
  State<AboutUi> createState() => _AboutUiState();
}

class _AboutUiState extends State<AboutUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        children: const [
          Text(
            'Proiect de licență realizat de Ciuc Ionuț-Tiberiu, sub îndrumarea domnului Lect. Dr. Vidrașcu Cristian.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Bachelor\'s thesis project developed by Ciuc Ionuț-Tiberiu, under the guidance of Lect. PhD Vidrașcu Cristian.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 64),
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Ciuc Ionuț-Tiberiu',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          SelectableText(
            'ioncelciuc2001@gmail.com',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Vidrașcu Cristian',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          SelectableText(
            'vidrascu@infoiasi.ro',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
