import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/address_model.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/address_screen/newaddress_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if (state is GetAddressSuccessState){
          ShopCubit.get(context).getOrder();
        }
      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.address_title.tr(),
            ),

          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).orderAddress != null,
            builder:(context)=> ListView.builder(
            itemBuilder: (context, index) => InkWell(
              child: buildOrderInfo(
                  context, ShopCubit.get(context).orderAddress[index],index),
              onTap: (){
                cubit.getAddress(index: index).then((value) {
                  SharedPreference.saveData(value: index, key: 'index');
               //   cubit.getOrder();
                });

              },
            ),
            itemCount: ShopCubit.get(context).orderAddress.length,
      ),
            fallback: (context)=>Center(child: Text(LocaleKeys.add_address.tr(),style: TextStyle(fontSize: 20),),),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              push(context, NewAddressScreen());
            },
          ),
        );
      },
    );
  }

  Widget buildOrderInfo(context, AddressModel addressModel,index) {
    var cubit = ShopCubit.get(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
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
                        text: '${addressModel.apartment}',
                        style: TextStyle(fontSize: 15, color: Colors.grey)),
                  ])),
                  Text('${ShopCubit.get(context).model.phone}'),
                ],
              ),
           //   Spacer(),
         //  cubit.addressModel.status? Icon(Icons.check,color: Colors.blue,): Icon(Icons.height,color: Colors.red,),
            ],
          ),
        ),
      ),
    );
  }
}
