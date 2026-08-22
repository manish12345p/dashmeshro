// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpiryItem _$ExpiryItemFromJson(Map<String, dynamic> json) {
  return _ExpiryItem.fromJson(json);
}

/// @nodoc
mixin _$ExpiryItem {
  String get customerName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'Service' or 'Guarantee'
  String get expiryDate => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get daysLeft => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;

  /// Serializes this ExpiryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpiryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpiryItemCopyWith<ExpiryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpiryItemCopyWith<$Res> {
  factory $ExpiryItemCopyWith(
    ExpiryItem value,
    $Res Function(ExpiryItem) then,
  ) = _$ExpiryItemCopyWithImpl<$Res, ExpiryItem>;
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String type,
    String expiryDate,
    String phone,
    int daysLeft,
    String serviceType,
    String duration,
  });
}

/// @nodoc
class _$ExpiryItemCopyWithImpl<$Res, $Val extends ExpiryItem>
    implements $ExpiryItemCopyWith<$Res> {
  _$ExpiryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpiryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? type = null,
    Object? expiryDate = null,
    Object? phone = null,
    Object? daysLeft = null,
    Object? serviceType = null,
    Object? duration = null,
  }) {
    return _then(
      _value.copyWith(
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            expiryDate: null == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            daysLeft: null == daysLeft
                ? _value.daysLeft
                : daysLeft // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpiryItemImplCopyWith<$Res>
    implements $ExpiryItemCopyWith<$Res> {
  factory _$$ExpiryItemImplCopyWith(
    _$ExpiryItemImpl value,
    $Res Function(_$ExpiryItemImpl) then,
  ) = __$$ExpiryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String type,
    String expiryDate,
    String phone,
    int daysLeft,
    String serviceType,
    String duration,
  });
}

/// @nodoc
class __$$ExpiryItemImplCopyWithImpl<$Res>
    extends _$ExpiryItemCopyWithImpl<$Res, _$ExpiryItemImpl>
    implements _$$ExpiryItemImplCopyWith<$Res> {
  __$$ExpiryItemImplCopyWithImpl(
    _$ExpiryItemImpl _value,
    $Res Function(_$ExpiryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpiryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? type = null,
    Object? expiryDate = null,
    Object? phone = null,
    Object? daysLeft = null,
    Object? serviceType = null,
    Object? duration = null,
  }) {
    return _then(
      _$ExpiryItemImpl(
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        expiryDate: null == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        daysLeft: null == daysLeft
            ? _value.daysLeft
            : daysLeft // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpiryItemImpl extends _ExpiryItem {
  const _$ExpiryItemImpl({
    this.customerName = '',
    this.customerId = '',
    this.type = '',
    this.expiryDate = '',
    this.phone = '',
    this.daysLeft = 0,
    this.serviceType = '',
    this.duration = '',
  }) : super._();

  factory _$ExpiryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpiryItemImplFromJson(json);

  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String customerId;
  @override
  @JsonKey()
  final String type;
  // 'Service' or 'Guarantee'
  @override
  @JsonKey()
  final String expiryDate;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final int daysLeft;
  @override
  @JsonKey()
  final String serviceType;
  @override
  @JsonKey()
  final String duration;

  @override
  String toString() {
    return 'ExpiryItem(customerName: $customerName, customerId: $customerId, type: $type, expiryDate: $expiryDate, phone: $phone, daysLeft: $daysLeft, serviceType: $serviceType, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpiryItemImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.daysLeft, daysLeft) ||
                other.daysLeft == daysLeft) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerName,
    customerId,
    type,
    expiryDate,
    phone,
    daysLeft,
    serviceType,
    duration,
  );

  /// Create a copy of ExpiryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpiryItemImplCopyWith<_$ExpiryItemImpl> get copyWith =>
      __$$ExpiryItemImplCopyWithImpl<_$ExpiryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpiryItemImplToJson(this);
  }
}

abstract class _ExpiryItem extends ExpiryItem {
  const factory _ExpiryItem({
    final String customerName,
    final String customerId,
    final String type,
    final String expiryDate,
    final String phone,
    final int daysLeft,
    final String serviceType,
    final String duration,
  }) = _$ExpiryItemImpl;
  const _ExpiryItem._() : super._();

  factory _ExpiryItem.fromJson(Map<String, dynamic> json) =
      _$ExpiryItemImpl.fromJson;

  @override
  String get customerName;
  @override
  String get customerId;
  @override
  String get type; // 'Service' or 'Guarantee'
  @override
  String get expiryDate;
  @override
  String get phone;
  @override
  int get daysLeft;
  @override
  String get serviceType;
  @override
  String get duration;

  /// Create a copy of ExpiryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpiryItemImplCopyWith<_$ExpiryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingPaymentItem _$PendingPaymentItemFromJson(Map<String, dynamic> json) {
  return _PendingPaymentItem.fromJson(json);
}

/// @nodoc
mixin _$PendingPaymentItem {
  String get customerName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  double get amountPending => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get daysOverdue => throw _privateConstructorUsedError;
  String get dueDate => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this PendingPaymentItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingPaymentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingPaymentItemCopyWith<PendingPaymentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingPaymentItemCopyWith<$Res> {
  factory $PendingPaymentItemCopyWith(
    PendingPaymentItem value,
    $Res Function(PendingPaymentItem) then,
  ) = _$PendingPaymentItemCopyWithImpl<$Res, PendingPaymentItem>;
  @useResult
  $Res call({
    String customerName,
    String customerId,
    double amountPending,
    String phone,
    int daysOverdue,
    String dueDate,
    String type,
  });
}

/// @nodoc
class _$PendingPaymentItemCopyWithImpl<$Res, $Val extends PendingPaymentItem>
    implements $PendingPaymentItemCopyWith<$Res> {
  _$PendingPaymentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingPaymentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? amountPending = null,
    Object? phone = null,
    Object? daysOverdue = null,
    Object? dueDate = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            amountPending: null == amountPending
                ? _value.amountPending
                : amountPending // ignore: cast_nullable_to_non_nullable
                      as double,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            daysOverdue: null == daysOverdue
                ? _value.daysOverdue
                : daysOverdue // ignore: cast_nullable_to_non_nullable
                      as int,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PendingPaymentItemImplCopyWith<$Res>
    implements $PendingPaymentItemCopyWith<$Res> {
  factory _$$PendingPaymentItemImplCopyWith(
    _$PendingPaymentItemImpl value,
    $Res Function(_$PendingPaymentItemImpl) then,
  ) = __$$PendingPaymentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerName,
    String customerId,
    double amountPending,
    String phone,
    int daysOverdue,
    String dueDate,
    String type,
  });
}

/// @nodoc
class __$$PendingPaymentItemImplCopyWithImpl<$Res>
    extends _$PendingPaymentItemCopyWithImpl<$Res, _$PendingPaymentItemImpl>
    implements _$$PendingPaymentItemImplCopyWith<$Res> {
  __$$PendingPaymentItemImplCopyWithImpl(
    _$PendingPaymentItemImpl _value,
    $Res Function(_$PendingPaymentItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingPaymentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? amountPending = null,
    Object? phone = null,
    Object? daysOverdue = null,
    Object? dueDate = null,
    Object? type = null,
  }) {
    return _then(
      _$PendingPaymentItemImpl(
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        amountPending: null == amountPending
            ? _value.amountPending
            : amountPending // ignore: cast_nullable_to_non_nullable
                  as double,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        daysOverdue: null == daysOverdue
            ? _value.daysOverdue
            : daysOverdue // ignore: cast_nullable_to_non_nullable
                  as int,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingPaymentItemImpl extends _PendingPaymentItem {
  const _$PendingPaymentItemImpl({
    this.customerName = '',
    this.customerId = '',
    this.amountPending = 0.0,
    this.phone = '',
    this.daysOverdue = 0,
    this.dueDate = '',
    this.type = '',
  }) : super._();

  factory _$PendingPaymentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingPaymentItemImplFromJson(json);

  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String customerId;
  @override
  @JsonKey()
  final double amountPending;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final int daysOverdue;
  @override
  @JsonKey()
  final String dueDate;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'PendingPaymentItem(customerName: $customerName, customerId: $customerId, amountPending: $amountPending, phone: $phone, daysOverdue: $daysOverdue, dueDate: $dueDate, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingPaymentItemImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.amountPending, amountPending) ||
                other.amountPending == amountPending) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.daysOverdue, daysOverdue) ||
                other.daysOverdue == daysOverdue) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerName,
    customerId,
    amountPending,
    phone,
    daysOverdue,
    dueDate,
    type,
  );

  /// Create a copy of PendingPaymentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingPaymentItemImplCopyWith<_$PendingPaymentItemImpl> get copyWith =>
      __$$PendingPaymentItemImplCopyWithImpl<_$PendingPaymentItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingPaymentItemImplToJson(this);
  }
}

abstract class _PendingPaymentItem extends PendingPaymentItem {
  const factory _PendingPaymentItem({
    final String customerName,
    final String customerId,
    final double amountPending,
    final String phone,
    final int daysOverdue,
    final String dueDate,
    final String type,
  }) = _$PendingPaymentItemImpl;
  const _PendingPaymentItem._() : super._();

  factory _PendingPaymentItem.fromJson(Map<String, dynamic> json) =
      _$PendingPaymentItemImpl.fromJson;

  @override
  String get customerName;
  @override
  String get customerId;
  @override
  double get amountPending;
  @override
  String get phone;
  @override
  int get daysOverdue;
  @override
  String get dueDate;
  @override
  String get type;

  /// Create a copy of PendingPaymentItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingPaymentItemImplCopyWith<_$PendingPaymentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleItem _$ScheduleItemFromJson(Map<String, dynamic> json) {
  return _ScheduleItem.fromJson(json);
}

/// @nodoc
mixin _$ScheduleItem {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;

  /// Serializes this ScheduleItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleItemCopyWith<ScheduleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleItemCopyWith<$Res> {
  factory $ScheduleItemCopyWith(
    ScheduleItem value,
    $Res Function(ScheduleItem) then,
  ) = _$ScheduleItemCopyWithImpl<$Res, ScheduleItem>;
  @useResult
  $Res call({
    String title,
    String subtitle,
    String time,
    bool isUrgent,
    String phone,
    String customerId,
  });
}

/// @nodoc
class _$ScheduleItemCopyWithImpl<$Res, $Val extends ScheduleItem>
    implements $ScheduleItemCopyWith<$Res> {
  _$ScheduleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? time = null,
    Object? isUrgent = null,
    Object? phone = null,
    Object? customerId = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleItemImplCopyWith<$Res>
    implements $ScheduleItemCopyWith<$Res> {
  factory _$$ScheduleItemImplCopyWith(
    _$ScheduleItemImpl value,
    $Res Function(_$ScheduleItemImpl) then,
  ) = __$$ScheduleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String subtitle,
    String time,
    bool isUrgent,
    String phone,
    String customerId,
  });
}

