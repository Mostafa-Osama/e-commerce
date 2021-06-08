import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/cart_model.dart';

class CartScreen extends StatelessWidget {

  final IconData icon;

  CartScreen({this.icon});


  @override
  Widget build(BuildContext context) {
      return Scaffold(

      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
      builder:(context,state){

        return ConditionalBuilder(condition: ShopCubit.get(context).cartModel.length == 0,
            builder: (context)=>SafeArea(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(Icons.list,size: 200,color: Colors.grey[300]),),
                Center(child:Text('Your Cart Is Empty',style: TextStyle(fontSize: 30,color: Colors.grey[300]),)),
              ],
            )),
            fallback:(context)=>SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(itemBuilder: (context,index)=>buildProduct(context,ShopCubit.get(context).cartModel[index],index),
                    itemCount: ShopCubit.get(context).cartModel.length,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:[
                        Column(
                          children: [
                            Text('TotalPrice',style: TextStyle(color: Colors.blue,fontSize: 20),),
                            SizedBox(height: 10,),
                            Text( "${ShopCubit.get(context).totalPrice}"),
                          ],
                        ),
                        Spacer(),
                        TextButton(onPressed: (){}, child: Text('CheckOut',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
        height: 140,
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
              padding: EdgeInsets.only(left: 20,right: 20),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
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
            ),
          ],),
      ),

    );
  }

}
