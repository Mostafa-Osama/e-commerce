import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';



class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        body: SingleChildScrollView(
          child:
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.fill,image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/gaming%2Frtx3080.png?alt=media&token=11bd7f60-a576-4a8b-bf01-3f5a2ffecf04')),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){print('${ShopCubit.get(context).pId[0]}');
        //  print('${ShopCubit.get(context).pId[1]}');
          },
        ),
      ),

    );
  }
}
