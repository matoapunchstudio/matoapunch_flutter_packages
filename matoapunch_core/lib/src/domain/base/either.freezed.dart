// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'either.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Either<L,R> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Either<L, R>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Either<$L, $R>()';
}


}

/// @nodoc
class $EitherCopyWith<L,R,$Res>  {
$EitherCopyWith(Either<L, R> _, $Res Function(Either<L, R>) __);
}


/// Adds pattern-matching-related methods to [Either].
extension EitherPatterns<L,R> on Either<L, R> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EitherLeft<L, R> value)?  left,TResult Function( _EitherRight<L, R> value)?  right,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EitherLeft() when left != null:
return left(_that);case _EitherRight() when right != null:
return right(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EitherLeft<L, R> value)  left,required TResult Function( _EitherRight<L, R> value)  right,}){
final _that = this;
switch (_that) {
case _EitherLeft():
return left(_that);case _EitherRight():
return right(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EitherLeft<L, R> value)?  left,TResult? Function( _EitherRight<L, R> value)?  right,}){
final _that = this;
switch (_that) {
case _EitherLeft() when left != null:
return left(_that);case _EitherRight() when right != null:
return right(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( L left)?  left,TResult Function( R right)?  right,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EitherLeft() when left != null:
return left(_that.left);case _EitherRight() when right != null:
return right(_that.right);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( L left)  left,required TResult Function( R right)  right,}) {final _that = this;
switch (_that) {
case _EitherLeft():
return left(_that.left);case _EitherRight():
return right(_that.right);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( L left)?  left,TResult? Function( R right)?  right,}) {final _that = this;
switch (_that) {
case _EitherLeft() when left != null:
return left(_that.left);case _EitherRight() when right != null:
return right(_that.right);case _:
  return null;

}
}

}

/// @nodoc


class _EitherLeft<L,R> extends Either<L, R> {
  const _EitherLeft(this.left): super._();
  

 final  L left;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EitherLeftCopyWith<L, R, _EitherLeft<L, R>> get copyWith => __$EitherLeftCopyWithImpl<L, R, _EitherLeft<L, R>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EitherLeft<L, R>&&const DeepCollectionEquality().equals(other.left, left));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(left));

@override
String toString() {
  return 'Either<$L, $R>.left(left: $left)';
}


}

/// @nodoc
abstract mixin class _$EitherLeftCopyWith<L,R,$Res> implements $EitherCopyWith<L, R, $Res> {
  factory _$EitherLeftCopyWith(_EitherLeft<L, R> value, $Res Function(_EitherLeft<L, R>) _then) = __$EitherLeftCopyWithImpl;
@useResult
$Res call({
 L left
});




}
/// @nodoc
class __$EitherLeftCopyWithImpl<L,R,$Res>
    implements _$EitherLeftCopyWith<L, R, $Res> {
  __$EitherLeftCopyWithImpl(this._self, this._then);

  final _EitherLeft<L, R> _self;
  final $Res Function(_EitherLeft<L, R>) _then;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? left = freezed,}) {
  return _then(_EitherLeft<L, R>(
freezed == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as L,
  ));
}


}

/// @nodoc


class _EitherRight<L,R> extends Either<L, R> {
  const _EitherRight(this.right): super._();
  

 final  R right;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EitherRightCopyWith<L, R, _EitherRight<L, R>> get copyWith => __$EitherRightCopyWithImpl<L, R, _EitherRight<L, R>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EitherRight<L, R>&&const DeepCollectionEquality().equals(other.right, right));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(right));

@override
String toString() {
  return 'Either<$L, $R>.right(right: $right)';
}


}

/// @nodoc
abstract mixin class _$EitherRightCopyWith<L,R,$Res> implements $EitherCopyWith<L, R, $Res> {
  factory _$EitherRightCopyWith(_EitherRight<L, R> value, $Res Function(_EitherRight<L, R>) _then) = __$EitherRightCopyWithImpl;
@useResult
$Res call({
 R right
});




}
/// @nodoc
class __$EitherRightCopyWithImpl<L,R,$Res>
    implements _$EitherRightCopyWith<L, R, $Res> {
  __$EitherRightCopyWithImpl(this._self, this._then);

  final _EitherRight<L, R> _self;
  final $Res Function(_EitherRight<L, R>) _then;

/// Create a copy of Either
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? right = freezed,}) {
  return _then(_EitherRight<L, R>(
freezed == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as R,
  ));
}


}

// dart format on
