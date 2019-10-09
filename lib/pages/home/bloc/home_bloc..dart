

import 'dart:io';

import 'package:dod/plugin/controllers/photoController.dart';
import 'package:dod/plugin/models/dodModel.dart';
import 'package:dod/plugin/models/responseModel.dart';
import 'package:rxdart/rxdart.dart';




class BlocHome{

  ControllerDod controller;

  //! STREAMS
  var response = BehaviorSubject<List<Dod>>();
  var imagePath = BehaviorSubject<File>();
  var animationButton = BehaviorSubject<bool>();

  BlocHome(){
    controller = ControllerDod();
    animationButton.sink.add(false);
  }


    void sendPhoto()async{
      ResponseModel res;
      if(imagePath.value != null){
          response.sink.add(null);
          try{
          res = await controller.postPhoto(image: imagePath.value);
          List<Dod> list = (res.data as List).map((i) => Dod.fromJson(i)).toList();
          response.sink.add(list);
          }catch(e){
            response.addError(e);
          }

      }


    }

  void dispose(){
    response.close();
    imagePath.close();
    animationButton.close();
  }
}