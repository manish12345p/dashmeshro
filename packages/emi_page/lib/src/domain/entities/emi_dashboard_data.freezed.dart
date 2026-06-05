// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emi_dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmiDashboardData _$EmiDashboardDataFromJson(Map<String, dynamic> json) {
  return _EmiDashboardData.fromJson(json);
}

/// @nodoc
mixin _$EmiDashboardData {
  double get totalCollection => throw _privateConstructorUsedError;
  double get collectedThisMonth => throw _privateConstructorUsedError;
  double get lifetimeServiceRevenue => throw _privateConstructorUsedError;
  double get collectionGrowthPercentage => throw _privateConstructorUsedError;
  double get pendingThisMonth => throw _privateConstructorUsedError;
  int get pendingClientsCount => throw _privateConstructorUsedError;
  double get monthlyTargetCollectionPercentage =>
      throw _privateConstructorUsedError;
  List<RecentlyPaidInstallment> get recentlyPaidInstallments =>
      throw _privateConstructorUsedError;
  List<ActiveInstallment> get activeInstallments =>
      throw _privateConstructorUsedError;
  double get onTimePaymentPercentage => throw _privateConstructorUsedError;
  int get earlyPayments => throw _privateConstructorUsedError;
  int get gracePeriod => throw _privateConstructorUsedError;
  int get defaulters => throw _privateConstructorUsedError;

  /// Serializes this EmiDashboardData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmiDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmiDashboardDataCopyWith<EmiDashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmiDashboardDataCopyWith<$Res> {
  factory $EmiDashboardDataCopyWith(
    EmiDashboardData value,
    $Res Function(EmiDashboardData) then,
  ) = _$EmiDashboardDataCopyWithImpl<$Res, EmiDashboardData>;
  @useResult
  $Res call({
    double totalCollection,
    double collectedThisMonth,
    double lifetimeServiceRevenue,
    double collectionGrowthPercentage,
    double pendingThisMonth,
    int pendingClientsCount,
    double monthlyTargetCollectionPercentage,
    List<RecentlyPaidInstallment> recentlyPaidInstallments,
    List<ActiveInstallment> activeInstallments,
    double onTimePaymentPercentage,
    int earlyPayments,
    int gracePeriod,
    int defaulters,
  });
}

