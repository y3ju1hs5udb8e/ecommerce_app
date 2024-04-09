import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/user/auth/auth_provider.dart';
import 'package:project/views/screens/auth/login_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signup';
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AsyncError) {
          messageSnackBox(
            context: context,
            text: 'Invalid data, Please insert actual',
            time: 4,
          );
        } else if (next is AsyncData) {
          messageSnackBox(
            context: context,
            text: 'Sign up success, please login to continue',
            time: 4,
          );

          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
        }
      },
    );

    final state = ref.watch(signupProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: sizePadding(),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Register",
                  style: ThemeText.heading1,
                ),
                Text(
                  "Your your prefect day\nwith confident",
                  textAlign: TextAlign.center,
                  style: ThemeText.heading4,
                ),
                heightBox(height: 70),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'name',
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      heightBox(height: -5),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      heightBox(height: -5),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: Icon(
                              isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: isHidden,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      heightBox(height: 5),
                      state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : commonButton(
                              text: 'Sign up',
                              callback: () {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState?.saveAndValidate(
                                        focusOnInvalid: false) ??
                                    false) {
                                  final map = _formKey.currentState?.value;
                                  ref.read(signupProvider.notifier).createUser(
                                        name: map?["name"],
                                        email: map?["email"],
                                        password: map?["password"],
                                      );
                                }
                              },
                            ),
                      heightBox(height: -10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: ThemeText.heading4,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              "Login",
                              style: ThemeText.heading4,
                            ),
                          ),
                        ],
                      ),
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
