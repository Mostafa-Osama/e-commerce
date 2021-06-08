import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/cart_model.dart';

class CartEditScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state){
          //ShopCubit.get(context).getFromCart();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(icon:Icon(Icons.arrow_back),onPressed: (){Navigator.of(context).pop();},),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context,index)=>buildProduct(context,ShopCubit.get(context).cartModel[index],index),
                      itemCount: ShopCubit.get(context).cartModel.length,
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.blue),
                  //       borderRadius: BorderRadius.circular(20)
                  //   ),
                  //   width: double.infinity,
                  // ),
                ],
              ),
            ),

          );
        },
      ),
    );
  }

  Widget buildProduct(context,CartModel cartModel,index){
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(

              height: 110,
              width: 80,
              child: Image.network(cartModel.image,fit: BoxFit.cover,),
              //'https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/gaming.png?alt=media&token=5abd9359-ddad-4ebd-9f0d-1600bebfc76e',fit: BoxFit.cover,),
            ),
            SizedBox(width: 10,),
            Container(
            //  padding: EdgeInsets.only(left: 5,right: 5),
              height: 140,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Stack(
                children: [
                  Align(child: IconButton(icon: Icon(Icons.close,size: 15,), onPressed: (){
                    ShopCubit.get(context).deleteFromCart(index);
                  }),alignment: Alignment.topRight,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //  width: double.infinity,
                          child: Text(cartModel.name,style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(cartModel.price,style: TextStyle(fontSize: 15),),
                              Text(cartModel.oldPrice,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 10,color: Colors.grey),),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){
                            ShopCubit.get(context).increase(index);
                            //    ShopCubit.get(context).getTotalPrice(index);
                            print('${ ShopCubit.get(context).quantity}');
                          },icon: Icon(Icons.add),color: Colors.blue,),
                          Text('${cartModel.quantity}'),
                          IconButton(onPressed: (){
                            ShopCubit.get(context).decrease(index);
                            //   ShopCubit.get(context).getTotalPrice(index);
                            print('${ ShopCubit.get(context).quantity}');
                          },icon: Icon(Icons.minimize),color: Colors.blue,alignment: Alignment.topCenter,),
                        ],),


                    ],
                  ),
                ],
              ),
            ),
          ],),
      ),

    );
  }

}
