import 'package:http/http.dart' as http;

class Repository {
  String _baseUrl = 'http://10.0.2.2:1337/products';

  httpGet(String api) async{
    return await http.get(_baseUrl + "/" + api);
  }
}