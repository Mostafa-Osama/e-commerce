import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/model/user_model.dart';
import 'package:my_ecommerce/view/register_screen/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
           await createUser(name: name, phone: phone, email: email, uid: value.user.uid);
      emit(RegisterSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState());
    });
  }

  createUser({
    @required String name,
    @required String phone,
    @required String email,
    @required String uid,
  }){

    emit(CreateUserLoadingState());
    UserModel model = UserModel(name: name, phone: phone, email: email, uid: uid,photo: 'https://th.bing.com/th/id/R270228b2f42fb29ee3d78cc3648cdf8f?rik=Bl7LXyvxlqtAtA&riu=http%3a%2f%2fmaestroselectronics.com%2fwp-content%2fuploads%2fbfi_thumb%2fblank-user-355ba8nijgtrgca9vdzuv4.jpg&ehk=MkRhNSd0LEk8mSKaG16NhjpL8dh8Oivfu9seWLDMjTc%3d&risl=&pid=ImgRaw');
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value) {


      emit(CreateUserSuccessState());

    }).catchError((onError){
      print(onError.toString());
      emit(CreateUserErrorState());
    });
  }

  IconData icon = Icons.visibility;
  bool isPassword = true;

  void show() {
    isPassword = !isPassword;
    if (isPassword == true) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }

    emit(RegisterVisibilityPassword());
  }
}
