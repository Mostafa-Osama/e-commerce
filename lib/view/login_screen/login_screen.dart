import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/layout/home_layout.dart';
import 'package:my_ecommerce/view/login_screen/login_cubit.dart';
import 'package:my_ecommerce/view/login_screen/login_states.dart';
import 'package:my_ecommerce/view/register_screen/register_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
            {

              SharedPreference.saveData(value: state.uId, key: 'uId').then((value){
               context.read<ShopCubit>().getProfile(state.uId);
                push(context, HomeScreen());
              });

              SharedPreference.saveData(value: id, key: 'id');

            }

        },
        builder: (context, state) => Scaffold(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 45, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              LocaleKeys.login.tr(),
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.login_text.tr(),
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
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email,
                                  hintText: LocaleKeys.email.tr(),
                                  hintColor: color,
                                  borderRadius: 20,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  controller: emailController),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextFormField(
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: LoginCubit.get(context).icon,
                                  onSuffixPressed: () {
                                    LoginCubit.get(context).show();
                                  },
                                  hintText: LocaleKeys.password.tr(),
                                  hintColor: color,
                                  borderRadius: 20,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  controller: passwordController,
                                  obscure: LoginCubit.get(context).isPassword),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        push(context, RegisterScreen());
                                      },
                                      child: Text(
                                        LocaleKeys.do_not_have_acc.tr(),
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            decoration: TextDecoration.underline),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: double.infinity,
                                child: MaterialButton(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    LoginCubit.get(context).login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      LocaleKeys.login.tr(),
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
