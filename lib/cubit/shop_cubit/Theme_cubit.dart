import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/cubit/shop_cubit/Theme_states.dart';


class ThemeCubit extends Cubit<ThemeStates>{


  ThemeCubit() : super(ThemeInitialState());

 static ThemeCubit get(context)=> BlocProvider.of(context);


  bool dark = false;



  void changeMode() {
    emit(ThemeModeLoadingState());
    dark = !dark;

    emit(ThemeModeState());
  }

}
