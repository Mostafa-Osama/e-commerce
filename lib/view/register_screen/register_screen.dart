import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/view/login_screen/login_screen.dart';
import 'package:my_ecommerce/view/register_screen/register_cubit.dart';
import 'package:my_ecommerce/view/register_screen/register_states.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            push(context, LoginScreen());
          }
        },
        builder:(context,state)=> Scaffold(
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.blue.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Register to see our new products',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextFormField(
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.person,
                                hintText: 'Enter Your Name',
                                hintColor: color,
                                borderRadius: 20,
                                filled: true,
                                fillColor: Colors.grey[200],
                                controller: nameController),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField(
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.phone,
                                hintText: 'Enter Your Phone',
                                hintColor: color,
                                borderRadius: 20,
                                filled: true,
                                fillColor: Colors.grey[200],
                                controller: phoneController),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                hintText: 'Enter Your Email',
                                hintColor: color,
                                borderRadius: 20,
                                filled: true,
                                fillColor: Colors.grey[200],
                                controller: emailController),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField(
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.lock,
                                suffixIcon: RegisterCubit.get(context).icon,
                                onSuffixPressed: () {
                                  RegisterCubit.get(context).show();
                                },
                                hintText: 'Enter Your Password',
                                hintColor: color,
                                borderRadius: 20,
                                filled: true,
                                fillColor: Colors.grey[200],
                                controller: passwordController,
                                obscure: RegisterCubit.get(context).isPassword),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: MaterialButton(
                                elevation: 0,
                                clipBehavior: Clip.antiAlias,
                                color: Colors.blue[300],
                                onPressed: () {
                                    RegisterCubit.get(context).userRegister(name: nameController.text,phone: phoneController.text,email: emailController.text, password: passwordController.text);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    flex: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
