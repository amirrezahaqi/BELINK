import 'package:dio/dio.dart';

class DioService{
  final Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    return await dio.get(url,options: Options(
      responseType: ResponseType.json,
      method: 'Get'
    ));
  }

  Future<dynamic> postMethod({required String url , required Map<String,dynamic> param}) async {
    return await dio.post(
      url,
      data: param,
      options: Options(
          responseType: ResponseType.json,
          method: 'Post'
      )
    );
  }
}