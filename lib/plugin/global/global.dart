import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';


BehaviorSubject<double> sendProgress = BehaviorSubject<double>();
BehaviorSubject<double> receiveProgress = BehaviorSubject<double>();
BehaviorSubject<bool> statusPage = BehaviorSubject<bool>();
Dio dio = Dio();