import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/components/constant.dart';
import 'package:my_ecommerce/view/login_screen/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void login({@required String email, @required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user.email);
          uId = value.user.uid;
          id = value.user.uid;
          emit(LoginSuccessState(value.user.uid));
    })
        .catchError((onError){
          print(onError.toString());
          emit(LoginErrorState());
    });
  }




  IconData icon = Icons.visibility;
  bool isPassword = true;

  void show(){
    isPassword = !isPassword;
    if(isPassword == true){
      icon = Icons.visibility;
    }else{
      icon = Icons.visibility_off;
    }

    emit(LoginVisibilityPassword());
  }

}
