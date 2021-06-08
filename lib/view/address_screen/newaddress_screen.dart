import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/view/login_screen/login_cubit.dart';

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
    title: Text('New Address'),
  ),

  body:Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Column(
      children: [
        buildTextField(labelText: 'Name', color: Colors.grey, keyboardType: TextInputType.name ,controller: nameController..text = ShopCubit.get(context).model.name ),
        SizedBox(height: 10,),
        buildTextField(labelText: 'City', color: Colors.grey,keyboardType: TextInputType.text, controller: cityController),
        SizedBox(height: 10,),
        buildTextField(labelText: 'Street', color: Colors.grey,keyboardType: TextInputType.text, controller: streetController),
        SizedBox(height: 10,),
        buildTextField(labelText: 'Building', color: Colors.grey,keyboardType: TextInputType.text, controller: buildingController),
        SizedBox(height: 10,),
        buildTextField(labelText: 'Floor', keyboardType: TextInputType.number, controller: floorController),
        SizedBox(height: 10,),
        buildTextField(labelText: 'Apartment', keyboardType: TextInputType.number, controller: apartmentController),
        SizedBox(height: 30,),

        Container(
          width: double.infinity,
            height: 50,
            child: MaterialButton(onPressed: (){
              ShopCubit.get(context).setAddress(name:nameController.text.toString() , city: cityController.text.toString(), street: streetController.text.toString(), building: buildingController.text.toString(), floor: floorController.text.toString(), apartment: apartmentController.text.toString(),number: ShopCubit.get(context).model.phone);
            },child: Text('SaveAddress',style: TextStyle(color: Colors.white,fontSize: 20),),color: Colors.blue,)),


      ],
    ),
    ),
  ),
),
      );

  }
}