/// @nodoc
class _$EmiDashboardDataCopyWithImpl<$Res, $Val extends EmiDashboardData>
    implements $EmiDashboardDataCopyWith<$Res> {
  _$EmiDashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmiDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCollection = null,
    Object? collectedThisMonth = null,
    Object? lifetimeServiceRevenue = null,
    Object? collectionGrowthPercentage = null,
    Object? pendingThisMonth = null,
    Object? pendingClientsCount = null,
    Object? monthlyTargetCollectionPercentage = null,
    Object? recentlyPaidInstallments = null,
    Object? activeInstallments = null,
    Object? onTimePaymentPercentage = null,
    Object? earlyPayments = null,
    Object? gracePeriod = null,
    Object? defaulters = null,
  }) {
    return _then(
      _value.copyWith(
            totalCollection: null == totalCollection
                ? _value.totalCollection
                : totalCollection // ignore: cast_nullable_to_non_nullable
                      as double,
            collectedThisMonth: null == collectedThisMonth
                ? _value.collectedThisMonth
                : collectedThisMonth // ignore: cast_nullable_to_non_nullable
                      as double,
            lifetimeServiceRevenue: null == lifetimeServiceRevenue
                ? _value.lifetimeServiceRevenue
                : lifetimeServiceRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            collectionGrowthPercentage: null == collectionGrowthPercentage
                ? _value.collectionGrowthPercentage
                : collectionGrowthPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingThisMonth: null == pendingThisMonth
                ? _value.pendingThisMonth
                : pendingThisMonth // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingClientsCount: null == pendingClientsCount
                ? _value.pendingClientsCount
                : pendingClientsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            monthlyTargetCollectionPercentage:
                null == monthlyTargetCollectionPercentage
                ? _value.monthlyTargetCollectionPercentage
                : monthlyTargetCollectionPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            recentlyPaidInstallments: null == recentlyPaidInstallments
                ? _value.recentlyPaidInstallments
                : recentlyPaidInstallments // ignore: cast_nullable_to_non_nullable
                      as List<RecentlyPaidInstallment>,
            activeInstallments: null == activeInstallments
                ? _value.activeInstallments
                : activeInstallments // ignore: cast_nullable_to_non_nullable
                      as List<ActiveInstallment>,
            onTimePaymentPercentage: null == onTimePaymentPercentage
                ? _value.onTimePaymentPercentage
                : onTimePaymentPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            earlyPayments: null == earlyPayments
                ? _value.earlyPayments
                : earlyPayments // ignore: cast_nullable_to_non_nullable
                      as int,
            gracePeriod: null == gracePeriod
                ? _value.gracePeriod
                : gracePeriod // ignore: cast_nullable_to_non_nullable
                      as int,
            defaulters: null == defaulters
                ? _value.defaulters
                : defaulters // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmiDashboardDataImplCopyWith<$Res>
    implements $EmiDashboardDataCopyWith<$Res> {
  factory _$$EmiDashboardDataImplCopyWith(
    _$EmiDashboardDataImpl value,
    $Res Function(_$EmiDashboardDataImpl) then,
  ) = __$$EmiDashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalCollection,
    double collectedThisMonth,
    double lifetimeServiceRevenue,
    double collectionGrowthPercentage,
    double pendingThisMonth,
    int pendingClientsCount,
    double monthlyTargetCollectionPercentage,
    List<RecentlyPaidInstallment> recentlyPaidInstallments,
    List<ActiveInstallment> activeInstallments,
    double onTimePaymentPercentage,
    int earlyPayments,
    int gracePeriod,
    int defaulters,
  });
}

/// @nodoc
class __$$EmiDashboardDataImplCopyWithImpl<$Res>
    extends _$EmiDashboardDataCopyWithImpl<$Res, _$EmiDashboardDataImpl>
    implements _$$EmiDashboardDataImplCopyWith<$Res> {
  __$$EmiDashboardDataImplCopyWithImpl(
    _$EmiDashboardDataImpl _value,
    $Res Function(_$EmiDashboardDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmiDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCollection = null,
    Object? collectedThisMonth = null,
    Object? lifetimeServiceRevenue = null,
    Object? collectionGrowthPercentage = null,
    Object? pendingThisMonth = null,
    Object? pendingClientsCount = null,
    Object? monthlyTargetCollectionPercentage = null,
    Object? recentlyPaidInstallments = null,
    Object? activeInstallments = null,
    Object? onTimePaymentPercentage = null,
    Object? earlyPayments = null,
    Object? gracePeriod = null,
    Object? defaulters = null,
  }) {
    return _then(
      _$EmiDashboardDataImpl(
        totalCollection: null == totalCollection
            ? _value.totalCollection
            : totalCollection // ignore: cast_nullable_to_non_nullable
                  as double,
        collectedThisMonth: null == collectedThisMonth
            ? _value.collectedThisMonth
            : collectedThisMonth // ignore: cast_nullable_to_non_nullable
                  as double,
        lifetimeServiceRevenue: null == lifetimeServiceRevenue
            ? _value.lifetimeServiceRevenue
            : lifetimeServiceRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        collectionGrowthPercentage: null == collectionGrowthPercentage
            ? _value.collectionGrowthPercentage
            : collectionGrowthPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingThisMonth: null == pendingThisMonth
            ? _value.pendingThisMonth
            : pendingThisMonth // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingClientsCount: null == pendingClientsCount
            ? _value.pendingClientsCount
            : pendingClientsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        monthlyTargetCollectionPercentage:
            null == monthlyTargetCollectionPercentage
            ? _value.monthlyTargetCollectionPercentage
            : monthlyTargetCollectionPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        recentlyPaidInstallments: null == recentlyPaidInstallments
            ? _value._recentlyPaidInstallments
            : recentlyPaidInstallments // ignore: cast_nullable_to_non_nullable
                  as List<RecentlyPaidInstallment>,
        activeInstallments: null == activeInstallments
            ? _value._activeInstallments
            : activeInstallments // ignore: cast_nullable_to_non_nullable
                  as List<ActiveInstallment>,
        onTimePaymentPercentage: null == onTimePaymentPercentage
            ? _value.onTimePaymentPercentage
            : onTimePaymentPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        earlyPayments: null == earlyPayments
            ? _value.earlyPayments
            : earlyPayments // ignore: cast_nullable_to_non_nullable
                  as int,
        gracePeriod: null == gracePeriod
            ? _value.gracePeriod
            : gracePeriod // ignore: cast_nullable_to_non_nullable
                  as int,
        defaulters: null == defaulters
            ? _value.defaulters
            : defaulters // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmiDashboardDataImpl implements _EmiDashboardData {
  const _$EmiDashboardDataImpl({
    required this.totalCollection,
    required this.collectedThisMonth,
    required this.lifetimeServiceRevenue,
    required this.collectionGrowthPercentage,
    required this.pendingThisMonth,
    required this.pendingClientsCount,
    required this.monthlyTargetCollectionPercentage,
    required final List<RecentlyPaidInstallment> recentlyPaidInstallments,
    required final List<ActiveInstallment> activeInstallments,
    required this.onTimePaymentPercentage,
    required this.earlyPayments,
    required this.gracePeriod,
    required this.defaulters,
  }) : _recentlyPaidInstallments = recentlyPaidInstallments,
       _activeInstallments = activeInstallments;

  factory _$EmiDashboardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmiDashboardDataImplFromJson(json);

  @override
  final double totalCollection;
  @override
  final double collectedThisMonth;
  @override
  final double lifetimeServiceRevenue;
  @override
  final double collectionGrowthPercentage;
  @override
  final double pendingThisMonth;
  @override
  final int pendingClientsCount;
  @override
  final double monthlyTargetCollectionPercentage;
  final List<RecentlyPaidInstallment> _recentlyPaidInstallments;
  @override
  List<RecentlyPaidInstallment> get recentlyPaidInstallments {
    if (_recentlyPaidInstallments is EqualUnmodifiableListView)
      return _recentlyPaidInstallments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentlyPaidInstallments);
  }

  final List<ActiveInstallment> _activeInstallments;
  @override
  List<ActiveInstallment> get activeInstallments {
    if (_activeInstallments is EqualUnmodifiableListView)
      return _activeInstallments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeInstallments);
  }

  @override
  final double onTimePaymentPercentage;
  @override
  final int earlyPayments;
  @override
  final int gracePeriod;
  @override
  final int defaulters;

  @override
  String toString() {
    return 'EmiDashboardData(totalCollection: $totalCollection, collectedThisMonth: $collectedThisMonth, lifetimeServiceRevenue: $lifetimeServiceRevenue, collectionGrowthPercentage: $collectionGrowthPercentage, pendingThisMonth: $pendingThisMonth, pendingClientsCount: $pendingClientsCount, monthlyTargetCollectionPercentage: $monthlyTargetCollectionPercentage, recentlyPaidInstallments: $recentlyPaidInstallments, activeInstallments: $activeInstallments, onTimePaymentPercentage: $onTimePaymentPercentage, earlyPayments: $earlyPayments, gracePeriod: $gracePeriod, defaulters: $defaulters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmiDashboardDataImpl &&
            (identical(other.totalCollection, totalCollection) ||
                other.totalCollection == totalCollection) &&
            (identical(other.collectedThisMonth, collectedThisMonth) ||
                other.collectedThisMonth == collectedThisMonth) &&
            (identical(other.lifetimeServiceRevenue, lifetimeServiceRevenue) ||
                other.lifetimeServiceRevenue == lifetimeServiceRevenue) &&
            (identical(
                  other.collectionGrowthPercentage,
                  collectionGrowthPercentage,
                ) ||
                other.collectionGrowthPercentage ==
                    collectionGrowthPercentage) &&
            (identical(other.pendingThisMonth, pendingThisMonth) ||
                other.pendingThisMonth == pendingThisMonth) &&
            (identical(other.pendingClientsCount, pendingClientsCount) ||
                other.pendingClientsCount == pendingClientsCount) &&
            (identical(
                  other.monthlyTargetCollectionPercentage,
                  monthlyTargetCollectionPercentage,
                ) ||
                other.monthlyTargetCollectionPercentage ==
                    monthlyTargetCollectionPercentage) &&
            const DeepCollectionEquality().equals(
              other._recentlyPaidInstallments,
              _recentlyPaidInstallments,
            ) &&
            const DeepCollectionEquality().equals(
              other._activeInstallments,
              _activeInstallments,
            ) &&
            (identical(
                  other.onTimePaymentPercentage,
                  onTimePaymentPercentage,
                ) ||
                other.onTimePaymentPercentage == onTimePaymentPercentage) &&
            (identical(other.earlyPayments, earlyPayments) ||
                other.earlyPayments == earlyPayments) &&
            (identical(other.gracePeriod, gracePeriod) ||
                other.gracePeriod == gracePeriod) &&
            (identical(other.defaulters, defaulters) ||
                other.defaulters == defaulters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCollection,
    collectedThisMonth,
    lifetimeServiceRevenue,
    collectionGrowthPercentage,
    pendingThisMonth,
    pendingClientsCount,
    monthlyTargetCollectionPercentage,
    const DeepCollectionEquality().hash(_recentlyPaidInstallments),
    const DeepCollectionEquality().hash(_activeInstallments),
    onTimePaymentPercentage,
    earlyPayments,
    gracePeriod,
    defaulters,
  );

  /// Create a copy of EmiDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmiDashboardDataImplCopyWith<_$EmiDashboardDataImpl> get copyWith =>
      __$$EmiDashboardDataImplCopyWithImpl<_$EmiDashboardDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmiDashboardDataImplToJson(this);
  }
}

abstract class _EmiDashboardData implements EmiDashboardData {
  const factory _EmiDashboardData({
    required final double totalCollection,
    required final double collectedThisMonth,
    required final double lifetimeServiceRevenue,
    required final double collectionGrowthPercentage,
    required final double pendingThisMonth,
    required final int pendingClientsCount,
    required final double monthlyTargetCollectionPercentage,
    required final List<RecentlyPaidInstallment> recentlyPaidInstallments,
    required final List<ActiveInstallment> activeInstallments,
    required final double onTimePaymentPercentage,
    required final int earlyPayments,
    required final int gracePeriod,
    required final int defaulters,
  }) = _$EmiDashboardDataImpl;

  factory _EmiDashboardData.fromJson(Map<String, dynamic> json) =
      _$EmiDashboardDataImpl.fromJson;

  @override
  double get totalCollection;
  @override
  double get collectedThisMonth;
  @override
  double get lifetimeServiceRevenue;
  @override
  double get collectionGrowthPercentage;
  @override
  double get pendingThisMonth;
  @override
  int get pendingClientsCount;
  @override
  double get monthlyTargetCollectionPercentage;
  @override
  List<RecentlyPaidInstallment> get recentlyPaidInstallments;
  @override
  List<ActiveInstallment> get activeInstallments;
  @override
  double get onTimePaymentPercentage;
  @override
  int get earlyPayments;
  @override
  int get gracePeriod;
  @override
  int get defaulters;

  /// Create a copy of EmiDashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmiDashboardDataImplCopyWith<_$EmiDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentlyPaidInstallment _$RecentlyPaidInstallmentFromJson(
  Map<String, dynamic> json,
) {
  return _RecentlyPaidInstallment.fromJson(json);
}

/// @nodoc
mixin _$RecentlyPaidInstallment {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get paidDateStr => throw _privateConstructorUsedError;

  /// Serializes this RecentlyPaidInstallment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentlyPaidInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentlyPaidInstallmentCopyWith<RecentlyPaidInstallment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentlyPaidInstallmentCopyWith<$Res> {
  factory $RecentlyPaidInstallmentCopyWith(
    RecentlyPaidInstallment value,
    $Res Function(RecentlyPaidInstallment) then,
  ) = _$RecentlyPaidInstallmentCopyWithImpl<$Res, RecentlyPaidInstallment>;
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    double amount,
    String paidDateStr,
  });
}

