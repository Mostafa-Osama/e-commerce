import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/order_model.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.black,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => buildProduct(context,
                          ShopCubit.get(context).orderList[index], index),
                      itemCount: ShopCubit.get(context).prodModel.length,
                    ),
                  ),
                ],
              ),
            ),
          ),


      ),
    );
  }

  Widget buildProduct(context,OrderModel orderModel, index) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.56,
                      child: Text(
                        "${orderModel.grandPrice}",
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: 5,
                  ),
               //   Text(orderModel.order[index].name),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //  '${orderModel.order[index].qty}',
                  //   style: TextStyle(
                  //       decoration: TextDecoration.lineThrough,
                  //       fontSize: 10,
                  //       color: Colors.grey),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
