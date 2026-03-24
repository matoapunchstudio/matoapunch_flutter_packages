// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pb_error_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PbErrorMessage {

 String get key; String get code; String get message;
/// Create a copy of PbErrorMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PbErrorMessageCopyWith<PbErrorMessage> get copyWith => _$PbErrorMessageCopyWithImpl<PbErrorMessage>(this as PbErrorMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PbErrorMessage&&(identical(other.key, key) || other.key == key)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,key,code,message);

@override
String toString() {
  return 'PbErrorMessage(key: $key, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $PbErrorMessageCopyWith<$Res>  {
  factory $PbErrorMessageCopyWith(PbErrorMessage value, $Res Function(PbErrorMessage) _then) = _$PbErrorMessageCopyWithImpl;
@useResult
$Res call({
 String key, String code, String message
});




}
/// @nodoc
class _$PbErrorMessageCopyWithImpl<$Res>
    implements $PbErrorMessageCopyWith<$Res> {
  _$PbErrorMessageCopyWithImpl(this._self, this._then);

  final PbErrorMessage _self;
  final $Res Function(PbErrorMessage) _then;

/// Create a copy of PbErrorMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PbErrorMessage].
extension PbErrorMessagePatterns on PbErrorMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PbErrorMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PbErrorMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PbErrorMessage value)  $default,){
final _that = this;
switch (_that) {
case _PbErrorMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PbErrorMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PbErrorMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PbErrorMessage() when $default != null:
return $default(_that.key,_that.code,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _PbErrorMessage():
return $default(_that.key,_that.code,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _PbErrorMessage() when $default != null:
return $default(_that.key,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PbErrorMessage extends PbErrorMessage {
  const _PbErrorMessage({required this.key, required this.code, required this.message}): super._();
  

@override final  String key;
@override final  String code;
@override final  String message;

/// Create a copy of PbErrorMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PbErrorMessageCopyWith<_PbErrorMessage> get copyWith => __$PbErrorMessageCopyWithImpl<_PbErrorMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PbErrorMessage&&(identical(other.key, key) || other.key == key)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,key,code,message);

@override
String toString() {
  return 'PbErrorMessage(key: $key, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PbErrorMessageCopyWith<$Res> implements $PbErrorMessageCopyWith<$Res> {
  factory _$PbErrorMessageCopyWith(_PbErrorMessage value, $Res Function(_PbErrorMessage) _then) = __$PbErrorMessageCopyWithImpl;
@override @useResult
$Res call({
 String key, String code, String message
});




}
/// @nodoc
class __$PbErrorMessageCopyWithImpl<$Res>
    implements _$PbErrorMessageCopyWith<$Res> {
  __$PbErrorMessageCopyWithImpl(this._self, this._then);

  final _PbErrorMessage _self;
  final $Res Function(_PbErrorMessage) _then;

/// Create a copy of PbErrorMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? code = null,Object? message = null,}) {
  return _then(_PbErrorMessage(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
