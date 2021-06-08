import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/product_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
          //change this condition
          condition: ShopCubit.get(context).prodModel.length > 0,
          //state is GetProductSuccessState,
          //ShopCubit.get(context).prodModel.length>0,
          builder: (context) => SafeArea(
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
                          ShopCubit.get(context).prodModel[index], index),
                      itemCount: ShopCubit.get(context).prodModel.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget buildProduct(context, ProductModel productModel, index) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 135,
              width: 100,
              child: Image.network(
                productModel.image,
                fit: BoxFit.cover,
              ),
              //'https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/gaming.png?alt=media&token=5abd9359-ddad-4ebd-9f0d-1600bebfc76e',fit: BoxFit.cover,),
            ),
            SizedBox(
              width: 10,
            ),
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
                    productModel.name,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(productModel.price),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.oldPrice,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            for (int i = 0;
                                i < ShopCubit.get(context).cartModel.length;
                                i++) {
                              if (ShopCubit.get(context).cartModel[i].name ==
                                  ShopCubit.get(context)
                                      .prodModel[index]
                                      .name) {
                                print('if');
                                print(ShopCubit.get(context).cartModel[i].name);
                                print(ShopCubit.get(context)
                                    .prodModel[index]
                                    .name);
                                return;
                              }
                            }

                            ShopCubit.get(context).addToCart(
                                image: ShopCubit.get(context)
                                    .prodModel[index]
                                    .image,
                                name: ShopCubit.get(context)
                                    .prodModel[index]
                                    .name,
                                price: ShopCubit.get(context)
                                    .prodModel[index]
                                    .price,
                                oldPrice: ShopCubit.get(context)
                                    .prodModel[index]
                                    .oldPrice);



                          },
                          child: Text(
                            'ADD TO Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.blue,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
