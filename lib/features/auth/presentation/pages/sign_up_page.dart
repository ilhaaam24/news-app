import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/auth/presentation/widgets/button.dart';
import 'package:news_app/features/auth/presentation/widgets/form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello!",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.blue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    maxLines: 2,
                    textWidthBasis: TextWidthBasis.longestLine,
                    overflow: TextOverflow.ellipsis,
                    "Sign up to get started",
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(height: 40),
                  CustomFormField(label: "Username"),
                  SizedBox(height: 20),
                  CustomFormField(label: "Password", isPassword: true),
                  SizedBox(height: 20),
                  CustomFilledButton(title: "Sign Up", onPressed: () {}),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          context.pushNamed("sign_in");
                        },
                        child: Text("Sign In"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