/// @nodoc
class __$$ScheduleItemImplCopyWithImpl<$Res>
    extends _$ScheduleItemCopyWithImpl<$Res, _$ScheduleItemImpl>
    implements _$$ScheduleItemImplCopyWith<$Res> {
  __$$ScheduleItemImplCopyWithImpl(
    _$ScheduleItemImpl _value,
    $Res Function(_$ScheduleItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? time = null,
    Object? isUrgent = null,
    Object? phone = null,
    Object? customerId = null,
  }) {
    return _then(
      _$ScheduleItemImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleItemImpl extends _ScheduleItem {
  const _$ScheduleItemImpl({
    this.title = '',
    this.subtitle = '',
    this.time = '',
    this.isUrgent = false,
    this.phone = '',
    this.customerId = '',
  }) : super._();

  factory _$ScheduleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleItemImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final String time;
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String customerId;

  @override
  String toString() {
    return 'ScheduleItem(title: $title, subtitle: $subtitle, time: $time, isUrgent: $isUrgent, phone: $phone, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    subtitle,
    time,
    isUrgent,
    phone,
    customerId,
  );

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      __$$ScheduleItemImplCopyWithImpl<_$ScheduleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleItemImplToJson(this);
  }
}

abstract class _ScheduleItem extends ScheduleItem {
  const factory _ScheduleItem({
    final String title,
    final String subtitle,
    final String time,
    final bool isUrgent,
    final String phone,
    final String customerId,
  }) = _$ScheduleItemImpl;
  const _ScheduleItem._() : super._();

  factory _ScheduleItem.fromJson(Map<String, dynamic> json) =
      _$ScheduleItemImpl.fromJson;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get time;
  @override
  bool get isUrgent;
  @override
  String get phone;
  @override
  String get customerId;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplaintItem _$ComplaintItemFromJson(Map<String, dynamic> json) {
  return _ComplaintItem.fromJson(json);
}

/// @nodoc
mixin _$ComplaintItem {
  String get customerName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get issueType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this ComplaintItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComplaintItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComplaintItemCopyWith<ComplaintItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintItemCopyWith<$Res> {
  factory $ComplaintItemCopyWith(
    ComplaintItem value,
    $Res Function(ComplaintItem) then,
  ) = _$ComplaintItemCopyWithImpl<$Res, ComplaintItem>;
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String issueType,
    String status,
  });
}

/// @nodoc
class _$ComplaintItemCopyWithImpl<$Res, $Val extends ComplaintItem>
    implements $ComplaintItemCopyWith<$Res> {
  _$ComplaintItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComplaintItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? issueType = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            issueType: null == issueType
                ? _value.issueType
                : issueType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComplaintItemImplCopyWith<$Res>
    implements $ComplaintItemCopyWith<$Res> {
  factory _$$ComplaintItemImplCopyWith(
    _$ComplaintItemImpl value,
    $Res Function(_$ComplaintItemImpl) then,
  ) = __$$ComplaintItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String issueType,
    String status,
  });
}

/// @nodoc
class __$$ComplaintItemImplCopyWithImpl<$Res>
    extends _$ComplaintItemCopyWithImpl<$Res, _$ComplaintItemImpl>
    implements _$$ComplaintItemImplCopyWith<$Res> {
  __$$ComplaintItemImplCopyWithImpl(
    _$ComplaintItemImpl _value,
    $Res Function(_$ComplaintItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? issueType = null,
    Object? status = null,
  }) {
    return _then(
      _$ComplaintItemImpl(
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        issueType: null == issueType
            ? _value.issueType
            : issueType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplaintItemImpl extends _ComplaintItem {
  const _$ComplaintItemImpl({
    this.customerName = '',
    this.customerId = '',
    this.issueType = '',
    this.status = '',
  }) : super._();

  factory _$ComplaintItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintItemImplFromJson(json);

  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String customerId;
  @override
  @JsonKey()
  final String issueType;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'ComplaintItem(customerName: $customerName, customerId: $customerId, issueType: $issueType, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintItemImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.issueType, issueType) ||
                other.issueType == issueType) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, customerName, customerId, issueType, status);

  /// Create a copy of ComplaintItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintItemImplCopyWith<_$ComplaintItemImpl> get copyWith =>
      __$$ComplaintItemImplCopyWithImpl<_$ComplaintItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintItemImplToJson(this);
  }
}

abstract class _ComplaintItem extends ComplaintItem {
  const factory _ComplaintItem({
    final String customerName,
    final String customerId,
    final String issueType,
    final String status,
  }) = _$ComplaintItemImpl;
  const _ComplaintItem._() : super._();

  factory _ComplaintItem.fromJson(Map<String, dynamic> json) =
      _$ComplaintItemImpl.fromJson;

  @override
  String get customerName;
  @override
  String get customerId;
  @override
  String get issueType;
  @override
  String get status;

  /// Create a copy of ComplaintItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComplaintItemImplCopyWith<_$ComplaintItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AmcProgress _$AmcProgressFromJson(Map<String, dynamic> json) {
  return _AmcProgress.fromJson(json);
}

/// @nodoc
mixin _$AmcProgress {
  String get companyName => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String get statusText => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;

  /// Serializes this AmcProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmcProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmcProgressCopyWith<AmcProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmcProgressCopyWith<$Res> {
  factory $AmcProgressCopyWith(
    AmcProgress value,
    $Res Function(AmcProgress) then,
  ) = _$AmcProgressCopyWithImpl<$Res, AmcProgress>;
  @useResult
  $Res call({
    String companyName,
    double progress,
    String statusText,
    bool isUrgent,
  });
}

/// @nodoc
class _$AmcProgressCopyWithImpl<$Res, $Val extends AmcProgress>
    implements $AmcProgressCopyWith<$Res> {
  _$AmcProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmcProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? progress = null,
    Object? statusText = null,
    Object? isUrgent = null,
  }) {
    return _then(
      _value.copyWith(
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            statusText: null == statusText
                ? _value.statusText
                : statusText // ignore: cast_nullable_to_non_nullable
                      as String,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AmcProgressImplCopyWith<$Res>
    implements $AmcProgressCopyWith<$Res> {
  factory _$$AmcProgressImplCopyWith(
    _$AmcProgressImpl value,
    $Res Function(_$AmcProgressImpl) then,
  ) = __$$AmcProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String companyName,
    double progress,
    String statusText,
    bool isUrgent,
  });
}

/// @nodoc
class __$$AmcProgressImplCopyWithImpl<$Res>
    extends _$AmcProgressCopyWithImpl<$Res, _$AmcProgressImpl>
    implements _$$AmcProgressImplCopyWith<$Res> {
  __$$AmcProgressImplCopyWithImpl(
    _$AmcProgressImpl _value,
    $Res Function(_$AmcProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AmcProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? progress = null,
    Object? statusText = null,
    Object? isUrgent = null,
  }) {
    return _then(
      _$AmcProgressImpl(
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        statusText: null == statusText
            ? _value.statusText
            : statusText // ignore: cast_nullable_to_non_nullable
                  as String,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AmcProgressImpl extends _AmcProgress {
  const _$AmcProgressImpl({
    this.companyName = '',
    this.progress = 0.0,
    this.statusText = '',
    this.isUrgent = false,
  }) : super._();

  factory _$AmcProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmcProgressImplFromJson(json);

  @override
  @JsonKey()
  final String companyName;
  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey()
  final String statusText;
  @override
  @JsonKey()
  final bool isUrgent;

  @override
  String toString() {
    return 'AmcProgress(companyName: $companyName, progress: $progress, statusText: $statusText, isUrgent: $isUrgent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmcProgressImpl &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.statusText, statusText) ||
                other.statusText == statusText) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, companyName, progress, statusText, isUrgent);

  /// Create a copy of AmcProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmcProgressImplCopyWith<_$AmcProgressImpl> get copyWith =>
      __$$AmcProgressImplCopyWithImpl<_$AmcProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmcProgressImplToJson(this);
  }
}

abstract class _AmcProgress extends AmcProgress {
  const factory _AmcProgress({
    final String companyName,
    final double progress,
    final String statusText,
    final bool isUrgent,
  }) = _$AmcProgressImpl;
  const _AmcProgress._() : super._();

  factory _AmcProgress.fromJson(Map<String, dynamic> json) =
      _$AmcProgressImpl.fromJson;

  @override
  String get companyName;
  @override
  double get progress;
  @override
  String get statusText;
  @override
  bool get isUrgent;

  /// Create a copy of AmcProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmcProgressImplCopyWith<_$AmcProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) {
  return _NotificationItem.fromJson(json);
}

/// @nodoc
mixin _$NotificationItem {
  String get customerName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  String get serviceId => throw _privateConstructorUsedError;
  String get notificationDate => throw _privateConstructorUsedError;
  bool get isDismissed => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get serviceDate => throw _privateConstructorUsedError;

  /// Serializes this NotificationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationItemCopyWith<NotificationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationItemCopyWith<$Res> {
  factory $NotificationItemCopyWith(
    NotificationItem value,
    $Res Function(NotificationItem) then,
  ) = _$NotificationItemCopyWithImpl<$Res, NotificationItem>;
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String address,
    String serviceType,
    String serviceId,
    String notificationDate,
    bool isDismissed,
    String phone,
    String note,
    double amount,
    String serviceDate,
  });
}

/// @nodoc
class _$NotificationItemCopyWithImpl<$Res, $Val extends NotificationItem>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? address = null,
    Object? serviceType = null,
    Object? serviceId = null,
    Object? notificationDate = null,
    Object? isDismissed = null,
    Object? phone = null,
    Object? note = null,
    Object? amount = null,
    Object? serviceDate = null,
  }) {
    return _then(
      _value.copyWith(
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceId: null == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            notificationDate: null == notificationDate
                ? _value.notificationDate
                : notificationDate // ignore: cast_nullable_to_non_nullable
                      as String,
            isDismissed: null == isDismissed
                ? _value.isDismissed
                : isDismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            serviceDate: null == serviceDate
                ? _value.serviceDate
                : serviceDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationItemImplCopyWith<$Res>
    implements $NotificationItemCopyWith<$Res> {
  factory _$$NotificationItemImplCopyWith(
    _$NotificationItemImpl value,
    $Res Function(_$NotificationItemImpl) then,
  ) = __$$NotificationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerName,
    String customerId,
    String address,
    String serviceType,
    String serviceId,
    String notificationDate,
    bool isDismissed,
    String phone,
    String note,
    double amount,
    String serviceDate,
  });
}

/// @nodoc
class __$$NotificationItemImplCopyWithImpl<$Res>
    extends _$NotificationItemCopyWithImpl<$Res, _$NotificationItemImpl>
    implements _$$NotificationItemImplCopyWith<$Res> {
  __$$NotificationItemImplCopyWithImpl(
    _$NotificationItemImpl _value,
    $Res Function(_$NotificationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerName = null,
    Object? customerId = null,
    Object? address = null,
    Object? serviceType = null,
    Object? serviceId = null,
    Object? notificationDate = null,
    Object? isDismissed = null,
    Object? phone = null,
    Object? note = null,
    Object? amount = null,
    Object? serviceDate = null,
  }) {
    return _then(
      _$NotificationItemImpl(
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceId: null == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        notificationDate: null == notificationDate
            ? _value.notificationDate
            : notificationDate // ignore: cast_nullable_to_non_nullable
                  as String,
        isDismissed: null == isDismissed
            ? _value.isDismissed
            : isDismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        serviceDate: null == serviceDate
            ? _value.serviceDate
            : serviceDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationItemImpl extends _NotificationItem {
  const _$NotificationItemImpl({
    this.customerName = '',
    this.customerId = '',
    this.address = '',
    this.serviceType = '',
    this.serviceId = '',
    this.notificationDate = '',
    this.isDismissed = false,
    this.phone = '',
    this.note = '',
    this.amount = 0.0,
    this.serviceDate = '',
  }) : super._();

  factory _$NotificationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationItemImplFromJson(json);

  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String customerId;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String serviceType;
  @override
  @JsonKey()
  final String serviceId;
  @override
  @JsonKey()
  final String notificationDate;
  @override
  @JsonKey()
  final bool isDismissed;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String serviceDate;

  @override
  String toString() {
    return 'NotificationItem(customerName: $customerName, customerId: $customerId, address: $address, serviceType: $serviceType, serviceId: $serviceId, notificationDate: $notificationDate, isDismissed: $isDismissed, phone: $phone, note: $note, amount: $amount, serviceDate: $serviceDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationItemImpl &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.notificationDate, notificationDate) ||
                other.notificationDate == notificationDate) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.serviceDate, serviceDate) ||
                other.serviceDate == serviceDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerName,
    customerId,
    address,
    serviceType,
    serviceId,
    notificationDate,
    isDismissed,
    phone,
    note,
    amount,
    serviceDate,
  );

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      __$$NotificationItemImplCopyWithImpl<_$NotificationItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationItemImplToJson(this);
  }
}

abstract class _NotificationItem extends NotificationItem {
  const factory _NotificationItem({
    final String customerName,
    final String customerId,
    final String address,
    final String serviceType,
    final String serviceId,
    final String notificationDate,
    final bool isDismissed,
    final String phone,
    final String note,
    final double amount,
    final String serviceDate,
  }) = _$NotificationItemImpl;
  const _NotificationItem._() : super._();

  factory _NotificationItem.fromJson(Map<String, dynamic> json) =
      _$NotificationItemImpl.fromJson;

  @override
  String get customerName;
  @override
  String get customerId;
  @override
  String get address;
  @override
  String get serviceType;
  @override
  String get serviceId;
  @override
  String get notificationDate;
  @override
  bool get isDismissed;
  @override
  String get phone;
  @override
  String get note;
  @override
  double get amount;
  @override
  String get serviceDate;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingServiceItem _$PendingServiceItemFromJson(Map<String, dynamic> json) {
  return _PendingServiceItem.fromJson(json);
}

/// @nodoc
mixin _$PendingServiceItem {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  String get serviceDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  bool get isComplaint => throw _privateConstructorUsedError;

  /// Serializes this PendingServiceItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingServiceItemCopyWith<PendingServiceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingServiceItemCopyWith<$Res> {
  factory $PendingServiceItemCopyWith(
    PendingServiceItem value,
    $Res Function(PendingServiceItem) then,
  ) = _$PendingServiceItemCopyWithImpl<$Res, PendingServiceItem>;
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String phone,
    String address,
    String serviceType,
    String serviceDate,
    String status,
    String note,
    bool isComplaint,
  });
}

/// @nodoc
class _$PendingServiceItemCopyWithImpl<$Res, $Val extends PendingServiceItem>
    implements $PendingServiceItemCopyWith<$Res> {
  _$PendingServiceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? phone = null,
    Object? address = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? status = null,
    Object? note = null,
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
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDate: null == serviceDate
                ? _value.serviceDate
                : serviceDate // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$PendingServiceItemImplCopyWith<$Res>
    implements $PendingServiceItemCopyWith<$Res> {
  factory _$$PendingServiceItemImplCopyWith(
    _$PendingServiceItemImpl value,
    $Res Function(_$PendingServiceItemImpl) then,
  ) = __$$PendingServiceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String phone,
    String address,
    String serviceType,
    String serviceDate,
    String status,
    String note,
    bool isComplaint,
  });
}

