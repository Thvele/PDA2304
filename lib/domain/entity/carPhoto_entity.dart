import 'dart:html';

import 'package:pr2/domain/entity/role_entity.dart';

class CarPhotoEntity{
  late int id;
  final Blob photo;

  CarPhotoEntity({required this.photo});
}

//enum CarPhotoEnum{BMW_photo, Mercedez_photo, Mitsubishi_photo, Subaru_photo}