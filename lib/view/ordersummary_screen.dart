import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/address_model.dart';
import 'package:my_ecommerce/model/cart_model.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/address_screen/address_screen.dart';
import 'package:easy_localization/easy_localization.dart';




class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is SetOrderSuccessState){
          ShopCubit.get(context).getOrder();
        }

      },
      builder: (context, state) =>Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.delivery_options.tr(),
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              ShopCubit.get(context).addressModel == null? Container(child: InkWell(child: Text(LocaleKeys.select_address.tr(),style: TextStyle(color: Colors.blue,fontSize: 20),),onTap: (){
                push(context, AddressScreen());
                ShopCubit.get(context);
              },),) : buildOrderInfo(context, ShopCubit.get(context).addressModel),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child:ConditionalBuilder(
                    condition: ShopCubit.get(context).cartModel.length == 0,
                    builder: (context)=>Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Icon(Icons.list,size: 200,color: Colors.grey[300]),),
                        Center(child:Text(LocaleKeys.add_to_cart.tr(),style: TextStyle(fontSize: 15,color: Colors.grey[300]),)),
                      ],
                    ),
                    fallback: (context)=> Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.shipment.tr(),
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
                          LocaleKeys.payment_summary.tr(),
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
                                Text(LocaleKeys.order_cost.tr()),
                                Spacer(),
                                Text("${ShopCubit.get(context).totalPrice} ${LocaleKeys.egp.tr()}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(LocaleKeys.delivery_cost.tr()),
                                Spacer(),
                                Text('${20.0} ${LocaleKeys.egp.tr()}'),
                              ],
                            ),
                          ]),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('${LocaleKeys.grand_Total.tr()} :'),
                                  Spacer(),
                                  Text(
                                    '${ShopCubit.get(context).totalPrice + 20.0} ${LocaleKeys.egp.tr()}',
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
                                        ShopCubit.get(context).deleteCart();
                                        ShopCubit.get(context).selectedIndex = 0;
                                    },
                                    child: Text(
                                      LocaleKeys.order.tr(),
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
              ),

              //Grand Total and PaymentButton

            ],
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
                        Text('${LocaleKeys.qty.tr()} :'),
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
                    text: '${addressModel.city} /',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.street} /',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.building} /',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.floor} /',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextSpan(
                    text: '${addressModel.apartment} ',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
              ])),
              Text('${ShopCubit.get(context).model.phone}'),
              TextButton(
                onPressed: () {
                  push(context, AddressScreen());
                },
                child: Text(
                  LocaleKeys.change_address.tr(),
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