/// @nodoc
class __$$PendingServiceItemImplCopyWithImpl<$Res>
    extends _$PendingServiceItemCopyWithImpl<$Res, _$PendingServiceItemImpl>
    implements _$$PendingServiceItemImplCopyWith<$Res> {
  __$$PendingServiceItemImplCopyWithImpl(
    _$PendingServiceItemImpl _value,
    $Res Function(_$PendingServiceItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? phone = null,
    Object? address = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? status = null,
    Object? note = null,
    Object? isComplaint = null,
  }) {
    return _then(
      _$PendingServiceItemImpl(
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
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDate: null == serviceDate
            ? _value.serviceDate
            : serviceDate // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
        isComplaint: null == isComplaint
            ? _value.isComplaint
            : isComplaint // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingServiceItemImpl extends _PendingServiceItem {
  const _$PendingServiceItemImpl({
    this.id = '',
    this.customerId = '',
    this.customerName = '',
    this.phone = '',
    this.address = '',
    this.serviceType = '',
    this.serviceDate = '',
    this.status = '',
    this.note = '',
    this.isComplaint = false,
  }) : super._();

  factory _$PendingServiceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingServiceItemImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String customerId;
  @override
  @JsonKey()
  final String customerName;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String serviceType;
  @override
  @JsonKey()
  final String serviceDate;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final bool isComplaint;

  @override
  String toString() {
    return 'PendingServiceItem(id: $id, customerId: $customerId, customerName: $customerName, phone: $phone, address: $address, serviceType: $serviceType, serviceDate: $serviceDate, status: $status, note: $note, isComplaint: $isComplaint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingServiceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.serviceDate, serviceDate) ||
                other.serviceDate == serviceDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
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
    phone,
    address,
    serviceType,
    serviceDate,
    status,
    note,
    isComplaint,
  );

  /// Create a copy of PendingServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingServiceItemImplCopyWith<_$PendingServiceItemImpl> get copyWith =>
      __$$PendingServiceItemImplCopyWithImpl<_$PendingServiceItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingServiceItemImplToJson(this);
  }
}

abstract class _PendingServiceItem extends PendingServiceItem {
  const factory _PendingServiceItem({
    final String id,
    final String customerId,
    final String customerName,
    final String phone,
    final String address,
    final String serviceType,
    final String serviceDate,
    final String status,
    final String note,
    final bool isComplaint,
  }) = _$PendingServiceItemImpl;
  const _PendingServiceItem._() : super._();

  factory _PendingServiceItem.fromJson(Map<String, dynamic> json) =
      _$PendingServiceItemImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get serviceType;
  @override
  String get serviceDate;
  @override
  String get status;
  @override
  String get note;
  @override
  bool get isComplaint;

  /// Create a copy of PendingServiceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingServiceItemImplCopyWith<_$PendingServiceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeData _$HomeDataFromJson(Map<String, dynamic> json) {
  return _HomeData.fromJson(json);
}

/// @nodoc
mixin _$HomeData {
  int get newSells => throw _privateConstructorUsedError;
  int get activeRentals => throw _privateConstructorUsedError;
  int get activeAmcs => throw _privateConstructorUsedError;
  int get totalServices => throw _privateConstructorUsedError;
  double get totalCollectedThisMonth => throw _privateConstructorUsedError;
  int get amcServices => throw _privateConstructorUsedError;
  int get newRoServices => throw _privateConstructorUsedError;
  int get repairServices => throw _privateConstructorUsedError;
  int get resolutionRatePercent => throw _privateConstructorUsedError;
  int get pendingComplaintsCount => throw _privateConstructorUsedError;
  List<ScheduleItem> get todaySchedules => throw _privateConstructorUsedError;
  List<ComplaintItem> get pendingComplaints =>
      throw _privateConstructorUsedError;
  List<AmcProgress> get amcProgresses => throw _privateConstructorUsedError;
  List<NotificationItem> get todayNotifications =>
      throw _privateConstructorUsedError;
  List<PendingServiceItem> get pendingServices =>
      throw _privateConstructorUsedError;
  List<ExpiryItem> get expiringItems => throw _privateConstructorUsedError;
  List<PendingPaymentItem> get pendingPayments =>
      throw _privateConstructorUsedError;
  int get todaySellsSummary => throw _privateConstructorUsedError;
  int get weekSellsSummary => throw _privateConstructorUsedError;
  String get projectedGrowth => throw _privateConstructorUsedError;

  /// Serializes this HomeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataCopyWith<HomeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) then) =
      _$HomeDataCopyWithImpl<$Res, HomeData>;
  @useResult
  $Res call({
    int newSells,
    int activeRentals,
    int activeAmcs,
    int totalServices,
    double totalCollectedThisMonth,
    int amcServices,
    int newRoServices,
    int repairServices,
    int resolutionRatePercent,
    int pendingComplaintsCount,
    List<ScheduleItem> todaySchedules,
    List<ComplaintItem> pendingComplaints,
    List<AmcProgress> amcProgresses,
    List<NotificationItem> todayNotifications,
    List<PendingServiceItem> pendingServices,
    List<ExpiryItem> expiringItems,
    List<PendingPaymentItem> pendingPayments,
    int todaySellsSummary,
    int weekSellsSummary,
    String projectedGrowth,
  });
}

/// @nodoc
class _$HomeDataCopyWithImpl<$Res, $Val extends HomeData>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newSells = null,
    Object? activeRentals = null,
    Object? activeAmcs = null,
    Object? totalServices = null,
    Object? totalCollectedThisMonth = null,
    Object? amcServices = null,
    Object? newRoServices = null,
    Object? repairServices = null,
    Object? resolutionRatePercent = null,
    Object? pendingComplaintsCount = null,
    Object? todaySchedules = null,
    Object? pendingComplaints = null,
    Object? amcProgresses = null,
    Object? todayNotifications = null,
    Object? pendingServices = null,
    Object? expiringItems = null,
    Object? pendingPayments = null,
    Object? todaySellsSummary = null,
    Object? weekSellsSummary = null,
    Object? projectedGrowth = null,
  }) {
    return _then(
      _value.copyWith(
            newSells: null == newSells
                ? _value.newSells
                : newSells // ignore: cast_nullable_to_non_nullable
                      as int,
            activeRentals: null == activeRentals
                ? _value.activeRentals
                : activeRentals // ignore: cast_nullable_to_non_nullable
                      as int,
            activeAmcs: null == activeAmcs
                ? _value.activeAmcs
                : activeAmcs // ignore: cast_nullable_to_non_nullable
                      as int,
            totalServices: null == totalServices
                ? _value.totalServices
                : totalServices // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCollectedThisMonth: null == totalCollectedThisMonth
                ? _value.totalCollectedThisMonth
                : totalCollectedThisMonth // ignore: cast_nullable_to_non_nullable
                      as double,
            amcServices: null == amcServices
                ? _value.amcServices
                : amcServices // ignore: cast_nullable_to_non_nullable
                      as int,
            newRoServices: null == newRoServices
                ? _value.newRoServices
                : newRoServices // ignore: cast_nullable_to_non_nullable
                      as int,
            repairServices: null == repairServices
                ? _value.repairServices
                : repairServices // ignore: cast_nullable_to_non_nullable
                      as int,
            resolutionRatePercent: null == resolutionRatePercent
                ? _value.resolutionRatePercent
                : resolutionRatePercent // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingComplaintsCount: null == pendingComplaintsCount
                ? _value.pendingComplaintsCount
                : pendingComplaintsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            todaySchedules: null == todaySchedules
                ? _value.todaySchedules
                : todaySchedules // ignore: cast_nullable_to_non_nullable
                      as List<ScheduleItem>,
            pendingComplaints: null == pendingComplaints
                ? _value.pendingComplaints
                : pendingComplaints // ignore: cast_nullable_to_non_nullable
                      as List<ComplaintItem>,
            amcProgresses: null == amcProgresses
                ? _value.amcProgresses
                : amcProgresses // ignore: cast_nullable_to_non_nullable
                      as List<AmcProgress>,
            todayNotifications: null == todayNotifications
                ? _value.todayNotifications
                : todayNotifications // ignore: cast_nullable_to_non_nullable
                      as List<NotificationItem>,
            pendingServices: null == pendingServices
                ? _value.pendingServices
                : pendingServices // ignore: cast_nullable_to_non_nullable
                      as List<PendingServiceItem>,
            expiringItems: null == expiringItems
                ? _value.expiringItems
                : expiringItems // ignore: cast_nullable_to_non_nullable
                      as List<ExpiryItem>,
            pendingPayments: null == pendingPayments
                ? _value.pendingPayments
                : pendingPayments // ignore: cast_nullable_to_non_nullable
                      as List<PendingPaymentItem>,
            todaySellsSummary: null == todaySellsSummary
                ? _value.todaySellsSummary
                : todaySellsSummary // ignore: cast_nullable_to_non_nullable
                      as int,
            weekSellsSummary: null == weekSellsSummary
                ? _value.weekSellsSummary
                : weekSellsSummary // ignore: cast_nullable_to_non_nullable
                      as int,
            projectedGrowth: null == projectedGrowth
                ? _value.projectedGrowth
                : projectedGrowth // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeDataImplCopyWith<$Res>
    implements $HomeDataCopyWith<$Res> {
  factory _$$HomeDataImplCopyWith(
    _$HomeDataImpl value,
    $Res Function(_$HomeDataImpl) then,
  ) = __$$HomeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int newSells,
    int activeRentals,
    int activeAmcs,
    int totalServices,
    double totalCollectedThisMonth,
    int amcServices,
    int newRoServices,
    int repairServices,
    int resolutionRatePercent,
    int pendingComplaintsCount,
    List<ScheduleItem> todaySchedules,
    List<ComplaintItem> pendingComplaints,
    List<AmcProgress> amcProgresses,
    List<NotificationItem> todayNotifications,
    List<PendingServiceItem> pendingServices,
    List<ExpiryItem> expiringItems,
    List<PendingPaymentItem> pendingPayments,
    int todaySellsSummary,
    int weekSellsSummary,
    String projectedGrowth,
  });
}

/// @nodoc
class __$$HomeDataImplCopyWithImpl<$Res>
    extends _$HomeDataCopyWithImpl<$Res, _$HomeDataImpl>
    implements _$$HomeDataImplCopyWith<$Res> {
  __$$HomeDataImplCopyWithImpl(
    _$HomeDataImpl _value,
    $Res Function(_$HomeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newSells = null,
    Object? activeRentals = null,
    Object? activeAmcs = null,
    Object? totalServices = null,
    Object? totalCollectedThisMonth = null,
    Object? amcServices = null,
    Object? newRoServices = null,
    Object? repairServices = null,
    Object? resolutionRatePercent = null,
    Object? pendingComplaintsCount = null,
    Object? todaySchedules = null,
    Object? pendingComplaints = null,
    Object? amcProgresses = null,
    Object? todayNotifications = null,
    Object? pendingServices = null,
    Object? expiringItems = null,
    Object? pendingPayments = null,
    Object? todaySellsSummary = null,
    Object? weekSellsSummary = null,
    Object? projectedGrowth = null,
  }) {
    return _then(
      _$HomeDataImpl(
        newSells: null == newSells
            ? _value.newSells
            : newSells // ignore: cast_nullable_to_non_nullable
                  as int,
        activeRentals: null == activeRentals
            ? _value.activeRentals
            : activeRentals // ignore: cast_nullable_to_non_nullable
                  as int,
        activeAmcs: null == activeAmcs
            ? _value.activeAmcs
            : activeAmcs // ignore: cast_nullable_to_non_nullable
                  as int,
        totalServices: null == totalServices
            ? _value.totalServices
            : totalServices // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCollectedThisMonth: null == totalCollectedThisMonth
            ? _value.totalCollectedThisMonth
            : totalCollectedThisMonth // ignore: cast_nullable_to_non_nullable
                  as double,
        amcServices: null == amcServices
            ? _value.amcServices
            : amcServices // ignore: cast_nullable_to_non_nullable
                  as int,
        newRoServices: null == newRoServices
            ? _value.newRoServices
            : newRoServices // ignore: cast_nullable_to_non_nullable
                  as int,
        repairServices: null == repairServices
            ? _value.repairServices
            : repairServices // ignore: cast_nullable_to_non_nullable
                  as int,
        resolutionRatePercent: null == resolutionRatePercent
            ? _value.resolutionRatePercent
            : resolutionRatePercent // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingComplaintsCount: null == pendingComplaintsCount
            ? _value.pendingComplaintsCount
            : pendingComplaintsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        todaySchedules: null == todaySchedules
            ? _value._todaySchedules
            : todaySchedules // ignore: cast_nullable_to_non_nullable
                  as List<ScheduleItem>,
        pendingComplaints: null == pendingComplaints
            ? _value._pendingComplaints
            : pendingComplaints // ignore: cast_nullable_to_non_nullable
                  as List<ComplaintItem>,
        amcProgresses: null == amcProgresses
            ? _value._amcProgresses
            : amcProgresses // ignore: cast_nullable_to_non_nullable
                  as List<AmcProgress>,
        todayNotifications: null == todayNotifications
            ? _value._todayNotifications
            : todayNotifications // ignore: cast_nullable_to_non_nullable
                  as List<NotificationItem>,
        pendingServices: null == pendingServices
            ? _value._pendingServices
            : pendingServices // ignore: cast_nullable_to_non_nullable
                  as List<PendingServiceItem>,
        expiringItems: null == expiringItems
            ? _value._expiringItems
            : expiringItems // ignore: cast_nullable_to_non_nullable
                  as List<ExpiryItem>,
        pendingPayments: null == pendingPayments
            ? _value._pendingPayments
            : pendingPayments // ignore: cast_nullable_to_non_nullable
                  as List<PendingPaymentItem>,
        todaySellsSummary: null == todaySellsSummary
            ? _value.todaySellsSummary
            : todaySellsSummary // ignore: cast_nullable_to_non_nullable
                  as int,
        weekSellsSummary: null == weekSellsSummary
            ? _value.weekSellsSummary
            : weekSellsSummary // ignore: cast_nullable_to_non_nullable
                  as int,
        projectedGrowth: null == projectedGrowth
            ? _value.projectedGrowth
            : projectedGrowth // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDataImpl extends _HomeData {
  const _$HomeDataImpl({
    this.newSells = 0,
    this.activeRentals = 0,
    this.activeAmcs = 0,
    this.totalServices = 0,
    this.totalCollectedThisMonth = 0.0,
    this.amcServices = 0,
    this.newRoServices = 0,
    this.repairServices = 0,
    this.resolutionRatePercent = 0,
    this.pendingComplaintsCount = 0,
    final List<ScheduleItem> todaySchedules = const [],
    final List<ComplaintItem> pendingComplaints = const [],
    final List<AmcProgress> amcProgresses = const [],
    final List<NotificationItem> todayNotifications = const [],
    final List<PendingServiceItem> pendingServices = const [],
    final List<ExpiryItem> expiringItems = const [],
    final List<PendingPaymentItem> pendingPayments = const [],
    this.todaySellsSummary = 0,
    this.weekSellsSummary = 0,
    this.projectedGrowth = '',
  }) : _todaySchedules = todaySchedules,
       _pendingComplaints = pendingComplaints,
       _amcProgresses = amcProgresses,
       _todayNotifications = todayNotifications,
       _pendingServices = pendingServices,
       _expiringItems = expiringItems,
       _pendingPayments = pendingPayments,
       super._();

  factory _$HomeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDataImplFromJson(json);

  @override
  @JsonKey()
  final int newSells;
  @override
  @JsonKey()
  final int activeRentals;
  @override
  @JsonKey()
  final int activeAmcs;
  @override
  @JsonKey()
  final int totalServices;
  @override
  @JsonKey()
  final double totalCollectedThisMonth;
  @override
  @JsonKey()
  final int amcServices;
  @override
  @JsonKey()
  final int newRoServices;
  @override
  @JsonKey()
  final int repairServices;
  @override
  @JsonKey()
  final int resolutionRatePercent;
  @override
  @JsonKey()
  final int pendingComplaintsCount;
  final List<ScheduleItem> _todaySchedules;
  @override
  @JsonKey()
  List<ScheduleItem> get todaySchedules {
    if (_todaySchedules is EqualUnmodifiableListView) return _todaySchedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todaySchedules);
  }

  final List<ComplaintItem> _pendingComplaints;
  @override
  @JsonKey()
  List<ComplaintItem> get pendingComplaints {
    if (_pendingComplaints is EqualUnmodifiableListView)
      return _pendingComplaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingComplaints);
  }

  final List<AmcProgress> _amcProgresses;
  @override
  @JsonKey()
  List<AmcProgress> get amcProgresses {
    if (_amcProgresses is EqualUnmodifiableListView) return _amcProgresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amcProgresses);
  }

  final List<NotificationItem> _todayNotifications;
  @override
  @JsonKey()
  List<NotificationItem> get todayNotifications {
    if (_todayNotifications is EqualUnmodifiableListView)
      return _todayNotifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayNotifications);
  }

  final List<PendingServiceItem> _pendingServices;
  @override
  @JsonKey()
  List<PendingServiceItem> get pendingServices {
    if (_pendingServices is EqualUnmodifiableListView) return _pendingServices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingServices);
  }

  final List<ExpiryItem> _expiringItems;
  @override
  @JsonKey()
  List<ExpiryItem> get expiringItems {
    if (_expiringItems is EqualUnmodifiableListView) return _expiringItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expiringItems);
  }

  final List<PendingPaymentItem> _pendingPayments;
  @override
  @JsonKey()
  List<PendingPaymentItem> get pendingPayments {
    if (_pendingPayments is EqualUnmodifiableListView) return _pendingPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingPayments);
  }

  @override
  @JsonKey()
  final int todaySellsSummary;
  @override
  @JsonKey()
  final int weekSellsSummary;
  @override
  @JsonKey()
  final String projectedGrowth;

  @override
  String toString() {
    return 'HomeData(newSells: $newSells, activeRentals: $activeRentals, activeAmcs: $activeAmcs, totalServices: $totalServices, totalCollectedThisMonth: $totalCollectedThisMonth, amcServices: $amcServices, newRoServices: $newRoServices, repairServices: $repairServices, resolutionRatePercent: $resolutionRatePercent, pendingComplaintsCount: $pendingComplaintsCount, todaySchedules: $todaySchedules, pendingComplaints: $pendingComplaints, amcProgresses: $amcProgresses, todayNotifications: $todayNotifications, pendingServices: $pendingServices, expiringItems: $expiringItems, pendingPayments: $pendingPayments, todaySellsSummary: $todaySellsSummary, weekSellsSummary: $weekSellsSummary, projectedGrowth: $projectedGrowth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataImpl &&
            (identical(other.newSells, newSells) ||
                other.newSells == newSells) &&
            (identical(other.activeRentals, activeRentals) ||
                other.activeRentals == activeRentals) &&
            (identical(other.activeAmcs, activeAmcs) ||
                other.activeAmcs == activeAmcs) &&
            (identical(other.totalServices, totalServices) ||
                other.totalServices == totalServices) &&
            (identical(
                  other.totalCollectedThisMonth,
                  totalCollectedThisMonth,
                ) ||
                other.totalCollectedThisMonth == totalCollectedThisMonth) &&
            (identical(other.amcServices, amcServices) ||
                other.amcServices == amcServices) &&
            (identical(other.newRoServices, newRoServices) ||
                other.newRoServices == newRoServices) &&
            (identical(other.repairServices, repairServices) ||
                other.repairServices == repairServices) &&
            (identical(other.resolutionRatePercent, resolutionRatePercent) ||
                other.resolutionRatePercent == resolutionRatePercent) &&
            (identical(other.pendingComplaintsCount, pendingComplaintsCount) ||
                other.pendingComplaintsCount == pendingComplaintsCount) &&
            const DeepCollectionEquality().equals(
              other._todaySchedules,
              _todaySchedules,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingComplaints,
              _pendingComplaints,
            ) &&
            const DeepCollectionEquality().equals(
              other._amcProgresses,
              _amcProgresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._todayNotifications,
              _todayNotifications,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingServices,
              _pendingServices,
            ) &&
            const DeepCollectionEquality().equals(
              other._expiringItems,
              _expiringItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingPayments,
              _pendingPayments,
            ) &&
            (identical(other.todaySellsSummary, todaySellsSummary) ||
                other.todaySellsSummary == todaySellsSummary) &&
            (identical(other.weekSellsSummary, weekSellsSummary) ||
                other.weekSellsSummary == weekSellsSummary) &&
            (identical(other.projectedGrowth, projectedGrowth) ||
                other.projectedGrowth == projectedGrowth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    newSells,
    activeRentals,
    activeAmcs,
    totalServices,
    totalCollectedThisMonth,
    amcServices,
    newRoServices,
    repairServices,
    resolutionRatePercent,
    pendingComplaintsCount,
    const DeepCollectionEquality().hash(_todaySchedules),
    const DeepCollectionEquality().hash(_pendingComplaints),
    const DeepCollectionEquality().hash(_amcProgresses),
    const DeepCollectionEquality().hash(_todayNotifications),
    const DeepCollectionEquality().hash(_pendingServices),
    const DeepCollectionEquality().hash(_expiringItems),
    const DeepCollectionEquality().hash(_pendingPayments),
    todaySellsSummary,
    weekSellsSummary,
    projectedGrowth,
  ]);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDataImplToJson(this);
  }
}

