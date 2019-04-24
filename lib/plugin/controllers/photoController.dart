import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dod/plugin/models/responseModel.dart';
import 'package:dod/plugin/services/photoService.dart';
import 'package:path/path.dart';
import 'package:dod/plugin/global/global.dart';

class ControllerDod{

  ServiceDod service;

  ControllerDod(){
   dio.options.baseUrl = "https://tv.dodvision.com";
  
    this.service = ServiceDod(dio);
  }


  Future<ResponseModel> postPhoto({File image})async{
    if(image != null ){

      //RESET PROGRESS
       sendProgress.sink.add(0.0);
       receiveProgress.sink.add(0.0);
      String base64Image = base64Encode(image.readAsBytesSync());
      return await service.postPhoto(data: {"image":base64Image});
    }
    else{
      return ResponseModel(msgError: "Imagem nao pode ser nula!",error: true);
    }

  }





}