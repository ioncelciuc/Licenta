import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/utils/app_router.dart';
import 'package:flutter_app/utils/token_helper.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 32,
      ),
      child: TokenHelper.tokenExistsAndIsValid()
          ? GestureDetector(
              onTap: () {
                //go to profile screen
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    minRadius: 50,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  Text(
                    TokenHelper.getUser(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: 'Sign in',
                  elevation: 10,
                  onPressed: () {
                    AppRouter.openSignInPage(context);
                  },
                ),
                CustomButton(
                  title: 'Sign up',
                  elevation: 10,
                  onPressed: () {
                    AppRouter.openSignUpPage(context);
                  },
                ),
              ],
            ),
    );
  }
}