abstract class _HomeData extends HomeData {
  const factory _HomeData({
    final int newSells,
    final int activeRentals,
    final int activeAmcs,
    final int totalServices,
    final double totalCollectedThisMonth,
    final int amcServices,
    final int newRoServices,
    final int repairServices,
    final int resolutionRatePercent,
    final int pendingComplaintsCount,
    final List<ScheduleItem> todaySchedules,
    final List<ComplaintItem> pendingComplaints,
    final List<AmcProgress> amcProgresses,
    final List<NotificationItem> todayNotifications,
    final List<PendingServiceItem> pendingServices,
    final List<ExpiryItem> expiringItems,
    final List<PendingPaymentItem> pendingPayments,
    final int todaySellsSummary,
    final int weekSellsSummary,
    final String projectedGrowth,
  }) = _$HomeDataImpl;
  const _HomeData._() : super._();

  factory _HomeData.fromJson(Map<String, dynamic> json) =
      _$HomeDataImpl.fromJson;

  @override
  int get newSells;
  @override
  int get activeRentals;
  @override
  int get activeAmcs;
  @override
  int get totalServices;
  @override
  double get totalCollectedThisMonth;
  @override
  int get amcServices;
  @override
  int get newRoServices;
  @override
  int get repairServices;
  @override
  int get resolutionRatePercent;
  @override
  int get pendingComplaintsCount;
  @override
  List<ScheduleItem> get todaySchedules;
  @override
  List<ComplaintItem> get pendingComplaints;
  @override
  List<AmcProgress> get amcProgresses;
  @override
  List<NotificationItem> get todayNotifications;
  @override
  List<PendingServiceItem> get pendingServices;
  @override
  List<ExpiryItem> get expiringItems;
  @override
  List<PendingPaymentItem> get pendingPayments;
  @override
  int get todaySellsSummary;
  @override
  int get weekSellsSummary;
  @override
  String get projectedGrowth;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
