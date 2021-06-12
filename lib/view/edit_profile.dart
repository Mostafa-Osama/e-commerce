import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/layout/home_layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';


class EditProfileScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                          push(context,HomeScreen());
                        }),
                      ],
                    ),
                    CircleAvatar(
                      radius: 60,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${cubit.model.photo}')),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt_sharp,
                                size: 20,
                                color: Colors.white,
                              ),
                              onPressed: () {
                             //   cubit.getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        hintText: LocaleKeys.new_email.tr(),
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
                        prefixIcon: Icons.person,
                        hintText: LocaleKeys.new_name.tr(),
                        hintColor: color,
                        borderRadius: 20,
                        filled: true,
                        fillColor: Colors.grey[200],
                        controller: nameController),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.phone,
                        hintText: LocaleKeys.new_phone.tr(),
                        hintColor: color,
                        borderRadius: 20,
                        filled: true,
                        fillColor: Colors.grey[200],
                        controller: phoneController),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                        child: MaterialButton(
                      onPressed: () {
                        if(emailController.text.isEmpty){
                          emailController.text=cubit.model.email;
                        }
                        if(nameController.text.isEmpty){
                          nameController.text=cubit.model.name;
                        }
                        if(phoneController.text.isEmpty){
                          phoneController.text=cubit.model.phone;
                        }
                        cubit.updateProfile(uId:uId,email: emailController.text,name: nameController.text,phone: phoneController.text);
                          push(context, HomeScreen());

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(LocaleKeys.edit_profile.tr(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                      color: Colors.blue[400],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}
