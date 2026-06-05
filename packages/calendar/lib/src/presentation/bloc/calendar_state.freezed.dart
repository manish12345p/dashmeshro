// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalendarState {
  int get currentYear => throw _privateConstructorUsedError;
  int get currentMonth => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  String get selectedCategory => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<ScheduleItem> get currentMonthSchedules =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
    CalendarState value,
    $Res Function(CalendarState) then,
  ) = _$CalendarStateCopyWithImpl<$Res, CalendarState>;
  @useResult
  $Res call({
    int currentYear,
    int currentMonth,
    DateTime selectedDate,
    String selectedCategory,
    String searchQuery,
    bool isLoading,
    List<ScheduleItem> currentMonthSchedules,
    String? errorMessage,
  });
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res, $Val extends CalendarState>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentYear = null,
    Object? currentMonth = null,
    Object? selectedDate = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
    Object? isLoading = null,
    Object? currentMonthSchedules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentYear: null == currentYear
                ? _value.currentYear
                : currentYear // ignore: cast_nullable_to_non_nullable
                      as int,
            currentMonth: null == currentMonth
                ? _value.currentMonth
                : currentMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedDate: null == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            selectedCategory: null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentMonthSchedules: null == currentMonthSchedules
                ? _value.currentMonthSchedules
                : currentMonthSchedules // ignore: cast_nullable_to_non_nullable
                      as List<ScheduleItem>,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalendarStateImplCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$$CalendarStateImplCopyWith(
    _$CalendarStateImpl value,
    $Res Function(_$CalendarStateImpl) then,
  ) = __$$CalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentYear,
    int currentMonth,
    DateTime selectedDate,
    String selectedCategory,
    String searchQuery,
    bool isLoading,
    List<ScheduleItem> currentMonthSchedules,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$CalendarStateImpl>
    implements _$$CalendarStateImplCopyWith<$Res> {
  __$$CalendarStateImplCopyWithImpl(
    _$CalendarStateImpl _value,
    $Res Function(_$CalendarStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentYear = null,
    Object? currentMonth = null,
    Object? selectedDate = null,
    Object? selectedCategory = null,
    Object? searchQuery = null,
    Object? isLoading = null,
    Object? currentMonthSchedules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CalendarStateImpl(
        currentYear: null == currentYear
            ? _value.currentYear
            : currentYear // ignore: cast_nullable_to_non_nullable
                  as int,
        currentMonth: null == currentMonth
            ? _value.currentMonth
            : currentMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedDate: null == selectedDate
            ? _value.selectedDate
            : selectedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        selectedCategory: null == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentMonthSchedules: null == currentMonthSchedules
            ? _value._currentMonthSchedules
            : currentMonthSchedules // ignore: cast_nullable_to_non_nullable
                  as List<ScheduleItem>,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CalendarStateImpl implements _CalendarState {
  const _$CalendarStateImpl({
    required this.currentYear,
    required this.currentMonth,
    required this.selectedDate,
    required this.selectedCategory,
    required this.searchQuery,
    this.isLoading = true,
    final List<ScheduleItem> currentMonthSchedules = const [],
    this.errorMessage,
  }) : _currentMonthSchedules = currentMonthSchedules;

  @override
  final int currentYear;
  @override
  final int currentMonth;
  @override
  final DateTime selectedDate;
  @override
  final String selectedCategory;
  @override
  final String searchQuery;
  @override
  @JsonKey()
  final bool isLoading;
  final List<ScheduleItem> _currentMonthSchedules;
  @override
  @JsonKey()
  List<ScheduleItem> get currentMonthSchedules {
    if (_currentMonthSchedules is EqualUnmodifiableListView)
      return _currentMonthSchedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentMonthSchedules);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CalendarState(currentYear: $currentYear, currentMonth: $currentMonth, selectedDate: $selectedDate, selectedCategory: $selectedCategory, searchQuery: $searchQuery, isLoading: $isLoading, currentMonthSchedules: $currentMonthSchedules, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarStateImpl &&
            (identical(other.currentYear, currentYear) ||
                other.currentYear == currentYear) &&
            (identical(other.currentMonth, currentMonth) ||
                other.currentMonth == currentMonth) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._currentMonthSchedules,
              _currentMonthSchedules,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentYear,
    currentMonth,
    selectedDate,
    selectedCategory,
    searchQuery,
    isLoading,
    const DeepCollectionEquality().hash(_currentMonthSchedules),
    errorMessage,
  );

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      __$$CalendarStateImplCopyWithImpl<_$CalendarStateImpl>(this, _$identity);
}

abstract class _CalendarState implements CalendarState {
  const factory _CalendarState({
    required final int currentYear,
    required final int currentMonth,
    required final DateTime selectedDate,
    required final String selectedCategory,
    required final String searchQuery,
    final bool isLoading,
    final List<ScheduleItem> currentMonthSchedules,
    final String? errorMessage,
  }) = _$CalendarStateImpl;

  @override
  int get currentYear;
  @override
  int get currentMonth;
  @override
  DateTime get selectedDate;
  @override
  String get selectedCategory;
  @override
  String get searchQuery;
  @override
  bool get isLoading;
  @override
  List<ScheduleItem> get currentMonthSchedules;
  @override
  String? get errorMessage;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
