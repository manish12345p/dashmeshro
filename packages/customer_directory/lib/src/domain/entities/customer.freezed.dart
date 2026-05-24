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
  String get activityType =>
      throw _privateConstructorUsedError; // 'complaint', 'maintenance', 'receipt', 'installation'
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get technicianName => throw _privateConstructorUsedError;
  String get dateText => throw _privateConstructorUsedError;
  String get statusBadge => throw _privateConstructorUsedError;

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
    String activityType,
    String title,
    String description,
    String technicianName,
    String dateText,
    String statusBadge,
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
    Object? activityType = null,
    Object? title = null,
    Object? description = null,
    Object? technicianName = null,
    Object? dateText = null,
    Object? statusBadge = null,
  }) {
    return _then(
      _value.copyWith(
            activityType: null == activityType
                ? _value.activityType
                : activityType // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            technicianName: null == technicianName
                ? _value.technicianName
                : technicianName // ignore: cast_nullable_to_non_nullable
                      as String,
            dateText: null == dateText
                ? _value.dateText
                : dateText // ignore: cast_nullable_to_non_nullable
                      as String,
            statusBadge: null == statusBadge
                ? _value.statusBadge
                : statusBadge // ignore: cast_nullable_to_non_nullable
                      as String,
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
    String activityType,
    String title,
    String description,
    String technicianName,
    String dateText,
    String statusBadge,
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
    Object? activityType = null,
    Object? title = null,
    Object? description = null,
    Object? technicianName = null,
    Object? dateText = null,
    Object? statusBadge = null,
  }) {
    return _then(
      _$ServiceActivityImpl(
        activityType: null == activityType
            ? _value.activityType
            : activityType // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        technicianName: null == technicianName
            ? _value.technicianName
            : technicianName // ignore: cast_nullable_to_non_nullable
                  as String,
        dateText: null == dateText
            ? _value.dateText
            : dateText // ignore: cast_nullable_to_non_nullable
                  as String,
        statusBadge: null == statusBadge
            ? _value.statusBadge
            : statusBadge // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceActivityImpl extends _ServiceActivity {
  const _$ServiceActivityImpl({
    required this.activityType,
    required this.title,
    required this.description,
    required this.technicianName,
    required this.dateText,
    required this.statusBadge,
  }) : super._();

  factory _$ServiceActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceActivityImplFromJson(json);

  @override
  final String activityType;
  // 'complaint', 'maintenance', 'receipt', 'installation'
  @override
  final String title;
  @override
  final String description;
  @override
  final String technicianName;
  @override
  final String dateText;
  @override
  final String statusBadge;

  @override
  String toString() {
    return 'ServiceActivity(activityType: $activityType, title: $title, description: $description, technicianName: $technicianName, dateText: $dateText, statusBadge: $statusBadge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceActivityImpl &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.technicianName, technicianName) ||
                other.technicianName == technicianName) &&
            (identical(other.dateText, dateText) ||
                other.dateText == dateText) &&
            (identical(other.statusBadge, statusBadge) ||
                other.statusBadge == statusBadge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    activityType,
    title,
    description,
    technicianName,
    dateText,
    statusBadge,
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
    required final String activityType,
    required final String title,
    required final String description,
    required final String technicianName,
    required final String dateText,
    required final String statusBadge,
  }) = _$ServiceActivityImpl;
  const _ServiceActivity._() : super._();

  factory _ServiceActivity.fromJson(Map<String, dynamic> json) =
      _$ServiceActivityImpl.fromJson;

  @override
  String get activityType; // 'complaint', 'maintenance', 'receipt', 'installation'
  @override
  String get title;
  @override
  String get description;
  @override
  String get technicianName;
  @override
  String get dateText;
  @override
  String get statusBadge;

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
  String get status =>
      throw _privateConstructorUsedError; // 'active', 'inactive'
  String get customerType =>
      throw _privateConstructorUsedError; // 'Active AMC', 'Rental Customer', 'Recent Purchase', 'Open Complaint'
  String get avatarUrl => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get deviceInstalledOn => throw _privateConstructorUsedError;
  String get deviceLastService => throw _privateConstructorUsedError;
  double get deviceFilterHealth =>
      throw _privateConstructorUsedError; // between 0.0 and 1.0
  int get totalVisits => throw _privateConstructorUsedError;
  bool get activeAmc => throw _privateConstructorUsedError;
  String get customerValue =>
      throw _privateConstructorUsedError; // e.g. '18.5k'
  int get openTickets => throw _privateConstructorUsedError;
  List<ServiceActivity> get serviceHistory =>
      throw _privateConstructorUsedError;

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
    required this.email,
    required this.address,
    required this.locality,
    required this.roType,
    required this.note,
    required this.role,
    required this.status,
    required this.customerType,
    required this.avatarUrl,
    required this.deviceName,
    required this.deviceInstalledOn,
    required this.deviceLastService,
    required this.deviceFilterHealth,
    required this.totalVisits,
    required this.activeAmc,
    required this.customerValue,
    required this.openTickets,
    required final List<ServiceActivity> serviceHistory,
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
  final String email;
  @override
  final String address;
  @override
  final String locality;
  @override
  final String roType;
  @override
  final String note;
  @override
  final String role;
  @override
  final String status;
  // 'active', 'inactive'
  @override
  final String customerType;
  // 'Active AMC', 'Rental Customer', 'Recent Purchase', 'Open Complaint'
  @override
  final String avatarUrl;
  @override
  final String deviceName;
  @override
  final String deviceInstalledOn;
  @override
  final String deviceLastService;
  @override
  final double deviceFilterHealth;
  // between 0.0 and 1.0
  @override
  final int totalVisits;
  @override
  final bool activeAmc;
  @override
  final String customerValue;
  // e.g. '18.5k'
  @override
  final int openTickets;
  final List<ServiceActivity> _serviceHistory;
  @override
  List<ServiceActivity> get serviceHistory {
    if (_serviceHistory is EqualUnmodifiableListView) return _serviceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceHistory);
  }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, customerId: $customerId, number: $number, email: $email, address: $address, locality: $locality, roType: $roType, note: $note, role: $role, status: $status, customerType: $customerType, avatarUrl: $avatarUrl, deviceName: $deviceName, deviceInstalledOn: $deviceInstalledOn, deviceLastService: $deviceLastService, deviceFilterHealth: $deviceFilterHealth, totalVisits: $totalVisits, activeAmc: $activeAmc, customerValue: $customerValue, openTickets: $openTickets, serviceHistory: $serviceHistory)';
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
            ));
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
    required final String email,
    required final String address,
    required final String locality,
    required final String roType,
    required final String note,
    required final String role,
    required final String status,
    required final String customerType,
    required final String avatarUrl,
    required final String deviceName,
    required final String deviceInstalledOn,
    required final String deviceLastService,
    required final double deviceFilterHealth,
    required final int totalVisits,
    required final bool activeAmc,
    required final String customerValue,
    required final int openTickets,
    required final List<ServiceActivity> serviceHistory,
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
  String get status; // 'active', 'inactive'
  @override
  String get customerType; // 'Active AMC', 'Rental Customer', 'Recent Purchase', 'Open Complaint'
  @override
  String get avatarUrl;
  @override
  String get deviceName;
  @override
  String get deviceInstalledOn;
  @override
  String get deviceLastService;
  @override
  double get deviceFilterHealth; // between 0.0 and 1.0
  @override
  int get totalVisits;
  @override
  bool get activeAmc;
  @override
  String get customerValue; // e.g. '18.5k'
  @override
  int get openTickets;
  @override
  List<ServiceActivity> get serviceHistory;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
