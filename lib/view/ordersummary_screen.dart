import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/address_model.dart';
import 'package:my_ecommerce/model/cart_model.dart';
import 'package:my_ecommerce/view/address_screen/address_screen.dart';
import 'package:my_ecommerce/view/my_orders_screen.dart';

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is SetOrderSuccessState){
          ShopCubit.get(context).getOrder();
        }
        if(state is GetOrdersSuccessState){
          ShopCubit.get(context).deleteCart();
          push(context, MyOrdersScreen());
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).cartModel.length == 0,
        builder: (context)=>Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Icon(Icons.list,size: 200,color: Colors.grey[300]),),
            Center(child:Text('Pleas Add Some Product to your Cart',style: TextStyle(fontSize: 15,color: Colors.grey[300]),)),
          ],
        ),
        fallback:(context)=> Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Option',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     ShopCubit.get(context).addressModel == null? Container(child: InkWell(child: Text('Please Select an Address',style: TextStyle(color: Colors.blue,fontSize: 20),),onTap: (){
                       push(context, AddressScreen());
                       ShopCubit.get(context);
                     },),) : buildOrderInfo(context, ShopCubit.get(context).addressModel),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shipment 1',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => buildShipment(ShopCubit.get(context).cartModel[index]),
                        shrinkWrap: true,
                        itemCount: ShopCubit.get(context).cartModel.length,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      Text(
                        'Payment Summary',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Row(
                            children: [
                              Text('Order Cost'),
                              Spacer(),
                              Text("${ShopCubit.get(context).totalPrice} EGP"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('Delivery Cost'),
                              Spacer(),
                              Text('${20.0} EGP'),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),

              //Grand Total and PaymentButton
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Grand Total:'),
                        Spacer(),
                        Text(
                          '${ShopCubit.get(context).totalPrice + 20.0} EGP',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            ShopCubit.get(context).addressModel == null? ShopCubit.get(context).showMyDialog(context):
                            ShopCubit.get(context).setOrder(grandPrice: ShopCubit.get(context).totalPrice + 20);
                          },
                          child: Text(
                            'Order',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShipment(CartModel cartModel) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        cartModel.image),
                  ),
                ),
                height: 100,
                width: 60,
              ),
              SizedBox(width: 10,),
              Container(
                height: 100,
                //   width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(child: Text(cartModel.name,overflow: TextOverflow.ellipsis),),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('Qty:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${cartModel.quantity}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${cartModel.price}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderInfo(context, AddressModel addressModel) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${addressModel.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '${addressModel.city}',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.street}',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.building}',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.floor}',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.apartment}',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
              ])),
              Text('${ShopCubit.get(context).model.phone}'),
              TextButton(
                onPressed: () {
                  push(context, AddressScreen());
                },
                child: Text(
                  'Change Address',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
