// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Operation {
  int get operationID => throw _privateConstructorUsedError;
  String get operationName => throw _privateConstructorUsedError;
  String get operationDescription => throw _privateConstructorUsedError;
  String get operationType => throw _privateConstructorUsedError;
  String get operationDate => throw _privateConstructorUsedError;
  String get operationAmount => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OperationCopyWith<Operation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationCopyWith<$Res> {
  factory $OperationCopyWith(Operation value, $Res Function(Operation) then) =
      _$OperationCopyWithImpl<$Res, Operation>;
  @useResult
  $Res call(
      {int operationID,
      String operationName,
      String operationDescription,
      String operationType,
      String operationDate,
      String operationAmount,
      User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$OperationCopyWithImpl<$Res, $Val extends Operation>
    implements $OperationCopyWith<$Res> {
  _$OperationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operationID = null,
    Object? operationName = null,
    Object? operationDescription = null,
    Object? operationType = null,
    Object? operationDate = null,
    Object? operationAmount = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      operationID: null == operationID
          ? _value.operationID
          : operationID // ignore: cast_nullable_to_non_nullable
              as int,
      operationName: null == operationName
          ? _value.operationName
          : operationName // ignore: cast_nullable_to_non_nullable
              as String,
      operationDescription: null == operationDescription
          ? _value.operationDescription
          : operationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      operationType: null == operationType
          ? _value.operationType
          : operationType // ignore: cast_nullable_to_non_nullable
              as String,
      operationDate: null == operationDate
          ? _value.operationDate
          : operationDate // ignore: cast_nullable_to_non_nullable
              as String,
      operationAmount: null == operationAmount
          ? _value.operationAmount
          : operationAmount // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OperationCopyWith<$Res> implements $OperationCopyWith<$Res> {
  factory _$$_OperationCopyWith(
          _$_Operation value, $Res Function(_$_Operation) then) =
      __$$_OperationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int operationID,
      String operationName,
      String operationDescription,
      String operationType,
      String operationDate,
      String operationAmount,
      User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_OperationCopyWithImpl<$Res>
    extends _$OperationCopyWithImpl<$Res, _$_Operation>
    implements _$$_OperationCopyWith<$Res> {
  __$$_OperationCopyWithImpl(
      _$_Operation _value, $Res Function(_$_Operation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operationID = null,
    Object? operationName = null,
    Object? operationDescription = null,
    Object? operationType = null,
    Object? operationDate = null,
    Object? operationAmount = null,
    Object? user = freezed,
  }) {
    return _then(_$_Operation(
      operationID: null == operationID
          ? _value.operationID
          : operationID // ignore: cast_nullable_to_non_nullable
              as int,
      operationName: null == operationName
          ? _value.operationName
          : operationName // ignore: cast_nullable_to_non_nullable
              as String,
      operationDescription: null == operationDescription
          ? _value.operationDescription
          : operationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      operationType: null == operationType
          ? _value.operationType
          : operationType // ignore: cast_nullable_to_non_nullable
              as String,
      operationDate: null == operationDate
          ? _value.operationDate
          : operationDate // ignore: cast_nullable_to_non_nullable
              as String,
      operationAmount: null == operationAmount
          ? _value.operationAmount
          : operationAmount // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_Operation implements _Operation {
  const _$_Operation(
      {required this.operationID,
      required this.operationName,
      required this.operationDescription,
      required this.operationType,
      required this.operationDate,
      required this.operationAmount,
      this.user});

  @override
  final int operationID;
  @override
  final String operationName;
  @override
  final String operationDescription;
  @override
  final String operationType;
  @override
  final String operationDate;
  @override
  final String operationAmount;
  @override
  final User? user;

  @override
  String toString() {
    return 'Operation(operationID: $operationID, operationName: $operationName, operationDescription: $operationDescription, operationType: $operationType, operationDate: $operationDate, operationAmount: $operationAmount, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Operation &&
            (identical(other.operationID, operationID) ||
                other.operationID == operationID) &&
            (identical(other.operationName, operationName) ||
                other.operationName == operationName) &&
            (identical(other.operationDescription, operationDescription) ||
                other.operationDescription == operationDescription) &&
            (identical(other.operationType, operationType) ||
                other.operationType == operationType) &&
            (identical(other.operationDate, operationDate) ||
                other.operationDate == operationDate) &&
            (identical(other.operationAmount, operationAmount) ||
                other.operationAmount == operationAmount) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      operationID,
      operationName,
      operationDescription,
      operationType,
      operationDate,
      operationAmount,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OperationCopyWith<_$_Operation> get copyWith =>
      __$$_OperationCopyWithImpl<_$_Operation>(this, _$identity);
      
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'operationName': operationName,
      'operationDescription': operationDescription,
      'operationType': operationType,
      'operationDate': operationDate,
      'operationAmount': operationAmount,
    };
  }
}

abstract class _Operation implements Operation {
  const factory _Operation(
      {required final int operationID,
      required final String operationName,
      required final String operationDescription,
      required final String operationType,
      required final String operationDate,
      required final String operationAmount,
      final User? user}) = _$_Operation;

  @override
  int get operationID;
  @override
  String get operationName;
  @override
  String get operationDescription;
  @override
  String get operationType;
  @override
  String get operationDate;
  @override
  String get operationAmount;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$_OperationCopyWith<_$_Operation> get copyWith =>
      throw _privateConstructorUsedError;
}
