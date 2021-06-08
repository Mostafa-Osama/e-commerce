import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/components/reusable.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/address_model.dart';
import 'package:my_ecommerce/model/cart_model.dart';
import 'package:my_ecommerce/model/category_model.dart';
import 'package:my_ecommerce/model/order_model.dart';
import 'package:my_ecommerce/model/product_model.dart';
import 'package:my_ecommerce/model/user_model.dart';
import 'package:my_ecommerce/view/ordersummary_screen.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/view/cart_screen/cart_screen.dart';
import 'package:my_ecommerce/view/login_screen/login_screen.dart';
import 'package:my_ecommerce/view/category_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  List<String> title = [
    'CategoryScreen',
    'CartScreen',
    'OrderSummary',
  ];

  List<Widget> widgetOptions = <Widget>[
    CategoryScreen(),
    CartScreen(),
    //NewAddressScreen(),
    OrderSummary(),
    // AddressScreen(),
  ];

  void onItemTapped(int index) {
    if (index == 1) {
      getFromCart();
    }
    selectedIndex = index;

    emit(BottomNavBarChangeState());
  }

  UserModel model;

  Future<void> getProfile(String uId) async {
    emit(GetProfileLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((event) {
      print(id);
      model = UserModel.fromJson(event.data());
      emit(GetProfileSuccessState());
    });
  }

  void updateProfile({String uId, String name, String email, String phone}) {
    emit(UpdateProfileLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      emit(UpdateProfileSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateProfileErrorState());
    });
  }

  List<CategoryModel> catModel = [];

  void getCategories() {
    emit(GetCategoryLoadingState());
    FirebaseFirestore.instance.collection('category').get().then((value) {
      value.docs.forEach((element) {
        catModel.add(CategoryModel.fromJson(element.data()));
        print(element.data()['name']);
      });
      emit(GetCategorySuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetCategoryErrorState());
    });
  }

  List<ProductModel> prodModel = [];

  void getProduct({@required String id}) {
    emit(GetProductLoadingState());
    FirebaseFirestore.instance
        .collection('category')
        .doc(id)
        .collection('product')
        .get()
        .then((value) {
      prodModel = [];
      value.docs.forEach((element) {
        prodModel.add(ProductModel.fromJson(element.data()));
        print(prodModel[0].name);
        print(prodModel[0].price);
        print(prodModel[0].oldPrice);
      });
      emit(GetProductSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetProductErrorState());
    });
  }

  List<CartModel> cartModel = [];
  List<String> pId = [];

  void addToCart(
      {@required String image,
      @required String name,
      @required String price,
      @required String oldPrice,
      int quantity = 1}) {
    emit(SetToCartLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .add({
      'image': image,
      'name': name,
      'price': price,
      'old price': oldPrice,
      'quantity': quantity,
      'date': DateTime.now().toString(),
    }).then((value) {
      pId.add(value.id.toString());
      print(value.id.toString());
      print("index 0 = ${pId[0]}");
      print("index 1 = ${pId[1]}");
      print("index 2 = ${pId[2]}");
      //getFromCart();
      emit(SetToCartSuccessState());
    }).catchError((onError) {
      emit(SetToCartErrorState());
    });
  }

  // void getFromCart() {
  //   cartModel = [];
  //   emit(GetFromCartLoadingState());
  //   FirebaseFirestore.instance.collection('users').doc(uId).collection('cart').orderBy('date').get().then((value) {
  //     value.docs.forEach((element) {
  //       cartModel.add(CartModel.fromJson(element.data()));
  //     });
  //     emit(GetFromCartSuccessState());
  //     getTotalPrice();
  //   }).catchError((onError){
  //     print(onError.toString());
  //     emit(GetFromCartErrorState());
  //   });
  // }
  getFromCart() {
    emit(GetFromCartLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      cartModel = [];
      event.docs.forEach((element) {
        cartModel.add(CartModel.fromJson(element.data()));
        emit(GetFromCartSuccessState());
        getTotalPrice();
      });
    });
  }

  void deleteFromCart(index) {
    emit(DeleteFromCartLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(pId[index])
        .delete()
        .then((value) {
      pId.removeAt(index);
      if (pId.length == 0) {
        this.totalPrice = 0;
      }
      emit(DeleteFromCartSuccessState());
      getFromCart();
    }).catchError((onError) {
      print(onError.toString());
      emit(DeleteFromCartErrorState());
    });
  }

  int quantity = 1;
  double totalPrice = 0;

  void increase(int index) {
    //this.totalPrice = 0;
    cartModel[index].quantity++;
    this.totalPrice =
        double.parse(cartModel[index].price) * cartModel[index].quantity;
    print(this.totalPrice.toString());
    print(double.parse(cartModel[index].price).toString());
    update(index);
    emit(IncreaseQuantity());
  }

  void decrease(int index) {
    if (cartModel[index].quantity == 0) {
      return;
    }
    cartModel[index].quantity--;
    this.totalPrice =
        double.parse(cartModel[index].price) * cartModel[index].quantity;
    update(index);
    emit(DecreaseQuantity());
  }

  getTotalPrice() {
    totalPrice = 0;
    cartModel.forEach((element) {
      totalPrice = totalPrice + double.parse(element.price) * element.quantity;
    });
    emit(GetTotalPriceSuccessState());
  }

  update(int index) {
    emit(UpdateQuantityLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(pId[index])
        .update({'quantity': cartModel[index].quantity}).then((value) {
      emit(UpdateQuantitySuccessState());
      //getFromCart();
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateQuantityErrorState());
    });
  }

  List<AddressModel> orderAddress = [];
  List<String> addressId = [];

  setAddress({
    @required String name,
    @required String city,
    @required String street,
    @required String building,
    @required String floor,
    @required String apartment,
    @required String number,
  }) {
    emit(SetAddressLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .add({
      'name': name,
      'city': city,
      'street': street,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'number': number,
      'status': false,
    }).then((value) {
      getAllAddress();
      emit(SetAddressSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SetAddressErrorState());
    });
  }

  AddressModel addressModel;

  getAllAddress() {
    orderAddress = [];
    emit(GetAllAddressLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        orderAddress.add(AddressModel.fromJson(element.data()));
        addressId.add(element.id);
      });
      print("0 = ${addressId[0]}");
      print("1 = ${addressId[1]}");
      emit(GetAllAddressSuccessState());
      print("name = ${orderAddress[0].name}");
      print("city = ${orderAddress[0].city}");
      print("building = ${orderAddress[0].building}");
    }).catchError((onError) {
      print(onError.toString());
      emit(GetAllAddressErrorState());
    });
  }

  String currentId = '';

  getAddress({index}) {
    emit(GetAddressLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .doc(addressId[index])
        .get()
        .then((value) {
      addressModel = AddressModel.fromJson(value.data());
      currentId = value.id;
      print(addressModel.name);
      print(addressModel.city);
      print(currentId);
      emit(GetAddressSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetAddressErrorState());
    });
  }

  String orderId = '';

  Future<void> setOrder({@required double grandPrice}) {
    emit(SetOrderLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .doc(currentId)
        .collection('order')
        .add({'grandprice': totalPrice + 20}).then((value) {
      orderId = value.id;

      setProductOrder(grandPrice: grandPrice);
      emit(SetOrderSuccessState());
    }).catchError((onError) {
      emit(SetOrderErrorState());
    });
  }

  List<dynamic> name = [];

  getSave() {
    name = [];
    cartModel.forEach((element) {
      name.add({'name': element.name, 'qty': element.quantity.toString()});
    });

    return name.toList();
  }

  setProductOrder({@required double grandPrice}) {
    getSave();
    emit(SetOrderProductLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .doc(currentId)
        .collection('order')
        .doc(orderId)
        .set({'order info': name.toList(), 'grand price': grandPrice}).then(
            (value) {
      emit(SetOrderProductSuccessState());
    }).catchError((onError) {
      emit(SetOrderProductErrorState());
    });
  }

  bool check = false;

  checked(index) {
    emit(CheckAddressLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .doc(addressId[index])
        .update({'status': !this.check}).then((value) {
      emit(CheckAddressSuccessState());
      ;
    }).catchError((onError) {});
    emit(CheckAddressErrorState());
  }

  bool dark = isDark;

  void changeMode() {
    dark = !dark;

    emit(ThemeModeState());
  }

  List<OrderModel> orderList = [];

  getOrder() {
    emit(GetOrdersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('address')
        .doc(currentId)
        .collection('order')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        orderList.add(OrderModel.fromJson(element.data()));
      }
      );
      print("${orderList[0].order}");
      print("${orderList[0]}");
      print("${orderList[0].grandPrice}");
      emit(GetOrdersSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetOrdersErrorState());
    });
  }

  signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      SharedPreference.clearData();
      push(context, LoginScreen());

      emit(SignOutSuccess());
    });
  }
}
