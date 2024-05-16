

import 'package:dio/dio.dart';
import 'package:twitch_clone/src/feature/broadcast/ui/broadcast_screen.dart';
import 'package:twitch_clone/src/utils/endpoints.dart';
import 'package:twitch_clone/src/utils/utils.dart';



   



class ApiClient {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: servername,));
  

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE3MTQ3MTU4MDAsImV4cCI6MTcyMzM1NTgwMCwibmJmIjoxNzE0NzE1ODAwLCJqdGkiOiJETnZ6dVRCOFpuUkJrZzkyIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.IxEopizedNw-bxXHPhdxk9K8E0oAo6pjWsrguqi-nVw',
      },
      baseUrl: servername,
    
      receiveTimeout: const Duration(seconds: 15000),
      connectTimeout: const Duration(seconds: 15000),
      
    ));
    

    return dio;
  }
}
