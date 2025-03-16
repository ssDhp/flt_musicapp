import 'package:client/core/theme/app_pallet.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view_models/auth_viewmodel.dart';
import 'package:client/features/auth/views/pages/login_page.dart';
import 'package:client/features/auth/views/widgets/custom_button.dart';
import 'package:client/features/auth/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );

          showSnackBar(
            context: context,
            snackBarText: 'Account created sucessfully! Please login.',
            snackBarBackgroundColor: Colors.greenAccent,
          );
        },
        error: (error, st) {
          showSnackBar(
            context: context,
            snackBarText: 'ERROR: ${error.toString()}',
            snackBarBackgroundColor: Colors.redAccent,
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextfield(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextfield(
                      hintText: 'Email',
                      controller: emailController,
                    ),
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
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } else {
                          showSnackBar(
                            context: context,
                            snackBarText: 'Missing Fields!',
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
