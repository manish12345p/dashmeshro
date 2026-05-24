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

/// @nodoc
mixin _$ScheduleItem {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;

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
  $Res call({String title, String subtitle, String time, bool isUrgent});
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
  $Res call({String title, String subtitle, String time, bool isUrgent});
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
      ),
    );
  }
}

/// @nodoc

class _$ScheduleItemImpl extends _ScheduleItem {
  const _$ScheduleItemImpl({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isUrgent = false,
  }) : super._();

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String time;
  @override
  @JsonKey()
  final bool isUrgent;

  @override
  String toString() {
    return 'ScheduleItem(title: $title, subtitle: $subtitle, time: $time, isUrgent: $isUrgent)';
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
                other.isUrgent == isUrgent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, subtitle, time, isUrgent);

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      __$$ScheduleItemImplCopyWithImpl<_$ScheduleItemImpl>(this, _$identity);
}

abstract class _ScheduleItem extends ScheduleItem {
  const factory _ScheduleItem({
    required final String title,
    required final String subtitle,
    required final String time,
    final bool isUrgent,
  }) = _$ScheduleItemImpl;
  const _ScheduleItem._() : super._();

  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get time;
  @override
  bool get isUrgent;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ComplaintItem {
  String get customerName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get issueType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

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

class _$ComplaintItemImpl extends _ComplaintItem {
  const _$ComplaintItemImpl({
    required this.customerName,
    required this.customerId,
    required this.issueType,
    required this.status,
  }) : super._();

  @override
  final String customerName;
  @override
  final String customerId;
  @override
  final String issueType;
  @override
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
}

abstract class _ComplaintItem extends ComplaintItem {
  const factory _ComplaintItem({
    required final String customerName,
    required final String customerId,
    required final String issueType,
    required final String status,
  }) = _$ComplaintItemImpl;
  const _ComplaintItem._() : super._();

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

/// @nodoc
mixin _$AmcProgress {
  String get companyName => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String get statusText => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;

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

class _$AmcProgressImpl extends _AmcProgress {
  const _$AmcProgressImpl({
    required this.companyName,
    required this.progress,
    required this.statusText,
    this.isUrgent = false,
  }) : super._();

  @override
  final String companyName;
  @override
  final double progress;
  @override
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
}

abstract class _AmcProgress extends AmcProgress {
  const factory _AmcProgress({
    required final String companyName,
    required final double progress,
    required final String statusText,
    final bool isUrgent,
  }) = _$AmcProgressImpl;
  const _AmcProgress._() : super._();

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

/// @nodoc
mixin _$HomeData {
  int get newSells => throw _privateConstructorUsedError;
  int get activeRentals => throw _privateConstructorUsedError;
  int get activeAmcs => throw _privateConstructorUsedError;
  int get resolutionRatePercent => throw _privateConstructorUsedError;
  int get pendingComplaintsCount => throw _privateConstructorUsedError;
  List<ScheduleItem> get todaySchedules => throw _privateConstructorUsedError;
  List<ComplaintItem> get pendingComplaints =>
      throw _privateConstructorUsedError;
  List<AmcProgress> get amcProgresses => throw _privateConstructorUsedError;
  int get todaySellsSummary => throw _privateConstructorUsedError;
  int get weekSellsSummary => throw _privateConstructorUsedError;
  String get projectedGrowth => throw _privateConstructorUsedError;

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
    int resolutionRatePercent,
    int pendingComplaintsCount,
    List<ScheduleItem> todaySchedules,
    List<ComplaintItem> pendingComplaints,
    List<AmcProgress> amcProgresses,
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
    Object? resolutionRatePercent = null,
    Object? pendingComplaintsCount = null,
    Object? todaySchedules = null,
    Object? pendingComplaints = null,
    Object? amcProgresses = null,
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
    int resolutionRatePercent,
    int pendingComplaintsCount,
    List<ScheduleItem> todaySchedules,
    List<ComplaintItem> pendingComplaints,
    List<AmcProgress> amcProgresses,
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
    Object? resolutionRatePercent = null,
    Object? pendingComplaintsCount = null,
    Object? todaySchedules = null,
    Object? pendingComplaints = null,
    Object? amcProgresses = null,
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

class _$HomeDataImpl extends _HomeData {
  const _$HomeDataImpl({
    required this.newSells,
    required this.activeRentals,
    required this.activeAmcs,
    required this.resolutionRatePercent,
    required this.pendingComplaintsCount,
    required final List<ScheduleItem> todaySchedules,
    required final List<ComplaintItem> pendingComplaints,
    required final List<AmcProgress> amcProgresses,
    required this.todaySellsSummary,
    required this.weekSellsSummary,
    required this.projectedGrowth,
  }) : _todaySchedules = todaySchedules,
       _pendingComplaints = pendingComplaints,
       _amcProgresses = amcProgresses,
       super._();

  @override
  final int newSells;
  @override
  final int activeRentals;
  @override
  final int activeAmcs;
  @override
  final int resolutionRatePercent;
  @override
  final int pendingComplaintsCount;
  final List<ScheduleItem> _todaySchedules;
  @override
  List<ScheduleItem> get todaySchedules {
    if (_todaySchedules is EqualUnmodifiableListView) return _todaySchedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todaySchedules);
  }

  final List<ComplaintItem> _pendingComplaints;
  @override
  List<ComplaintItem> get pendingComplaints {
    if (_pendingComplaints is EqualUnmodifiableListView)
      return _pendingComplaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingComplaints);
  }

  final List<AmcProgress> _amcProgresses;
  @override
  List<AmcProgress> get amcProgresses {
    if (_amcProgresses is EqualUnmodifiableListView) return _amcProgresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amcProgresses);
  }

  @override
  final int todaySellsSummary;
  @override
  final int weekSellsSummary;
  @override
  final String projectedGrowth;

  @override
  String toString() {
    return 'HomeData(newSells: $newSells, activeRentals: $activeRentals, activeAmcs: $activeAmcs, resolutionRatePercent: $resolutionRatePercent, pendingComplaintsCount: $pendingComplaintsCount, todaySchedules: $todaySchedules, pendingComplaints: $pendingComplaints, amcProgresses: $amcProgresses, todaySellsSummary: $todaySellsSummary, weekSellsSummary: $weekSellsSummary, projectedGrowth: $projectedGrowth)';
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
            (identical(other.todaySellsSummary, todaySellsSummary) ||
                other.todaySellsSummary == todaySellsSummary) &&
            (identical(other.weekSellsSummary, weekSellsSummary) ||
                other.weekSellsSummary == weekSellsSummary) &&
            (identical(other.projectedGrowth, projectedGrowth) ||
                other.projectedGrowth == projectedGrowth));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    newSells,
    activeRentals,
    activeAmcs,
    resolutionRatePercent,
    pendingComplaintsCount,
    const DeepCollectionEquality().hash(_todaySchedules),
    const DeepCollectionEquality().hash(_pendingComplaints),
    const DeepCollectionEquality().hash(_amcProgresses),
    todaySellsSummary,
    weekSellsSummary,
    projectedGrowth,
  );

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);
}

abstract class _HomeData extends HomeData {
  const factory _HomeData({
    required final int newSells,
    required final int activeRentals,
    required final int activeAmcs,
    required final int resolutionRatePercent,
    required final int pendingComplaintsCount,
    required final List<ScheduleItem> todaySchedules,
    required final List<ComplaintItem> pendingComplaints,
    required final List<AmcProgress> amcProgresses,
    required final int todaySellsSummary,
    required final int weekSellsSummary,
    required final String projectedGrowth,
  }) = _$HomeDataImpl;
  const _HomeData._() : super._();

  @override
  int get newSells;
  @override
  int get activeRentals;
  @override
  int get activeAmcs;
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
