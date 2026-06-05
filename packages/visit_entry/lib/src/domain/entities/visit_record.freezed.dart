// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VisitRecord _$VisitRecordFromJson(Map<String, dynamic> json) {
  return _VisitRecord.fromJson(json);
}

/// @nodoc
mixin _$VisitRecord {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  DateTime get serviceDate => throw _privateConstructorUsedError;
  String get remarks => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;
  String get fixes => throw _privateConstructorUsedError;
  double get amountPaid => throw _privateConstructorUsedError;
  double get amountPending => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get equipmentsUsed => throw _privateConstructorUsedError;
  String get serviceDuration => throw _privateConstructorUsedError;
  String get guaranteeDuration => throw _privateConstructorUsedError;
  String? get roType => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get deletedAt => throw _privateConstructorUsedError;
  String? get deletedBy => throw _privateConstructorUsedError;

  /// Serializes this VisitRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VisitRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitRecordCopyWith<VisitRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitRecordCopyWith<$Res> {
  factory $VisitRecordCopyWith(
    VisitRecord value,
    $Res Function(VisitRecord) then,
  ) = _$VisitRecordCopyWithImpl<$Res, VisitRecord>;
  @useResult
  $Res call({
    String id,
    String customerId,
    String serviceType,
    DateTime serviceDate,
    String remarks,
    bool isUrgent,
    String fixes,
    double amountPaid,
    double amountPending,
    double totalAmount,
    String equipmentsUsed,
    String serviceDuration,
    String guaranteeDuration,
    String? roType,
    bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  });
}

/// @nodoc
class _$VisitRecordCopyWithImpl<$Res, $Val extends VisitRecord>
    implements $VisitRecordCopyWith<$Res> {
  _$VisitRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? remarks = null,
    Object? isUrgent = null,
    Object? fixes = null,
    Object? amountPaid = null,
    Object? amountPending = null,
    Object? totalAmount = null,
    Object? equipmentsUsed = null,
    Object? serviceDuration = null,
    Object? guaranteeDuration = null,
    Object? roType = freezed,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
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
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDate: null == serviceDate
                ? _value.serviceDate
                : serviceDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            remarks: null == remarks
                ? _value.remarks
                : remarks // ignore: cast_nullable_to_non_nullable
                      as String,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
            fixes: null == fixes
                ? _value.fixes
                : fixes // ignore: cast_nullable_to_non_nullable
                      as String,
            amountPaid: null == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as double,
            amountPending: null == amountPending
                ? _value.amountPending
                : amountPending // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            equipmentsUsed: null == equipmentsUsed
                ? _value.equipmentsUsed
                : equipmentsUsed // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDuration: null == serviceDuration
                ? _value.serviceDuration
                : serviceDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            guaranteeDuration: null == guaranteeDuration
                ? _value.guaranteeDuration
                : guaranteeDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            roType: freezed == roType
                ? _value.roType
                : roType // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            deletedBy: freezed == deletedBy
                ? _value.deletedBy
                : deletedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VisitRecordImplCopyWith<$Res>
    implements $VisitRecordCopyWith<$Res> {
  factory _$$VisitRecordImplCopyWith(
    _$VisitRecordImpl value,
    $Res Function(_$VisitRecordImpl) then,
  ) = __$$VisitRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customerId,
    String serviceType,
    DateTime serviceDate,
    String remarks,
    bool isUrgent,
    String fixes,
    double amountPaid,
    double amountPending,
    double totalAmount,
    String equipmentsUsed,
    String serviceDuration,
    String guaranteeDuration,
    String? roType,
    bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  });
}