/// @nodoc
class _$RecentlyPaidInstallmentCopyWithImpl<
  $Res,
  $Val extends RecentlyPaidInstallment
>
    implements $RecentlyPaidInstallmentCopyWith<$Res> {
  _$RecentlyPaidInstallmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentlyPaidInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? amount = null,
    Object? paidDateStr = null,
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
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paidDateStr: null == paidDateStr
                ? _value.paidDateStr
                : paidDateStr // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecentlyPaidInstallmentImplCopyWith<$Res>
    implements $RecentlyPaidInstallmentCopyWith<$Res> {
  factory _$$RecentlyPaidInstallmentImplCopyWith(
    _$RecentlyPaidInstallmentImpl value,
    $Res Function(_$RecentlyPaidInstallmentImpl) then,
  ) = __$$RecentlyPaidInstallmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    double amount,
    String paidDateStr,
  });
}

/// @nodoc
class __$$RecentlyPaidInstallmentImplCopyWithImpl<$Res>
    extends
        _$RecentlyPaidInstallmentCopyWithImpl<
          $Res,
          _$RecentlyPaidInstallmentImpl
        >
    implements _$$RecentlyPaidInstallmentImplCopyWith<$Res> {
  __$$RecentlyPaidInstallmentImplCopyWithImpl(
    _$RecentlyPaidInstallmentImpl _value,
    $Res Function(_$RecentlyPaidInstallmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecentlyPaidInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? amount = null,
    Object? paidDateStr = null,
  }) {
    return _then(
      _$RecentlyPaidInstallmentImpl(
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
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paidDateStr: null == paidDateStr
            ? _value.paidDateStr
            : paidDateStr // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentlyPaidInstallmentImpl implements _RecentlyPaidInstallment {
  const _$RecentlyPaidInstallmentImpl({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.amount,
    required this.paidDateStr,
  });

  factory _$RecentlyPaidInstallmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentlyPaidInstallmentImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final double amount;
  @override
  final String paidDateStr;

  @override
  String toString() {
    return 'RecentlyPaidInstallment(id: $id, customerId: $customerId, customerName: $customerName, amount: $amount, paidDateStr: $paidDateStr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentlyPaidInstallmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paidDateStr, paidDateStr) ||
                other.paidDateStr == paidDateStr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customerId,
    customerName,
    amount,
    paidDateStr,
  );

  /// Create a copy of RecentlyPaidInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentlyPaidInstallmentImplCopyWith<_$RecentlyPaidInstallmentImpl>
  get copyWith =>
      __$$RecentlyPaidInstallmentImplCopyWithImpl<
        _$RecentlyPaidInstallmentImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentlyPaidInstallmentImplToJson(this);
  }
}

abstract class _RecentlyPaidInstallment implements RecentlyPaidInstallment {
  const factory _RecentlyPaidInstallment({
    required final String id,
    required final String customerId,
    required final String customerName,
    required final double amount,
    required final String paidDateStr,
  }) = _$RecentlyPaidInstallmentImpl;

  factory _RecentlyPaidInstallment.fromJson(Map<String, dynamic> json) =
      _$RecentlyPaidInstallmentImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  double get amount;
  @override
  String get paidDateStr;

  /// Create a copy of RecentlyPaidInstallment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentlyPaidInstallmentImplCopyWith<_$RecentlyPaidInstallmentImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ActiveInstallment _$ActiveInstallmentFromJson(Map<String, dynamic> json) {
  return _ActiveInstallment.fromJson(json);
}

/// @nodoc
mixin _$ActiveInstallment {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get vehicleDetails => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get originalLoanAmount => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  double get lastPaymentAmount => throw _privateConstructorUsedError;
  String get lastPaymentDateStr => throw _privateConstructorUsedError;
  String get dueDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  bool get isRent => throw _privateConstructorUsedError;
  int? get rentDueDay => throw _privateConstructorUsedError;

  /// Serializes this ActiveInstallment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveInstallmentCopyWith<ActiveInstallment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveInstallmentCopyWith<$Res> {
  factory $ActiveInstallmentCopyWith(
    ActiveInstallment value,
    $Res Function(ActiveInstallment) then,
  ) = _$ActiveInstallmentCopyWithImpl<$Res, ActiveInstallment>;
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String vehicleDetails,
    double amount,
    double totalAmount,
    double originalLoanAmount,
    String serviceName,
    double lastPaymentAmount,
    String lastPaymentDateStr,
    String dueDate,
    String status,
    String avatarUrl,
    bool isRent,
    int? rentDueDay,
  });
}

