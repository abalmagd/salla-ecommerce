import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/auth_bloc/auth_cubit.dart';
import 'package:salla/blocs/auth_bloc/auth_states.dart';
import 'package:salla/layout/app_layout.dart';
import 'package:salla/screens/auth/register_screen.dart';
import 'package:salla/widgets/button.dart';
import 'package:salla/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 10),
                  InputFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    validate: '* Email Address must not be empty',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 10),
                  InputFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    label: 'Password',
                    validate: '* Password must not be empty',
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: state is AuthLoginLoadingState,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )),
                    replacement: DefaultButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (await AuthCubit.get(context).logIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )) {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => AppLayout()));
                            }
                          }
                        },
                        text: 'Sign In'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                        child: Text(
                          'Register!',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Theme.of(context).accentColor,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
