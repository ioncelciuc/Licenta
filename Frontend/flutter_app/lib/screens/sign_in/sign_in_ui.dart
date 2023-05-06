import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/components/custom_text_field.dart';

class SignInUi extends StatefulWidget {
  const SignInUi({super.key});

  @override
  State<SignInUi> createState() => _SignInUiState();
}

class _SignInUiState extends State<SignInUi> {
  bool obscureText = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        children: [
          const Text(
            'Sign in with your account to take advantage of features such as deck building, discovering different decks and saving your data online!',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            textEditingController: userController,
            hintText: 'username',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            textEditingController: passwordController,
            hintText: 'password',
            prefixIcon: const Icon(Icons.password),
            obscureText: obscureText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(height: 64),
          CustomButton(
            title: 'Sign In',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
