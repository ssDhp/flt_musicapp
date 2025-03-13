import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/widgets/custom_button.dart';
import 'package:client/features/auth/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomTextfield(hintText: 'Name', controller: nameController),
              const SizedBox(height: 15),
              CustomTextfield(hintText: 'Email', controller: emailController),
              const SizedBox(height: 15),
              CustomTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                textLabel: 'Sign Up',
                onTap: () async {
                  await AuthRemoteRepository().signup(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign In.',
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
