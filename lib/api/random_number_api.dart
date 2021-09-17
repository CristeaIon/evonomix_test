import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RandomNumberApi {
  Future<int> getRandomNumberFromApi(Map<String,dynamic>creditData) async {
    try {
      final response = await http.get(Uri.parse(
          'http://www.randomnumberapi.com/api/v1.0/random?min=1&max=10&count=1'));
     // if (response.statusCode == 200) {
       final intList = json.decode(response.body)as List;
        return intList.first;
      // }else{

      // }
    } catch (e) {
      throw const HttpException('HttpException');
    }
  }
}
