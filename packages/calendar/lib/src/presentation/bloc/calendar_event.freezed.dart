// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CalendarEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loadMonth,
    required TResult Function(DateTime date) selectDate,
    required TResult Function(String category) selectCategory,
    required TResult Function(String query) searchQueryChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loadMonth,
    TResult? Function(DateTime date)? selectDate,
    TResult? Function(String category)? selectCategory,
    TResult? Function(String query)? searchQueryChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loadMonth,
    TResult Function(DateTime date)? selectDate,
    TResult Function(String category)? selectCategory,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMonth value) loadMonth,
    required TResult Function(SelectDate value) selectDate,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMonth value)? loadMonth,
    TResult? Function(SelectDate value)? selectDate,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMonth value)? loadMonth,
    TResult Function(SelectDate value)? selectDate,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
    CalendarEvent value,
    $Res Function(CalendarEvent) then,
  ) = _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMonthImplCopyWith<$Res> {
  factory _$$LoadMonthImplCopyWith(
    _$LoadMonthImpl value,
    $Res Function(_$LoadMonthImpl) then,
  ) = __$$LoadMonthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class __$$LoadMonthImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$LoadMonthImpl>
    implements _$$LoadMonthImplCopyWith<$Res> {
  __$$LoadMonthImplCopyWithImpl(
    _$LoadMonthImpl _value,
    $Res Function(_$LoadMonthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _$LoadMonthImpl(
        null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadMonthImpl implements LoadMonth {
  const _$LoadMonthImpl(this.year, this.month);

  @override
  final int year;
  @override
  final int month;

  @override
  String toString() {
    return 'CalendarEvent.loadMonth(year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMonthImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, year, month);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMonthImplCopyWith<_$LoadMonthImpl> get copyWith =>
      __$$LoadMonthImplCopyWithImpl<_$LoadMonthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loadMonth,
    required TResult Function(DateTime date) selectDate,
    required TResult Function(String category) selectCategory,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return loadMonth(year, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loadMonth,
    TResult? Function(DateTime date)? selectDate,
    TResult? Function(String category)? selectCategory,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return loadMonth?.call(year, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loadMonth,
    TResult Function(DateTime date)? selectDate,
    TResult Function(String category)? selectCategory,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (loadMonth != null) {
      return loadMonth(year, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMonth value) loadMonth,
    required TResult Function(SelectDate value) selectDate,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return loadMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMonth value)? loadMonth,
    TResult? Function(SelectDate value)? selectDate,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return loadMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMonth value)? loadMonth,
    TResult Function(SelectDate value)? selectDate,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (loadMonth != null) {
      return loadMonth(this);
    }
    return orElse();
  }
}

abstract class LoadMonth implements CalendarEvent {
  const factory LoadMonth(final int year, final int month) = _$LoadMonthImpl;

  int get year;
  int get month;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMonthImplCopyWith<_$LoadMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectDateImplCopyWith<$Res> {
  factory _$$SelectDateImplCopyWith(
    _$SelectDateImpl value,
    $Res Function(_$SelectDateImpl) then,
  ) = __$$SelectDateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$SelectDateImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$SelectDateImpl>
    implements _$$SelectDateImplCopyWith<$Res> {
  __$$SelectDateImplCopyWithImpl(
    _$SelectDateImpl _value,
    $Res Function(_$SelectDateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null}) {
    return _then(
      _$SelectDateImpl(
        null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$SelectDateImpl implements SelectDate {
  const _$SelectDateImpl(this.date);

  @override
  final DateTime date;

  @override
  String toString() {
    return 'CalendarEvent.selectDate(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectDateImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectDateImplCopyWith<_$SelectDateImpl> get copyWith =>
      __$$SelectDateImplCopyWithImpl<_$SelectDateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loadMonth,
    required TResult Function(DateTime date) selectDate,
    required TResult Function(String category) selectCategory,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return selectDate(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loadMonth,
    TResult? Function(DateTime date)? selectDate,
    TResult? Function(String category)? selectCategory,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return selectDate?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loadMonth,
    TResult Function(DateTime date)? selectDate,
    TResult Function(String category)? selectCategory,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (selectDate != null) {
      return selectDate(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMonth value) loadMonth,
    required TResult Function(SelectDate value) selectDate,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return selectDate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMonth value)? loadMonth,
    TResult? Function(SelectDate value)? selectDate,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return selectDate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMonth value)? loadMonth,
    TResult Function(SelectDate value)? selectDate,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (selectDate != null) {
      return selectDate(this);
    }
    return orElse();
  }
}

abstract class SelectDate implements CalendarEvent {
  const factory SelectDate(final DateTime date) = _$SelectDateImpl;

  DateTime get date;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectDateImplCopyWith<_$SelectDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectCategoryImplCopyWith<$Res> {
  factory _$$SelectCategoryImplCopyWith(
    _$SelectCategoryImpl value,
    $Res Function(_$SelectCategoryImpl) then,
  ) = __$$SelectCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String category});
}

/// @nodoc
class __$$SelectCategoryImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$SelectCategoryImpl>
    implements _$$SelectCategoryImplCopyWith<$Res> {
  __$$SelectCategoryImplCopyWithImpl(
    _$SelectCategoryImpl _value,
    $Res Function(_$SelectCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$SelectCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectCategoryImpl implements SelectCategory {
  const _$SelectCategoryImpl(this.category);

  @override
  final String category;

  @override
  String toString() {
    return 'CalendarEvent.selectCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith =>
      __$$SelectCategoryImplCopyWithImpl<_$SelectCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loadMonth,
    required TResult Function(DateTime date) selectDate,
    required TResult Function(String category) selectCategory,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return selectCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loadMonth,
    TResult? Function(DateTime date)? selectDate,
    TResult? Function(String category)? selectCategory,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return selectCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loadMonth,
    TResult Function(DateTime date)? selectDate,
    TResult Function(String category)? selectCategory,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMonth value) loadMonth,
    required TResult Function(SelectDate value) selectDate,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return selectCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMonth value)? loadMonth,
    TResult? Function(SelectDate value)? selectDate,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return selectCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMonth value)? loadMonth,
    TResult Function(SelectDate value)? selectDate,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(this);
    }
    return orElse();
  }
}

abstract class SelectCategory implements CalendarEvent {
  const factory SelectCategory(final String category) = _$SelectCategoryImpl;

  String get category;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchQueryChangedImplCopyWith<$Res> {
  factory _$$SearchQueryChangedImplCopyWith(
    _$SearchQueryChangedImpl value,
    $Res Function(_$SearchQueryChangedImpl) then,
  ) = __$$SearchQueryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchQueryChangedImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$SearchQueryChangedImpl>
    implements _$$SearchQueryChangedImplCopyWith<$Res> {
  __$$SearchQueryChangedImplCopyWithImpl(
    _$SearchQueryChangedImpl _value,
    $Res Function(_$SearchQueryChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchQueryChangedImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchQueryChangedImpl implements SearchQueryChanged {
  const _$SearchQueryChangedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'CalendarEvent.searchQueryChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      __$$SearchQueryChangedImplCopyWithImpl<_$SearchQueryChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loadMonth,
    required TResult Function(DateTime date) selectDate,
    required TResult Function(String category) selectCategory,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return searchQueryChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loadMonth,
    TResult? Function(DateTime date)? selectDate,
    TResult? Function(String category)? selectCategory,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return searchQueryChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loadMonth,
    TResult Function(DateTime date)? selectDate,
    TResult Function(String category)? selectCategory,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadMonth value) loadMonth,
    required TResult Function(SelectDate value) selectDate,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return searchQueryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadMonth value)? loadMonth,
    TResult? Function(SelectDate value)? selectDate,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return searchQueryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadMonth value)? loadMonth,
    TResult Function(SelectDate value)? selectDate,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(this);
    }
    return orElse();
  }
}

abstract class SearchQueryChanged implements CalendarEvent {
  const factory SearchQueryChanged(final String query) =
      _$SearchQueryChangedImpl;

  String get query;

  /// Create a copy of CalendarEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
