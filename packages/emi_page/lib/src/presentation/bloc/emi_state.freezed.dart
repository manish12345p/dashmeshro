// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emi_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EmiState {
  EmiStatus get status => throw _privateConstructorUsedError;
  EmiDashboardData? get data => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String get selectedFilter => throw _privateConstructorUsedError;

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmiStateCopyWith<EmiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmiStateCopyWith<$Res> {
  factory $EmiStateCopyWith(EmiState value, $Res Function(EmiState) then) =
      _$EmiStateCopyWithImpl<$Res, EmiState>;
  @useResult
  $Res call({
    EmiStatus status,
    EmiDashboardData? data,
    String? errorMessage,
    String selectedFilter,
  });

  $EmiDashboardDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$EmiStateCopyWithImpl<$Res, $Val extends EmiState>
    implements $EmiStateCopyWith<$Res> {
  _$EmiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
    Object? errorMessage = freezed,
    Object? selectedFilter = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as EmiStatus,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as EmiDashboardData?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedFilter: null == selectedFilter
                ? _value.selectedFilter
                : selectedFilter // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmiDashboardDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $EmiDashboardDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmiStateImplCopyWith<$Res>
    implements $EmiStateCopyWith<$Res> {
  factory _$$EmiStateImplCopyWith(
    _$EmiStateImpl value,
    $Res Function(_$EmiStateImpl) then,
  ) = __$$EmiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EmiStatus status,
    EmiDashboardData? data,
    String? errorMessage,
    String selectedFilter,
  });

  @override
  $EmiDashboardDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$EmiStateImplCopyWithImpl<$Res>
    extends _$EmiStateCopyWithImpl<$Res, _$EmiStateImpl>
    implements _$$EmiStateImplCopyWith<$Res> {
  __$$EmiStateImplCopyWithImpl(
    _$EmiStateImpl _value,
    $Res Function(_$EmiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
    Object? errorMessage = freezed,
    Object? selectedFilter = null,
  }) {
    return _then(
      _$EmiStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as EmiStatus,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as EmiDashboardData?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedFilter: null == selectedFilter
            ? _value.selectedFilter
            : selectedFilter // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EmiStateImpl implements _EmiState {
  const _$EmiStateImpl({
    this.status = EmiStatus.initial,
    this.data,
    this.errorMessage,
    this.selectedFilter = 'All',
  });

  @override
  @JsonKey()
  final EmiStatus status;
  @override
  final EmiDashboardData? data;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final String selectedFilter;

  @override
  String toString() {
    return 'EmiState(status: $status, data: $data, errorMessage: $errorMessage, selectedFilter: $selectedFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmiStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, data, errorMessage, selectedFilter);

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmiStateImplCopyWith<_$EmiStateImpl> get copyWith =>
      __$$EmiStateImplCopyWithImpl<_$EmiStateImpl>(this, _$identity);
}

abstract class _EmiState implements EmiState {
  const factory _EmiState({
    final EmiStatus status,
    final EmiDashboardData? data,
    final String? errorMessage,
    final String selectedFilter,
  }) = _$EmiStateImpl;

  @override
  EmiStatus get status;
  @override
  EmiDashboardData? get data;
  @override
  String? get errorMessage;
  @override
  String get selectedFilter;

  /// Create a copy of EmiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmiStateImplCopyWith<_$EmiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
