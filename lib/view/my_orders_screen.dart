import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/order_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';



class Order {
  final String grandTotal;
  final String name;
  final String qty;

  Order(this.grandTotal, this.name, this.qty);
}

class MyOrdersScreen extends StatelessWidget {

  int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.orderList.length > 0,
          builder:(context)=> Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.my_orders.tr()),
            ),
            body: SafeArea(
              child: ListView.separated(
                separatorBuilder: (context,index)=> Divider(thickness: 0.5,color: Colors.grey,),
                itemBuilder: (context, index) {
                  return buildOrder(
                      ShopCubit.get(context).orderList[index], index, cubit);
                },
                itemCount: ShopCubit.get(context).orderList.length,
              ),
            ),
          ),
          fallback: (context)=> Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.my_orders.tr()),
            ),
            body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Icons.list,size: 200,color: Colors.grey[300]),),
              Center(child:Text(LocaleKeys.do_not_have_orders.tr(),style: TextStyle(fontSize: 25,color: Colors.grey[300]),)),
            ],
          )),
          )
        );
      },
    );
  }

//Order order

  Widget buildOrder(OrderModel orderModel, index, cubit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${LocaleKeys.order_num.tr()}: ${index+1}',style: TextStyle(fontSize: 20,color: Colors.grey),),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('${LocaleKeys.total_price.tr()} :',style: TextStyle(color: Colors.blue, fontSize: 20),),
                Spacer(),

                Text(
                  '${orderModel.grandPrice}',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ],),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('${LocaleKeys.order_date.tr()} :',style: TextStyle(color: Colors.blue, fontSize: 20),),
              Spacer(),

                  Text(
                    '${orderModel.date}',
                    style: TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('${LocaleKeys.order_state.tr()} :',style: TextStyle(color: Colors.blue, fontSize: 20),),
                  Spacer(),

                  Text(
                    'Preparing Order',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ],
              ),


            ],
          ),
          SizedBox(height: 10,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, ind) => Card(child:Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('${orderModel.order.list[ind].image}')),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    height: 120,
                    width: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${orderModel.order.list[ind].name}',style: TextStyle(color: Colors.blue, fontSize: 15),),
                        SizedBox(height: 10,),
                        Text('${LocaleKeys.qty.tr()} :${orderModel.order.list[ind].qty}',style: TextStyle(color: Colors.blue, fontSize: 15)),
                      ],
                    )
                ),
              ],
            ) ,),

            itemCount: orderModel.order.list.length,
          ),

        ],
      ),
    );
  }
}



