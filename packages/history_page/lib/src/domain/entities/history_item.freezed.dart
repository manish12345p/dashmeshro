// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) {
  return _HistoryItem.fromJson(json);
}

/// @nodoc
mixin _$HistoryItem {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get customerAddress => throw _privateConstructorUsedError;
  String get customerPhone => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  DateTime get serviceDate => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get serviceDuration => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get amountPaid => throw _privateConstructorUsedError;
  double get amountPending => throw _privateConstructorUsedError;
  bool get isComplaint => throw _privateConstructorUsedError;

  /// Serializes this HistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryItemCopyWith<HistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemCopyWith<$Res> {
  factory $HistoryItemCopyWith(
    HistoryItem value,
    $Res Function(HistoryItem) then,
  ) = _$HistoryItemCopyWithImpl<$Res, HistoryItem>;
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String customerAddress,
    String customerPhone,
    String serviceType,
    DateTime serviceDate,
    String note,
    String status,
    String serviceDuration,
    double totalAmount,
    double amountPaid,
    double amountPending,
    bool isComplaint,
  });
}

/// @nodoc
class _$HistoryItemCopyWithImpl<$Res, $Val extends HistoryItem>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerAddress = null,
    Object? customerPhone = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? note = null,
    Object? status = null,
    Object? serviceDuration = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? amountPending = null,
    Object? isComplaint = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerAddress: null == customerAddress
                ? _value.customerAddress
                : customerAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            customerPhone: null == customerPhone
                ? _value.customerPhone
                : customerPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDate: null == serviceDate
                ? _value.serviceDate
                : serviceDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDuration: null == serviceDuration
                ? _value.serviceDuration
                : serviceDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            amountPaid: null == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as double,
            amountPending: null == amountPending
                ? _value.amountPending
                : amountPending // ignore: cast_nullable_to_non_nullable
                      as double,
            isComplaint: null == isComplaint
                ? _value.isComplaint
                : isComplaint // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$HistoryItemImplCopyWith(
    _$HistoryItemImpl value,
    $Res Function(_$HistoryItemImpl) then,
  ) = __$$HistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String customerAddress,
    String customerPhone,
    String serviceType,
    DateTime serviceDate,
    String note,
    String status,
    String serviceDuration,
    double totalAmount,
    double amountPaid,
    double amountPending,
    bool isComplaint,
  });
}

/// @nodoc
class __$$HistoryItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$HistoryItemImpl>
    implements _$$HistoryItemImplCopyWith<$Res> {
  __$$HistoryItemImplCopyWithImpl(
    _$HistoryItemImpl _value,
    $Res Function(_$HistoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerAddress = null,
    Object? customerPhone = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? note = null,
    Object? status = null,
    Object? serviceDuration = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? amountPending = null,
    Object? isComplaint = null,
  }) {
    return _then(
      _$HistoryItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerAddress: null == customerAddress
            ? _value.customerAddress
            : customerAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        customerPhone: null == customerPhone
            ? _value.customerPhone
            : customerPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDate: null == serviceDate
            ? _value.serviceDate
            : serviceDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDuration: null == serviceDuration
            ? _value.serviceDuration
            : serviceDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        amountPaid: null == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as double,
        amountPending: null == amountPending
            ? _value.amountPending
            : amountPending // ignore: cast_nullable_to_non_nullable
                  as double,
        isComplaint: null == isComplaint
            ? _value.isComplaint
            : isComplaint // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$HistoryItemImpl implements _HistoryItem {
  const _$HistoryItemImpl({
    required this.id,
    required this.customerId,
    this.customerName = '',
    this.customerAddress = '',
    this.customerPhone = '',
    this.serviceType = '',
    required this.serviceDate,
    this.note = '',
    this.status = 'pending',
    this.serviceDuration = '',
    this.totalAmount = 0.0,
    this.amountPaid = 0.0,
    this.amountPending = 0.0,
    this.isComplaint = false,
  });

  factory _$HistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryItemImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String customerAddress;
  @override
  @JsonKey()
  final String customerPhone;
  @override
  @JsonKey()
  final String serviceType;
  @override
  final DateTime serviceDate;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String serviceDuration;
  @override
  @JsonKey()
  final double totalAmount;
  @override
  @JsonKey()
  final double amountPaid;
  @override
  @JsonKey()
  final double amountPending;
  @override
  @JsonKey()
  final bool isComplaint;

  @override
  String toString() {
    return 'HistoryItem(id: $id, customerId: $customerId, customerName: $customerName, customerAddress: $customerAddress, customerPhone: $customerPhone, serviceType: $serviceType, serviceDate: $serviceDate, note: $note, status: $status, serviceDuration: $serviceDuration, totalAmount: $totalAmount, amountPaid: $amountPaid, amountPending: $amountPending, isComplaint: $isComplaint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerAddress, customerAddress) ||
                other.customerAddress == customerAddress) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.serviceDate, serviceDate) ||
                other.serviceDate == serviceDate) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.serviceDuration, serviceDuration) ||
                other.serviceDuration == serviceDuration) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.amountPending, amountPending) ||
                other.amountPending == amountPending) &&
            (identical(other.isComplaint, isComplaint) ||
                other.isComplaint == isComplaint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customerId,
    customerName,
    customerAddress,
    customerPhone,
    serviceType,
    serviceDate,
    note,
    status,
    serviceDuration,
    totalAmount,
    amountPaid,
    amountPending,
    isComplaint,
  );

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      __$$HistoryItemImplCopyWithImpl<_$HistoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryItemImplToJson(this);
  }
}

abstract class _HistoryItem implements HistoryItem {
  const factory _HistoryItem({
    required final String id,
    required final String customerId,
    final String customerName,
    final String customerAddress,
    final String customerPhone,
    final String serviceType,
    required final DateTime serviceDate,
    final String note,
    final String status,
    final String serviceDuration,
    final double totalAmount,
    final double amountPaid,
    final double amountPending,
    final bool isComplaint,
  }) = _$HistoryItemImpl;

  factory _HistoryItem.fromJson(Map<String, dynamic> json) =
      _$HistoryItemImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String get customerAddress;
  @override
  String get customerPhone;
  @override
  String get serviceType;
  @override
  DateTime get serviceDate;
  @override
  String get note;
  @override
  String get status;
  @override
  String get serviceDuration;
  @override
  double get totalAmount;
  @override
  double get amountPaid;
  @override
  double get amountPending;
  @override
  bool get isComplaint;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
