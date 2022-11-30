import 'package:dio/dio.dart';
import 'package:flutter_weather/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DataService{
  Future<WeatherResponse?> getWeather( {String city='', double lon=0, double lat=0,String units='metric', String lang= 'en'} ) async{

    var dio = Dio();
    WeatherResponse? weatherData;
    final Uri uri;
    if(city != ''){
    final queryParameters = {
      'q': city,
      'appid' : 'b22d26946e5d68694b486295e4150dcc',
      'units' : units,
      'lang' :  lang
    };
    uri = Uri.https('api.openweathermap.org','/data/2.5/weather',queryParameters);
    }
    else{
      final queryParameters = {
      'appid' : 'b22d26946e5d68694b486295e4150dcc',
      'lat' : lat.toString(),
      'lon' : lon.toString(),
      'units' : units,
      'lang' :  lang
    };
    uri = Uri.https('api.openweathermap.org','/data/2.5/weather',queryParameters);
    }
    try {

    Response response = await dio.get(uri.toString());
    print(response.data);
      weatherData=WeatherResponse.fromJson(response.data);
      
    } on DioError catch (e) {
      if (e.response!=null) {
        print('STATUS: ${e.response?.statusCode}');
        Fluttertoast.showToast(
        msg: "Couldn't find the location.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return weatherData;
  }
}