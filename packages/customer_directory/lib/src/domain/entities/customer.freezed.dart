// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServiceActivity _$ServiceActivityFromJson(Map<String, dynamic> json) {
  return _ServiceActivity.fromJson(json);
}

/// @nodoc
mixin _$ServiceActivity {
  String get id => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  String get fixes => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get amountPaid => throw _privateConstructorUsedError;
  String get equipmentsUsed => throw _privateConstructorUsedError;
  String get guaranteeDuration => throw _privateConstructorUsedError;
  String get remarks => throw _privateConstructorUsedError;
  DateTime get serviceDate => throw _privateConstructorUsedError;

  /// Serializes this ServiceActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceActivityCopyWith<ServiceActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceActivityCopyWith<$Res> {
  factory $ServiceActivityCopyWith(
    ServiceActivity value,
    $Res Function(ServiceActivity) then,
  ) = _$ServiceActivityCopyWithImpl<$Res, ServiceActivity>;
  @useResult
  $Res call({
    String id,
    String serviceType,
    String fixes,
    double totalAmount,
    double amountPaid,
    String equipmentsUsed,
    String guaranteeDuration,
    String remarks,
    DateTime serviceDate,
  });
}

/// @nodoc
class _$ServiceActivityCopyWithImpl<$Res, $Val extends ServiceActivity>
    implements $ServiceActivityCopyWith<$Res> {
  _$ServiceActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceType = null,
    Object? fixes = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? equipmentsUsed = null,
    Object? guaranteeDuration = null,
    Object? remarks = null,
    Object? serviceDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as String,
            fixes: null == fixes
                ? _value.fixes
                : fixes // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            amountPaid: null == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as double,
            equipmentsUsed: null == equipmentsUsed
                ? _value.equipmentsUsed
                : equipmentsUsed // ignore: cast_nullable_to_non_nullable
                      as String,
            guaranteeDuration: null == guaranteeDuration
                ? _value.guaranteeDuration
                : guaranteeDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            remarks: null == remarks
                ? _value.remarks
                : remarks // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceDate: null == serviceDate
                ? _value.serviceDate
                : serviceDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceActivityImplCopyWith<$Res>
    implements $ServiceActivityCopyWith<$Res> {
  factory _$$ServiceActivityImplCopyWith(
    _$ServiceActivityImpl value,
    $Res Function(_$ServiceActivityImpl) then,
  ) = __$$ServiceActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String serviceType,
    String fixes,
    double totalAmount,
    double amountPaid,
    String equipmentsUsed,
    String guaranteeDuration,
    String remarks,
    DateTime serviceDate,
  });
}

/// @nodoc
class __$$ServiceActivityImplCopyWithImpl<$Res>
    extends _$ServiceActivityCopyWithImpl<$Res, _$ServiceActivityImpl>
    implements _$$ServiceActivityImplCopyWith<$Res> {
  __$$ServiceActivityImplCopyWithImpl(
    _$ServiceActivityImpl _value,
    $Res Function(_$ServiceActivityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceType = null,
    Object? fixes = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? equipmentsUsed = null,
    Object? guaranteeDuration = null,
    Object? remarks = null,
    Object? serviceDate = null,
  }) {
    return _then(
      _$ServiceActivityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as String,
        fixes: null == fixes
            ? _value.fixes
            : fixes // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        amountPaid: null == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as double,
        equipmentsUsed: null == equipmentsUsed
            ? _value.equipmentsUsed
            : equipmentsUsed // ignore: cast_nullable_to_non_nullable
                  as String,
        guaranteeDuration: null == guaranteeDuration
            ? _value.guaranteeDuration
            : guaranteeDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        remarks: null == remarks
            ? _value.remarks
            : remarks // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceDate: null == serviceDate
            ? _value.serviceDate
            : serviceDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceActivityImpl extends _ServiceActivity {
  const _$ServiceActivityImpl({
    required this.id,
    required this.serviceType,
    required this.fixes,
    required this.totalAmount,
    required this.amountPaid,
    required this.equipmentsUsed,
    this.guaranteeDuration = '',
    this.remarks = '',
    required this.serviceDate,
  }) : super._();

  factory _$ServiceActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String serviceType;
  @override
  final String fixes;
  @override
  final double totalAmount;
  @override
  final double amountPaid;
  @override
  final String equipmentsUsed;
  @override
  @JsonKey()
  final String guaranteeDuration;
  @override
  @JsonKey()
  final String remarks;
  @override
  final DateTime serviceDate;

  @override
  String toString() {
    return 'ServiceActivity(id: $id, serviceType: $serviceType, fixes: $fixes, totalAmount: $totalAmount, amountPaid: $amountPaid, equipmentsUsed: $equipmentsUsed, guaranteeDuration: $guaranteeDuration, remarks: $remarks, serviceDate: $serviceDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.fixes, fixes) || other.fixes == fixes) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.equipmentsUsed, equipmentsUsed) ||
                other.equipmentsUsed == equipmentsUsed) &&
            (identical(other.guaranteeDuration, guaranteeDuration) ||
                other.guaranteeDuration == guaranteeDuration) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.serviceDate, serviceDate) ||
                other.serviceDate == serviceDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    serviceType,
    fixes,
    totalAmount,
    amountPaid,
    equipmentsUsed,
    guaranteeDuration,
    remarks,
    serviceDate,
  );

  /// Create a copy of ServiceActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceActivityImplCopyWith<_$ServiceActivityImpl> get copyWith =>
      __$$ServiceActivityImplCopyWithImpl<_$ServiceActivityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceActivityImplToJson(this);
  }
}

