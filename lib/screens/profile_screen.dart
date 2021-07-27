import 'package:cirilla/blocs/app_bloc/app_cubit.dart';
import 'package:cirilla/blocs/app_bloc/app_states.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = AppCubit.get(context).user.data.name;
          phoneController.text = AppCubit.get(context).user.data.phone;
          emailController.text = AppCubit.get(context).user.data.email;
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 145,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: Colors.blue),
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(AppCubit.get(context).user.data.image),
                    ),
                  ),
                  SizedBox(height: 40),
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
                    icon: Icons.phone_android,
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
                  Visibility(
                    visible: state is AppProfileChangeDataLoadingState,
                    child: CircularProgressIndicator(),
                    replacement: DefaultButton(
                      text: 'Change your data',
                      fullWidth: true,
                      onPressed: () {
                        if (_formKey.currentState.validate() &&
                            !(nameController.text == AppCubit.get(context).user.data.name &&
                                phoneController.text == AppCubit.get(context).user.data.phone &&
                                emailController.text == AppCubit.get(context).user.data.email)) {
                          print(nameController.text);
                          print(phoneController.text);
                          print(emailController.text);
                          print(AppCubit.get(context).user.data.token);
                          AppCubit.get(context).changeData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        } else
                          print('No data changed');
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  DefaultButton(
                    text: 'Log out',
                    fullWidth: true,
                    buttonColor: Colors.red,
                    onPressed: () {
                      AppCubit.get(context).logOut().then((value) {
                        if (value)
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
