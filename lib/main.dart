import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_states.dart';
import 'package:my_ecommerce/model/address_model.dart';
import 'package:my_ecommerce/services/bloc_observer.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/view/layout/home_layout.dart';
import 'package:my_ecommerce/view/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  uId = SharedPreference.getData(key: 'uId');
  orderIndex= SharedPreference.getData(key: 'index');
  print("orderIndex =$orderIndex");
 // isDark = SharedPreference.getData(key: 'theme');
  await Firebase.initializeApp();




  Widget widget;

  print('User Id = $uId');
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getProfile(uId)..getCategories()..getFromCart()..getAllAddress(),
          lazy: false,
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          themeMode: ShopCubit.get(context).dark ? ThemeMode.dark:ThemeMode.light,
          darkTheme: ThemeData.dark(
          ),
          home: widget,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopApp'),
      ),
      body: Center(),
    );
  }
}
