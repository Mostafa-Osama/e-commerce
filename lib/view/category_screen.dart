import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/category_model.dart';
import 'package:my_ecommerce/view/product_screen.dart';
import 'package:easy_localization/easy_localization.dart';




class Carousel{
  final String image;

  Carousel({@required this.image});
}

class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(condition: cubit.catModel.length < 3 ,
            fallback: (context)=>Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              CarouselSlider(
                  items: [
                    Image.network('https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/sale1.png?alt=media&token=e595a0a8-76d3-4a75-bb50-56167e97d664',fit: BoxFit.cover,),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/sale2.jpg?alt=media&token=90220549-f2c9-431c-a482-14c4fa0af45c',fit: BoxFit.cover),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/mye-commerce-7b81c.appspot.com/o/sale3.jpg?alt=media&token=7eeb5968-1666-4a3e-b5c0-c6d61c301122',fit: BoxFit.cover),
                  ],
                  options: CarouselOptions(

                    height: 200,
                    aspectRatio: 16/9,
                    viewportFraction: 1.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.elasticIn,
                    scrollDirection: Axis.horizontal,
                  )
              ),
              SizedBox(height: 20,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 20.0),
                  itemBuilder: (context, index) => InkWell(child: buildProduct(cubit.catModel[index]),onTap: (){
                    cubit.getProduct(id: cubit.catModel[index].name);
                    push(context, ProductScreen());
                  //  print(cubit.catModel[index].name);
                  },),
                  itemCount: cubit.catModel.length,
                ),
              ),
            ],),
          ),
        ),
        builder: (context)=>Center(child: CircularProgressIndicator())
        );

      },
    );
  }

  Widget buildProduct(CategoryModel category){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[400]),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
              '${category.image}',fit: BoxFit.fill,height: 160,),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2)
                ),
                  child: Center(child: Text('${category.name.tr()}',style: TextStyle(color: Colors.blue[300]),textAlign: TextAlign.center,)))),
        ],
      ),
    );
  }


}
