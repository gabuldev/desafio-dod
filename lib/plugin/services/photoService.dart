
import 'package:dio/dio.dart';
import 'package:dod/plugin/global/global.dart';
import 'package:dod/plugin/models/dodModel.dart';
import 'package:dod/plugin/models/responseModel.dart';


class ServiceDod{

  final Dio _dio;
  //CONSTRUCTOR
  ServiceDod(this._dio);


///POSTS
  Future postPhoto({Map data}) async {
      ResponseModel response;
      try {
        await _dio.post(
          "/users/recognizes",
          data: data,
           onSendProgress: (int sent, int total){
          sendProgress.sink.add(sent/total);
        },
        onReceiveProgress: (int sent, int total){
          receiveProgress.sink.add(sent/total);
        }
          
          ).then((value){
          response = ResponseModel(
              error: false,
              msgError: "",
              data: value.data,
              statusCode: value.statusCode
          );

        });
      } on DioError catch (e) {
        print("ERRO UPLOAD PHOTO ${e.response}");
        if(e.response != null) {
          response = ResponseModel(
              error: true,
              statusCode: e.response.statusCode,
              msgError: e.response.data
          );
        } else{
          response = ResponseModel(
              error: true,
              statusCode: 0,
              msgError: e.message
          );
        }
      }
    return response;
  }



}