import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/product/products_provider.dart';
import 'package:project/logic/user/auth/auth_provider.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/auth/signup_screen.dart';
import 'package:project/views/screens/others/status_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/size.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authProvider,
      (previous, next) {
        if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credential'),
            ),
          );
        } else if (next is AsyncData) {
          ref.invalidate(userProvider);
          ref.invalidate(productProvider);
          Navigator.pushReplacementNamed(context, StatusScreen.routeName);
        }
      },
    );

    final state = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: sizePadding(),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Login",
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
                              text: 'Login',
                              callback: () {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState?.saveAndValidate(
                                        focusOnInvalid: false) ??
                                    false) {
                                  final map = _formKey.currentState?.value;

                                  ref.read(authProvider.notifier).loginUser(
                                        email: map?["email"],
                                        password: map?["password"],
                                      );
                                }
                              },
                            ),
                    ],
                  ),
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
                            context, SignUpScreen.routeName);
                      },
                      child: Text(
                        "Sign up",
                        style: ThemeText.heading4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
