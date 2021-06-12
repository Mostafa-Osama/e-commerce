import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/Theme_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/cart_screen/cart_edit_screen.dart';
import 'package:my_ecommerce/view/edit_profile.dart';
import 'package:my_ecommerce/view/my_orders_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        context.localizationDelegates;
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.tit),

             actions: [
               cubit.selectedIndex == 1?IconButton(icon: Icon(Icons.edit), onPressed: (){
                 push(context, CartEditScreen());
               }):IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.blue,), onPressed: (){
               }),
             ],

            elevation: 0,
          ),
          body: Center(
            child: cubit.widgetOptions.elementAt(cubit.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: LocaleKeys.bottom_nav_product.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: LocaleKeys.bottom_nav_cart.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: LocaleKeys.bottom_nav_check.tr(),
              ),
            ],
            currentIndex: ShopCubit.get(context).selectedIndex,
            selectedItemColor: Colors.blue[300],
            onTap: cubit.onItemTapped,
          ),
          drawer: ConditionalBuilder(
            condition: ShopCubit.get(context).model == null,
            builder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            fallback: (context) {
             // cubit.getProfile();
              return Drawer(
              child: ListView(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        //backgroundImage ,
                        child: Container(
                          height: 100,
                          width: 100,
                          clipBehavior: Clip.none,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${cubit.model.photo}',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(cubit.model.email,
                              style: TextStyle(fontWeight: FontWeight.w600))),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        cubit.model.name,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(cubit.model.phone,
                              style: TextStyle(fontWeight: FontWeight.w600))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ListTile(
                        //   title: Text(LocaleKeys.dark_theme.tr()),
                        //   trailing:  Switch(value:context.read<ThemeCubit>().dark, onChanged: (onChanged){
                        //     context.read<ThemeCubit>().changeMode();
                        //     SharedPreference.saveData(value:context.read<ThemeCubit>().dark, key: 'theme');
                        //     print(context.read<ThemeCubit>().dark);
                        //   },),
                        // ),
                        ListTile(

                          title: Text(LocaleKeys.my_orders.tr()),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            push(context, MyOrdersScreen());
                          },

                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: () async  {

                               await context.setLocale(Locale('en')).then((value) =>  ShopCubit.get(context).onItemTapped(0));

                            }, child: Text('English')),
                            SizedBox(width: 20,),
                            TextButton(onPressed: ()  async{
                              await  context.setLocale(Locale('ar')).then((value) =>  ShopCubit.get(context).onItemTapped(0));


                            }, child: Text('العربية')),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                //width: double.infinity,
                                child: MaterialButton(
                                  onPressed: () {
                                    cubit.signOut(context);
                                  },
                                  child: Text(
                                    LocaleKeys.logout.tr(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blue[400],
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              width:50,
                              child: MaterialButton(
                                onPressed: () {
                                  push(context, EditProfileScreen());
                                },

                                child: Icon(Icons.edit,size: 20,color: Colors.white,),

                                color: Colors.blue[400],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            );
            },
            //
          ),
        );

      },
    );
  }
}
