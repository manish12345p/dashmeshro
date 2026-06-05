// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHomeData,
    required TResult Function(String filter) filterComplaints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadHomeData,
    TResult? Function(String filter)? filterComplaints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHomeData,
    TResult Function(String filter)? filterComplaints,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHomeData value) loadHomeData,
    required TResult Function(FilterComplaints value) filterComplaints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadHomeData value)? loadHomeData,
    TResult? Function(FilterComplaints value)? filterComplaints,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHomeData value)? loadHomeData,
    TResult Function(FilterComplaints value)? filterComplaints,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadHomeDataImplCopyWith<$Res> {
  factory _$$LoadHomeDataImplCopyWith(
    _$LoadHomeDataImpl value,
    $Res Function(_$LoadHomeDataImpl) then,
  ) = __$$LoadHomeDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadHomeDataImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadHomeDataImpl>
    implements _$$LoadHomeDataImplCopyWith<$Res> {
  __$$LoadHomeDataImplCopyWithImpl(
    _$LoadHomeDataImpl _value,
    $Res Function(_$LoadHomeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadHomeDataImpl implements LoadHomeData {
  const _$LoadHomeDataImpl();

  @override
  String toString() {
    return 'HomeEvent.loadHomeData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadHomeDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHomeData,
    required TResult Function(String filter) filterComplaints,
  }) {
    return loadHomeData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadHomeData,
    TResult? Function(String filter)? filterComplaints,
  }) {
    return loadHomeData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHomeData,
    TResult Function(String filter)? filterComplaints,
    required TResult orElse(),
  }) {
    if (loadHomeData != null) {
      return loadHomeData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHomeData value) loadHomeData,
    required TResult Function(FilterComplaints value) filterComplaints,
  }) {
    return loadHomeData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadHomeData value)? loadHomeData,
    TResult? Function(FilterComplaints value)? filterComplaints,
  }) {
    return loadHomeData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHomeData value)? loadHomeData,
    TResult Function(FilterComplaints value)? filterComplaints,
    required TResult orElse(),
  }) {
    if (loadHomeData != null) {
      return loadHomeData(this);
    }
    return orElse();
  }
}

abstract class LoadHomeData implements HomeEvent {
  const factory LoadHomeData() = _$LoadHomeDataImpl;
}

/// @nodoc
abstract class _$$FilterComplaintsImplCopyWith<$Res> {
  factory _$$FilterComplaintsImplCopyWith(
    _$FilterComplaintsImpl value,
    $Res Function(_$FilterComplaintsImpl) then,
  ) = __$$FilterComplaintsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String filter});
}

/// @nodoc
class __$$FilterComplaintsImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$FilterComplaintsImpl>
    implements _$$FilterComplaintsImplCopyWith<$Res> {
  __$$FilterComplaintsImplCopyWithImpl(
    _$FilterComplaintsImpl _value,
    $Res Function(_$FilterComplaintsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filter = null}) {
    return _then(
      _$FilterComplaintsImpl(
        null == filter
            ? _value.filter
            : filter // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FilterComplaintsImpl implements FilterComplaints {
  const _$FilterComplaintsImpl(this.filter);

  @override
  final String filter;

  @override
  String toString() {
    return 'HomeEvent.filterComplaints(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterComplaintsImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterComplaintsImplCopyWith<_$FilterComplaintsImpl> get copyWith =>
      __$$FilterComplaintsImplCopyWithImpl<_$FilterComplaintsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadHomeData,
    required TResult Function(String filter) filterComplaints,
  }) {
    return filterComplaints(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadHomeData,
    TResult? Function(String filter)? filterComplaints,
  }) {
    return filterComplaints?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadHomeData,
    TResult Function(String filter)? filterComplaints,
    required TResult orElse(),
  }) {
    if (filterComplaints != null) {
      return filterComplaints(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadHomeData value) loadHomeData,
    required TResult Function(FilterComplaints value) filterComplaints,
  }) {
    return filterComplaints(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadHomeData value)? loadHomeData,
    TResult? Function(FilterComplaints value)? filterComplaints,
  }) {
    return filterComplaints?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadHomeData value)? loadHomeData,
    TResult Function(FilterComplaints value)? filterComplaints,
    required TResult orElse(),
  }) {
    if (filterComplaints != null) {
      return filterComplaints(this);
    }
    return orElse();
  }
}

abstract class FilterComplaints implements HomeEvent {
  const factory FilterComplaints(final String filter) = _$FilterComplaintsImpl;

  String get filter;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterComplaintsImplCopyWith<_$FilterComplaintsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