/// @nodoc
class __$$VisitRecordImplCopyWithImpl<$Res>
    extends _$VisitRecordCopyWithImpl<$Res, _$VisitRecordImpl>
    implements _$$VisitRecordImplCopyWith<$Res> {
  __$$VisitRecordImplCopyWithImpl(
    _$VisitRecordImpl _value,
    $Res Function(_$VisitRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? serviceType = null,
    Object? serviceDate = null,
    Object? remarks = null,
    Object? isUrgent = null,
    Object? fixes = null,
    Object? amountPaid = null,
    Object? amountPending = null,
    Object? totalAmount = null,
    Object? equipmentsUsed = null,
    Object? serviceDuration = null,
    Object? guaranteeDuration = null,
    Object? roType = freezed,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
  }) {
    return _then(
      _$VisitRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDate: null == serviceDate
            ? _value.serviceDate
            : serviceDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        remarks: null == remarks
            ? _value.remarks
            : remarks // ignore: cast_nullable_to_non_nullable
                  as String,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
        fixes: null == fixes
            ? _value.fixes
            : fixes // ignore: cast_nullable_to_non_nullable
                  as String,
        amountPaid: null == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as double,
        amountPending: null == amountPending
            ? _value.amountPending
            : amountPending // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        equipmentsUsed: null == equipmentsUsed
            ? _value.equipmentsUsed
            : equipmentsUsed // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDuration: null == serviceDuration
            ? _value.serviceDuration
            : serviceDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        guaranteeDuration: null == guaranteeDuration
            ? _value.guaranteeDuration
            : guaranteeDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        roType: freezed == roType
            ? _value.roType
            : roType // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        deletedBy: freezed == deletedBy
            ? _value.deletedBy
            : deletedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$VisitRecordImpl implements _VisitRecord {
  const _$VisitRecordImpl({
    required this.id,
    required this.customerId,
    required this.serviceType,
    required this.serviceDate,
    required this.remarks,
    this.isUrgent = false,
    this.fixes = '',
    this.amountPaid = 0.0,
    this.amountPending = 0.0,
    this.totalAmount = 0.0,
    this.equipmentsUsed = '',
    this.serviceDuration = '',
    this.guaranteeDuration = '',
    this.roType,
    this.isDeleted = false,
    this.deletedAt,
    this.deletedBy,
  });

  factory _$VisitRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String serviceType;
  @override
  final DateTime serviceDate;
  @override
  final String remarks;
  @override
  @JsonKey()
  final bool isUrgent;
  @override
  @JsonKey()
  final String fixes;
  @override
  @JsonKey()
  final double amountPaid;
  @override
  @JsonKey()
  final double amountPending;
  @override
  @JsonKey()
  final double totalAmount;
  @override
  @JsonKey()
  final String equipmentsUsed;
  @override
  @JsonKey()
  final String serviceDuration;
  @override
  @JsonKey()
  final String guaranteeDuration;
  @override
  final String? roType;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String? deletedAt;
  @override
  final String? deletedBy;

  @override
  String toString() {
    return 'VisitRecord(id: $id, customerId: $customerId, serviceType: $serviceType, serviceDate: $serviceDate, remarks: $remarks, isUrgent: $isUrgent, fixes: $fixes, amountPaid: $amountPaid, amountPending: $amountPending, totalAmount: $totalAmount, equipmentsUsed: $equipmentsUsed, serviceDuration: $serviceDuration, guaranteeDuration: $guaranteeDuration, roType: $roType, isDeleted: $isDeleted, deletedAt: $deletedAt, deletedBy: $deletedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.serviceDate, serviceDate) ||
                other.serviceDate == serviceDate) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.fixes, fixes) || other.fixes == fixes) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.amountPending, amountPending) ||
                other.amountPending == amountPending) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.equipmentsUsed, equipmentsUsed) ||
                other.equipmentsUsed == equipmentsUsed) &&
            (identical(other.serviceDuration, serviceDuration) ||
                other.serviceDuration == serviceDuration) &&
            (identical(other.guaranteeDuration, guaranteeDuration) ||
                other.guaranteeDuration == guaranteeDuration) &&
            (identical(other.roType, roType) || other.roType == roType) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customerId,
    serviceType,
    serviceDate,
    remarks,
    isUrgent,
    fixes,
    amountPaid,
    amountPending,
    totalAmount,
    equipmentsUsed,
    serviceDuration,
    guaranteeDuration,
    roType,
    isDeleted,
    deletedAt,
    deletedBy,
  );

  /// Create a copy of VisitRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitRecordImplCopyWith<_$VisitRecordImpl> get copyWith =>
      __$$VisitRecordImplCopyWithImpl<_$VisitRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitRecordImplToJson(this);
  }
}

abstract class _VisitRecord implements VisitRecord {
  const factory _VisitRecord({
    required final String id,
    required final String customerId,
    required final String serviceType,
    required final DateTime serviceDate,
    required final String remarks,
    final bool isUrgent,
    final String fixes,
    final double amountPaid,
    final double amountPending,
    final double totalAmount,
    final String equipmentsUsed,
    final String serviceDuration,
    final String guaranteeDuration,
    final String? roType,
    final bool isDeleted,
    final String? deletedAt,
    final String? deletedBy,
  }) = _$VisitRecordImpl;

  factory _VisitRecord.fromJson(Map<String, dynamic> json) =
      _$VisitRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get serviceType;
  @override
  DateTime get serviceDate;
  @override
  String get remarks;
  @override
  bool get isUrgent;
  @override
  String get fixes;
  @override
  double get amountPaid;
  @override
  double get amountPending;
  @override
  double get totalAmount;
  @override
  String get equipmentsUsed;
  @override
  String get serviceDuration;
  @override
  String get guaranteeDuration;
  @override
  String? get roType;
  @override
  bool get isDeleted;
  @override
  String? get deletedAt;
  @override
  String? get deletedBy;

  /// Create a copy of VisitRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitRecordImplCopyWith<_$VisitRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
