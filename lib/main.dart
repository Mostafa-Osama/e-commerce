import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/cubit/shop_cubit/shop_cubit.dart';
import 'package:my_ecommerce/services/bloc_observer.dart';
import 'package:my_ecommerce/services/shared_preference.dart';
import 'package:my_ecommerce/trans/codegen_loader.g.dart';
import 'package:my_ecommerce/trans/locale_keys.g.dart';
import 'package:my_ecommerce/view/layout/home_layout.dart';
import 'package:my_ecommerce/view/login_screen/login_screen.dart';

import 'cubit/shop_cubit/Theme_cubit.dart';
import 'cubit/shop_cubit/Theme_states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreference.init();
  uId = await SharedPreference.getData(key: 'uId');
  isDark = SharedPreference.getData(key: 'theme');
  // lang = await SharedPreference.getData(key: 'lang');
  // print("lang = ${lang.toString()}");

  await Firebase.initializeApp();

  Widget widget;

  print('User Id = $uId');
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }

  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      saveLocale: true,
      assetLoader: CodegenLoader(),
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: MyApp(
        widget: widget,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({this.widget});

  @override
  Widget build(BuildContext context) {
    //var delegate;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getCategories()
            ..getProfile(uId)
            ..getAllAddress(),
        ),
   //     BlocProvider(create: (context) => ThemeCubit(),lazy: false,),
      ],
      child:
      // BlocBuilder<ThemeCubit, ThemeStates>(
      //   builder: (context, state) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          title: 'E-Commerce',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // themeMode: context.read<ThemeCubit>().dark
          //     ? ThemeMode.dark
          //     : ThemeMode.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
          home: widget,
     //   ),
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
        title: Text('e-commerce'),
      ),
      body: Center(),
    );
  }
}
