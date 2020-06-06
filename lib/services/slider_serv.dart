import 'package:flutter_online_store/repository/repository.dart';

class SliderServ {
  Repository _repository;
  SliderServ(){
    _repository = Repository();
  }

  getSliders() async {
    return await _repository.httpGet('sliders');
  }
}