/// @nodoc
class _$ActiveInstallmentCopyWithImpl<$Res, $Val extends ActiveInstallment>
    implements $ActiveInstallmentCopyWith<$Res> {
  _$ActiveInstallmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? vehicleDetails = null,
    Object? amount = null,
    Object? totalAmount = null,
    Object? originalLoanAmount = null,
    Object? serviceName = null,
    Object? lastPaymentAmount = null,
    Object? lastPaymentDateStr = null,
    Object? dueDate = null,
    Object? status = null,
    Object? avatarUrl = null,
    Object? isRent = null,
    Object? rentDueDay = freezed,
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
            vehicleDetails: null == vehicleDetails
                ? _value.vehicleDetails
                : vehicleDetails // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            originalLoanAmount: null == originalLoanAmount
                ? _value.originalLoanAmount
                : originalLoanAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            serviceName: null == serviceName
                ? _value.serviceName
                : serviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastPaymentAmount: null == lastPaymentAmount
                ? _value.lastPaymentAmount
                : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            lastPaymentDateStr: null == lastPaymentDateStr
                ? _value.lastPaymentDateStr
                : lastPaymentDateStr // ignore: cast_nullable_to_non_nullable
                      as String,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isRent: null == isRent
                ? _value.isRent
                : isRent // ignore: cast_nullable_to_non_nullable
                      as bool,
            rentDueDay: freezed == rentDueDay
                ? _value.rentDueDay
                : rentDueDay // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActiveInstallmentImplCopyWith<$Res>
    implements $ActiveInstallmentCopyWith<$Res> {
  factory _$$ActiveInstallmentImplCopyWith(
    _$ActiveInstallmentImpl value,
    $Res Function(_$ActiveInstallmentImpl) then,
  ) = __$$ActiveInstallmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customerId,
    String customerName,
    String vehicleDetails,
    double amount,
    double totalAmount,
    double originalLoanAmount,
    String serviceName,
    double lastPaymentAmount,
    String lastPaymentDateStr,
    String dueDate,
    String status,
    String avatarUrl,
    bool isRent,
    int? rentDueDay,
  });
}

