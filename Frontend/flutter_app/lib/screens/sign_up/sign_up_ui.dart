import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/components/custom_text_field.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUi extends StatefulWidget {
  const SignUpUi({super.key});

  @override
  State<SignUpUi> createState() => _SignUpUiState();
}

class _SignUpUiState extends State<SignUpUi> {
  bool obscureText = true;
  bool obscureTextRepeatPassword = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  String isDataValid() {
    if (userController.text.isEmpty) {
      return 'Username can\'t be empty';
    }
    if (userController.text.length < 8) {
      return 'Username must be at least 8 characters long';
    }
    String password = passwordController.text;
    String repeatPassword = repeatPasswordController.text;
    if (password.isEmpty) {
      return 'You must choose a password';
    }
    RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    if (!passwordRegex.hasMatch(password)) {
      return 'Password must be at least 8 characters long and contain:\nAn uppercase character\nA lowecase character\nA number';
    }
    if (password != repeatPassword) {
      return 'Passwords don\'t match';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        children: [
          const Text(
            'Create an account to take advantage of features such as deck building, discovering different decks and saving your data online!',
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
          const SizedBox(height: 32),
          CustomTextField(
            textEditingController: repeatPasswordController,
            hintText: 'repeat password',
            prefixIcon: const Icon(Icons.password),
            obscureText: obscureTextRepeatPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureTextRepeatPassword = !obscureTextRepeatPassword;
                });
              },
              icon: Icon(
                obscureTextRepeatPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(height: 64),
          CustomButton(
            title: 'Sign Up',
            onPressed: () {
              String isDataValidMessage = isDataValid();
              if (isDataValidMessage.isNotEmpty) {
                SnackbarHandler(
                  context: context,
                  isError: true,
                  message: isDataValidMessage,
                  durationSeconds: 8,
                );
              } else {
                BlocProvider.of<AuthCubit>(context).signUp(
                  userController.text,
                  passwordController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
