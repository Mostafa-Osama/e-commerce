import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/view/cart_screen/cart_edit_screen.dart';
import 'package:my_ecommerce/view/edit_profile.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title.elementAt(cubit.selectedIndex)),

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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Check Out',
              ),
            ],
            currentIndex: ShopCubit.get(context).selectedIndex,
            selectedItemColor: Colors.blue[300],
            onTap: cubit.onItemTapped,
          ),
          drawer: ConditionalBuilder(
            condition: state is GetProfileLoadingState,
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
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('DarkThem'),
                              Spacer(),
                              Switch(value:ShopCubit.get(context).dark, onChanged: (onChanged){
                                ShopCubit.get(context).changeMode();
                                SharedPreference.saveData(value:ShopCubit.get(context).dark, key: 'theme');
                                print(isDark);
                              },),
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
                                    'LogOut',
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
