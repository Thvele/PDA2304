import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'operation.freezed.dart';

@freezed
class Operation with _$Operation {
  const factory Operation({
    required int operationID,
    required String operationName,
    required String operationDescription,
    required String operationType,
    required String operationDate,
    required String operationAmount,
    User? user
  }) = _Operation;

  factory Operation.fromJson(dynamic json){
    return Operation(
      operationID: json['operationID'] as int,
      operationName: json['operationName'] as String,
      operationDescription: json['operationDescription'] as String,
      operationType: json['operationType'] as String,
      operationDate: json['operationDate'] as String,
      operationAmount: json['operationAmount'] as String
    );
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'operationName': operationName,
      'operationDescription': operationDescription,
      'operationType': operationType,
      'operationDate': operationDate,
      'operationAmount': operationAmount,
    };
  }
}
