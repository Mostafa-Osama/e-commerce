import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/login_screen/login_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class NewAddressScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var streetController = TextEditingController();
  var buildingController = TextEditingController();
  var floorController = TextEditingController();
  var apartmentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
builder:(context,state)=> Scaffold(
  appBar: AppBar(
    title: Text(LocaleKeys.new_addres_title.tr()),
  ),

  body:Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Column(
      children: [
        buildTextField(labelText: LocaleKeys.name_address_details.tr(), color: Colors.grey, keyboardType: TextInputType.name ,controller: nameController..text = ShopCubit.get(context).model.name ),
        SizedBox(height: 10,),
        buildTextField(labelText: LocaleKeys.city_address_details.tr(), color: Colors.grey,keyboardType: TextInputType.text, controller: cityController),
        SizedBox(height: 10,),
        buildTextField(labelText: LocaleKeys.street_address_details.tr(), color: Colors.grey,keyboardType: TextInputType.text, controller: streetController),
        SizedBox(height: 10,),
        buildTextField(labelText: LocaleKeys.building_address_details.tr(), color: Colors.grey,keyboardType: TextInputType.text, controller: buildingController),
        SizedBox(height: 10,),
        buildTextField(labelText: LocaleKeys.floor_address_details.tr(), keyboardType: TextInputType.number, controller: floorController),
        SizedBox(height: 10,),
        buildTextField(labelText: LocaleKeys.appartment_address_details.tr(), keyboardType: TextInputType.number, controller: apartmentController),
        SizedBox(height: 30,),

        Container(
          width: double.infinity,
            height: 50,
            child: MaterialButton(onPressed: (){
              ShopCubit.get(context).setAddress(name:nameController.text.toString() , city: cityController.text.toString(), street: streetController.text.toString(), building: buildingController.text.toString(), floor: floorController.text.toString(), apartment: apartmentController.text.toString(),number: ShopCubit.get(context).model.phone);
            },child: Text(LocaleKeys.save_address.tr(),style: TextStyle(color: Colors.white,fontSize: 20),),color: Colors.blue,)),


      ],
    ),
    ),
  ),
),
      );

  }
}