/// @nodoc
class __$$ActiveInstallmentImplCopyWithImpl<$Res>
    extends _$ActiveInstallmentCopyWithImpl<$Res, _$ActiveInstallmentImpl>
    implements _$$ActiveInstallmentImplCopyWith<$Res> {
  __$$ActiveInstallmentImplCopyWithImpl(
    _$ActiveInstallmentImpl _value,
    $Res Function(_$ActiveInstallmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? vehicleDetails = null,
    Object? amount = null,
    Object? totalAmount = null,
    Object? originalLoanAmount = null,
    Object? serviceName = null,
    Object? lastPaymentAmount = null,
    Object? lastPaymentDateStr = null,
    Object? dueDate = null,
    Object? status = null,
    Object? avatarUrl = null,
    Object? isRent = null,
    Object? rentDueDay = freezed,
  }) {
    return _then(
      _$ActiveInstallmentImpl(
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
        vehicleDetails: null == vehicleDetails
            ? _value.vehicleDetails
            : vehicleDetails // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        originalLoanAmount: null == originalLoanAmount
            ? _value.originalLoanAmount
            : originalLoanAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        serviceName: null == serviceName
            ? _value.serviceName
            : serviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastPaymentAmount: null == lastPaymentAmount
            ? _value.lastPaymentAmount
            : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        lastPaymentDateStr: null == lastPaymentDateStr
            ? _value.lastPaymentDateStr
            : lastPaymentDateStr // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isRent: null == isRent
            ? _value.isRent
            : isRent // ignore: cast_nullable_to_non_nullable
                  as bool,
        rentDueDay: freezed == rentDueDay
            ? _value.rentDueDay
            : rentDueDay // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveInstallmentImpl implements _ActiveInstallment {
  const _$ActiveInstallmentImpl({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.vehicleDetails,
    required this.amount,
    required this.totalAmount,
    this.originalLoanAmount = 0.0,
    this.serviceName = '',
    this.lastPaymentAmount = 0.0,
    this.lastPaymentDateStr = '',
    required this.dueDate,
    required this.status,
    required this.avatarUrl,
    this.isRent = false,
    this.rentDueDay,
  });

  factory _$ActiveInstallmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveInstallmentImplFromJson(json);

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final String vehicleDetails;
  @override
  final double amount;
  @override
  final double totalAmount;
  @override
  @JsonKey()
  final double originalLoanAmount;
  @override
  @JsonKey()
  final String serviceName;
  @override
  @JsonKey()
  final double lastPaymentAmount;
  @override
  @JsonKey()
  final String lastPaymentDateStr;
  @override
  final String dueDate;
  @override
  final String status;
  @override
  final String avatarUrl;
  @override
  @JsonKey()
  final bool isRent;
  @override
  final int? rentDueDay;

  @override
  String toString() {
    return 'ActiveInstallment(id: $id, customerId: $customerId, customerName: $customerName, vehicleDetails: $vehicleDetails, amount: $amount, totalAmount: $totalAmount, originalLoanAmount: $originalLoanAmount, serviceName: $serviceName, lastPaymentAmount: $lastPaymentAmount, lastPaymentDateStr: $lastPaymentDateStr, dueDate: $dueDate, status: $status, avatarUrl: $avatarUrl, isRent: $isRent, rentDueDay: $rentDueDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveInstallmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.vehicleDetails, vehicleDetails) ||
                other.vehicleDetails == vehicleDetails) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.originalLoanAmount, originalLoanAmount) ||
                other.originalLoanAmount == originalLoanAmount) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.lastPaymentAmount, lastPaymentAmount) ||
                other.lastPaymentAmount == lastPaymentAmount) &&
            (identical(other.lastPaymentDateStr, lastPaymentDateStr) ||
                other.lastPaymentDateStr == lastPaymentDateStr) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isRent, isRent) || other.isRent == isRent) &&
            (identical(other.rentDueDay, rentDueDay) ||
                other.rentDueDay == rentDueDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customerId,
    customerName,
    vehicleDetails,
    amount,
    totalAmount,
    originalLoanAmount,
    serviceName,
    lastPaymentAmount,
    lastPaymentDateStr,
    dueDate,
    status,
    avatarUrl,
    isRent,
    rentDueDay,
  );

  /// Create a copy of ActiveInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveInstallmentImplCopyWith<_$ActiveInstallmentImpl> get copyWith =>
      __$$ActiveInstallmentImplCopyWithImpl<_$ActiveInstallmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveInstallmentImplToJson(this);
  }
}

abstract class _ActiveInstallment implements ActiveInstallment {
  const factory _ActiveInstallment({
    required final String id,
    required final String customerId,
    required final String customerName,
    required final String vehicleDetails,
    required final double amount,
    required final double totalAmount,
    final double originalLoanAmount,
    final String serviceName,
    final double lastPaymentAmount,
    final String lastPaymentDateStr,
    required final String dueDate,
    required final String status,
    required final String avatarUrl,
    final bool isRent,
    final int? rentDueDay,
  }) = _$ActiveInstallmentImpl;

  factory _ActiveInstallment.fromJson(Map<String, dynamic> json) =
      _$ActiveInstallmentImpl.fromJson;

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String get vehicleDetails;
  @override
  double get amount;
  @override
  double get totalAmount;
  @override
  double get originalLoanAmount;
  @override
  String get serviceName;
  @override
  double get lastPaymentAmount;
  @override
  String get lastPaymentDateStr;
  @override
  String get dueDate;
  @override
  String get status;
  @override
  String get avatarUrl;
  @override
  bool get isRent;
  @override
  int? get rentDueDay;

  /// Create a copy of ActiveInstallment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveInstallmentImplCopyWith<_$ActiveInstallmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