abstract class _ServiceActivity extends ServiceActivity {
  const factory _ServiceActivity({
    required final String id,
    required final String serviceType,
    required final String fixes,
    required final double totalAmount,
    required final double amountPaid,
    required final String equipmentsUsed,
    final String guaranteeDuration,
    final String remarks,
    required final DateTime serviceDate,
  }) = _$ServiceActivityImpl;
  const _ServiceActivity._() : super._();

  factory _ServiceActivity.fromJson(Map<String, dynamic> json) =
      _$ServiceActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get serviceType;
  @override
  String get fixes;
  @override
  double get totalAmount;
  @override
  double get amountPaid;
  @override
  String get equipmentsUsed;
  @override
  String get guaranteeDuration;
  @override
  String get remarks;
  @override
  DateTime get serviceDate;

  /// Create a copy of ServiceActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceActivityImplCopyWith<_$ServiceActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get locality => throw _privateConstructorUsedError;
  String get roType => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get customerType => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get deviceInstalledOn => throw _privateConstructorUsedError;
  String get deviceLastService => throw _privateConstructorUsedError;
  double get deviceFilterHealth => throw _privateConstructorUsedError;
  int get totalVisits => throw _privateConstructorUsedError;
  bool get activeAmc => throw _privateConstructorUsedError;
  String get customerValue => throw _privateConstructorUsedError;
  int get openTickets => throw _privateConstructorUsedError;
  List<ServiceActivity> get serviceHistory =>
      throw _privateConstructorUsedError; // Soft delete support
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get deletedAt => throw _privateConstructorUsedError;
  String? get deletedBy => throw _privateConstructorUsedError;

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call({
    String id,
    String name,
    String customerId,
    String number,
    String email,
    String address,
    String locality,
    String roType,
    String note,
    String role,
    String status,
    String customerType,
    String avatarUrl,
    String deviceName,
    String deviceInstalledOn,
    String deviceLastService,
    double deviceFilterHealth,
    int totalVisits,
    bool activeAmc,
    String customerValue,
    int openTickets,
    List<ServiceActivity> serviceHistory,
    bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  });
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? customerId = null,
    Object? number = null,
    Object? email = null,
    Object? address = null,
    Object? locality = null,
    Object? roType = null,
    Object? note = null,
    Object? role = null,
    Object? status = null,
    Object? customerType = null,
    Object? avatarUrl = null,
    Object? deviceName = null,
    Object? deviceInstalledOn = null,
    Object? deviceLastService = null,
    Object? deviceFilterHealth = null,
    Object? totalVisits = null,
    Object? activeAmc = null,
    Object? customerValue = null,
    Object? openTickets = null,
    Object? serviceHistory = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            locality: null == locality
                ? _value.locality
                : locality // ignore: cast_nullable_to_non_nullable
                      as String,
            roType: null == roType
                ? _value.roType
                : roType // ignore: cast_nullable_to_non_nullable
                      as String,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            customerType: null == customerType
                ? _value.customerType
                : customerType // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceName: null == deviceName
                ? _value.deviceName
                : deviceName // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceInstalledOn: null == deviceInstalledOn
                ? _value.deviceInstalledOn
                : deviceInstalledOn // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceLastService: null == deviceLastService
                ? _value.deviceLastService
                : deviceLastService // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceFilterHealth: null == deviceFilterHealth
                ? _value.deviceFilterHealth
                : deviceFilterHealth // ignore: cast_nullable_to_non_nullable
                      as double,
            totalVisits: null == totalVisits
                ? _value.totalVisits
                : totalVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            activeAmc: null == activeAmc
                ? _value.activeAmc
                : activeAmc // ignore: cast_nullable_to_non_nullable
                      as bool,
            customerValue: null == customerValue
                ? _value.customerValue
                : customerValue // ignore: cast_nullable_to_non_nullable
                      as String,
            openTickets: null == openTickets
                ? _value.openTickets
                : openTickets // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceHistory: null == serviceHistory
                ? _value.serviceHistory
                : serviceHistory // ignore: cast_nullable_to_non_nullable
                      as List<ServiceActivity>,
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
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
    _$CustomerImpl value,
    $Res Function(_$CustomerImpl) then,
  ) = __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String customerId,
    String number,
    String email,
    String address,
    String locality,
    String roType,
    String note,
    String role,
    String status,
    String customerType,
    String avatarUrl,
    String deviceName,
    String deviceInstalledOn,
    String deviceLastService,
    double deviceFilterHealth,
    int totalVisits,
    bool activeAmc,
    String customerValue,
    int openTickets,
    List<ServiceActivity> serviceHistory,
    bool isDeleted,
    String? deletedAt,
    String? deletedBy,
  });
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
    _$CustomerImpl _value,
    $Res Function(_$CustomerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? customerId = null,
    Object? number = null,
    Object? email = null,
    Object? address = null,
    Object? locality = null,
    Object? roType = null,
    Object? note = null,
    Object? role = null,
    Object? status = null,
    Object? customerType = null,
    Object? avatarUrl = null,
    Object? deviceName = null,
    Object? deviceInstalledOn = null,
    Object? deviceLastService = null,
    Object? deviceFilterHealth = null,
    Object? totalVisits = null,
    Object? activeAmc = null,
    Object? customerValue = null,
    Object? openTickets = null,
    Object? serviceHistory = null,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
  }) {
    return _then(
      _$CustomerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        locality: null == locality
            ? _value.locality
            : locality // ignore: cast_nullable_to_non_nullable
                  as String,
        roType: null == roType
            ? _value.roType
            : roType // ignore: cast_nullable_to_non_nullable
                  as String,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        customerType: null == customerType
            ? _value.customerType
            : customerType // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceName: null == deviceName
            ? _value.deviceName
            : deviceName // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceInstalledOn: null == deviceInstalledOn
            ? _value.deviceInstalledOn
            : deviceInstalledOn // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceLastService: null == deviceLastService
            ? _value.deviceLastService
            : deviceLastService // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceFilterHealth: null == deviceFilterHealth
            ? _value.deviceFilterHealth
            : deviceFilterHealth // ignore: cast_nullable_to_non_nullable
                  as double,
        totalVisits: null == totalVisits
            ? _value.totalVisits
            : totalVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        activeAmc: null == activeAmc
            ? _value.activeAmc
            : activeAmc // ignore: cast_nullable_to_non_nullable
                  as bool,
        customerValue: null == customerValue
            ? _value.customerValue
            : customerValue // ignore: cast_nullable_to_non_nullable
                  as String,
        openTickets: null == openTickets
            ? _value.openTickets
            : openTickets // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceHistory: null == serviceHistory
            ? _value._serviceHistory
            : serviceHistory // ignore: cast_nullable_to_non_nullable
                  as List<ServiceActivity>,
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
@JsonSerializable()
class _$CustomerImpl extends _Customer {
  const _$CustomerImpl({
    required this.id,
    required this.name,
    required this.customerId,
    required this.number,
    this.email = '',
    this.address = '',
    this.locality = '',
    this.roType = '',
    this.note = '',
    this.role = '',
    this.status = 'active',
    this.customerType = '',
    this.avatarUrl = '',
    this.deviceName = '',
    this.deviceInstalledOn = '',
    this.deviceLastService = '',
    this.deviceFilterHealth = 1.0,
    this.totalVisits = 0,
    this.activeAmc = false,
    this.customerValue = '',
    this.openTickets = 0,
    final List<ServiceActivity> serviceHistory = const [],
    this.isDeleted = false,
    this.deletedAt,
    this.deletedBy,
  }) : _serviceHistory = serviceHistory,
       super._();

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String customerId;
  @override
  final String number;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String locality;
  @override
  @JsonKey()
  final String roType;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String customerType;
  @override
  @JsonKey()
  final String avatarUrl;
  @override
  @JsonKey()
  final String deviceName;
  @override
  @JsonKey()
  final String deviceInstalledOn;
  @override
  @JsonKey()
  final String deviceLastService;
  @override
  @JsonKey()
  final double deviceFilterHealth;
  @override
  @JsonKey()
  final int totalVisits;
  @override
  @JsonKey()
  final bool activeAmc;
  @override
  @JsonKey()
  final String customerValue;
  @override
  @JsonKey()
  final int openTickets;
  final List<ServiceActivity> _serviceHistory;
  @override
  @JsonKey()
  List<ServiceActivity> get serviceHistory {
    if (_serviceHistory is EqualUnmodifiableListView) return _serviceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceHistory);
  }

  // Soft delete support
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String? deletedAt;
  @override
  final String? deletedBy;

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, customerId: $customerId, number: $number, email: $email, address: $address, locality: $locality, roType: $roType, note: $note, role: $role, status: $status, customerType: $customerType, avatarUrl: $avatarUrl, deviceName: $deviceName, deviceInstalledOn: $deviceInstalledOn, deviceLastService: $deviceLastService, deviceFilterHealth: $deviceFilterHealth, totalVisits: $totalVisits, activeAmc: $activeAmc, customerValue: $customerValue, openTickets: $openTickets, serviceHistory: $serviceHistory, isDeleted: $isDeleted, deletedAt: $deletedAt, deletedBy: $deletedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.roType, roType) || other.roType == roType) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.customerType, customerType) ||
                other.customerType == customerType) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceInstalledOn, deviceInstalledOn) ||
                other.deviceInstalledOn == deviceInstalledOn) &&
            (identical(other.deviceLastService, deviceLastService) ||
                other.deviceLastService == deviceLastService) &&
            (identical(other.deviceFilterHealth, deviceFilterHealth) ||
                other.deviceFilterHealth == deviceFilterHealth) &&
            (identical(other.totalVisits, totalVisits) ||
                other.totalVisits == totalVisits) &&
            (identical(other.activeAmc, activeAmc) ||
                other.activeAmc == activeAmc) &&
            (identical(other.customerValue, customerValue) ||
                other.customerValue == customerValue) &&
            (identical(other.openTickets, openTickets) ||
                other.openTickets == openTickets) &&
            const DeepCollectionEquality().equals(
              other._serviceHistory,
              _serviceHistory,
            ) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    customerId,
    number,
    email,
    address,
    locality,
    roType,
    note,
    role,
    status,
    customerType,
    avatarUrl,
    deviceName,
    deviceInstalledOn,
    deviceLastService,
    deviceFilterHealth,
    totalVisits,
    activeAmc,
    customerValue,
    openTickets,
    const DeepCollectionEquality().hash(_serviceHistory),
    isDeleted,
    deletedAt,
    deletedBy,
  ]);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(this);
  }
}

