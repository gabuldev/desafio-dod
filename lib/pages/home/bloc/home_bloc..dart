

import 'dart:io';

import 'package:dod/plugin/controllers/photoController.dart';
import 'package:dod/plugin/models/dodModel.dart';
import 'package:dod/plugin/models/responseModel.dart';
import 'package:rxdart/rxdart.dart';




class BlocHome{

  ControllerDod controller;

  //! STREAMS
  var response = BehaviorSubject<ResponseModel>();
  var imagePath = BehaviorSubject<File>();
  var animationButton = BehaviorSubject<bool>();

  BlocHome(){
    controller = ControllerDod();
    animationButton.sink.add(false);
  }


    void sendPhoto()async{
      ResponseModel res;
      if(imagePath.value != null){

          res = await controller.postPhoto(image: imagePath.value);
          response.sink.add(res);

      }


    }

  void dispose(){
    response.close();
    imagePath.close();
    animationButton.close();
  }
}