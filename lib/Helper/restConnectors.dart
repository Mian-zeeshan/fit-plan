import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as resp;
import 'package:fit_plan/Helper/appConfig.dart';

class RestConnector {
  String url;
  String requestType;
  Map? formData;
  String dataType;
  bool isPaypal;
  bool clearCookies;
  RestConnector(
      {required this.url,
        this.requestType = "POST",
        this.formData,
        this.isPaypal = false,
        this.dataType = "json",
        this.clearCookies = false});

  // UiHelper helper = UiHelper();

  Future<resp.Response> getData(context) async {

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          connectTimeout: 6000,
          receiveTimeout: 3000,
          method: requestType,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,

      );

      Dio dio =  Dio(options);
      resp.Response response = await dio.request(
        url,
        data: formData,
      ).catchError((e){
        print(e);
      });

      return response;

    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      /*if (!mainController.checkInternet.values.first) {
        log("EXCEPTION INTENET 2 FROM GETDATA:" + e.toString());
        throw (InternetException());
      } else {
        */
      var x = e.toString();
      //print(x);
      throw Exception();
      // }
    }
  }
}