abstract class _Customer extends Customer {
  const factory _Customer({
    required final String id,
    required final String name,
    required final String customerId,
    required final String number,
    final String email,
    final String address,
    final String locality,
    final String roType,
    final String note,
    final String role,
    final String status,
    final String customerType,
    final String avatarUrl,
    final String deviceName,
    final String deviceInstalledOn,
    final String deviceLastService,
    final double deviceFilterHealth,
    final int totalVisits,
    final bool activeAmc,
    final String customerValue,
    final int openTickets,
    final List<ServiceActivity> serviceHistory,
    final bool isDeleted,
    final String? deletedAt,
    final String? deletedBy,
  }) = _$CustomerImpl;
  const _Customer._() : super._();

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get customerId;
  @override
  String get number;
  @override
  String get email;
  @override
  String get address;
  @override
  String get locality;
  @override
  String get roType;
  @override
  String get note;
  @override
  String get role;
  @override
  String get status;
  @override
  String get customerType;
  @override
  String get avatarUrl;
  @override
  String get deviceName;
  @override
  String get deviceInstalledOn;
  @override
  String get deviceLastService;
  @override
  double get deviceFilterHealth;
  @override
  int get totalVisits;
  @override
  bool get activeAmc;
  @override
  String get customerValue;
  @override
  int get openTickets;
  @override
  List<ServiceActivity> get serviceHistory; // Soft delete support
  @override
  bool get isDeleted;
  @override
  String? get deletedAt;
  @override
  String? get deletedBy;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
