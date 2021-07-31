import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/blocs/auth_bloc/auth_cubit.dart';
import 'package:salla/blocs/auth_bloc/auth_states.dart';
import 'package:salla/layout/app_layout.dart';
import 'package:salla/shared/styles/text.dart';
import 'package:salla/widgets/button.dart';
import 'package:salla/widgets/input_form_field.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextThemes.formTitle(context),
                  ),
                  Text(
                    'Register now to browse our hot offers',
                    style: TextThemes.normalText(context),
                  ),
                  SizedBox(height: 10),
                  InputFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    validate: '* Name must not be empty',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 10),
                  InputFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone Number',
                    validate: '* Phone Number must not be empty',
                    icon: Icons.email,
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
                    visible: state is AuthRegisterLoadingState,
                    child: Center(child: CircularProgressIndicator()),
                    replacement: DefaultButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (await AuthCubit.get(context).register(
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )) {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => AppLayout()));
                            }
                          }
                        },
                        text: 'Register'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextThemes.normalText(context),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => LoginScreen())),
                        child: Text(
                          'Login!',
                          style: TextThemes.normalText(context),
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
