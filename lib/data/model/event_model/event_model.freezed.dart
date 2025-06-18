// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventModel {
  String get id => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;
  String get eventDate => throw _privateConstructorUsedError;
  String get activityType => throw _privateConstructorUsedError;
  String get achievementStatus => throw _privateConstructorUsedError;
  String get achievementLevel => throw _privateConstructorUsedError;
  String get documentProof => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {String id,
      String eventName,
      String eventDate,
      String activityType,
      String achievementStatus,
      String achievementLevel,
      String documentProof,
      int points});
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventName = null,
    Object? eventDate = null,
    Object? activityType = null,
    Object? achievementStatus = null,
    Object? achievementLevel = null,
    Object? documentProof = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      achievementStatus: null == achievementStatus
          ? _value.achievementStatus
          : achievementStatus // ignore: cast_nullable_to_non_nullable
              as String,
      achievementLevel: null == achievementLevel
          ? _value.achievementLevel
          : achievementLevel // ignore: cast_nullable_to_non_nullable
              as String,
      documentProof: null == documentProof
          ? _value.documentProof
          : documentProof // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String eventName,
      String eventDate,
      String activityType,
      String achievementStatus,
      String achievementLevel,
      String documentProof,
      int points});
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventName = null,
    Object? eventDate = null,
    Object? activityType = null,
    Object? achievementStatus = null,
    Object? achievementLevel = null,
    Object? documentProof = null,
    Object? points = null,
  }) {
    return _then(_$EventModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      achievementStatus: null == achievementStatus
          ? _value.achievementStatus
          : achievementStatus // ignore: cast_nullable_to_non_nullable
              as String,
      achievementLevel: null == achievementLevel
          ? _value.achievementLevel
          : achievementLevel // ignore: cast_nullable_to_non_nullable
              as String,
      documentProof: null == documentProof
          ? _value.documentProof
          : documentProof // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EventModelImpl implements _EventModel {
  const _$EventModelImpl(
      {required this.id,
      required this.eventName,
      required this.eventDate,
      required this.activityType,
      required this.achievementStatus,
      required this.achievementLevel,
      required this.documentProof,
      required this.points});

  @override
  final String id;
  @override
  final String eventName;
  @override
  final String eventDate;
  @override
  final String activityType;
  @override
  final String achievementStatus;
  @override
  final String achievementLevel;
  @override
  final String documentProof;
  @override
  final int points;

  @override
  String toString() {
    return 'EventModel(id: $id, eventName: $eventName, eventDate: $eventDate, activityType: $activityType, achievementStatus: $achievementStatus, achievementLevel: $achievementLevel, documentProof: $documentProof, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.achievementStatus, achievementStatus) ||
                other.achievementStatus == achievementStatus) &&
            (identical(other.achievementLevel, achievementLevel) ||
                other.achievementLevel == achievementLevel) &&
            (identical(other.documentProof, documentProof) ||
                other.documentProof == documentProof) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, eventName, eventDate,
      activityType, achievementStatus, achievementLevel, documentProof, points);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);
}

abstract class _EventModel implements EventModel {
  const factory _EventModel(
      {required final String id,
      required final String eventName,
      required final String eventDate,
      required final String activityType,
      required final String achievementStatus,
      required final String achievementLevel,
      required final String documentProof,
      required final int points}) = _$EventModelImpl;

  @override
  String get id;
  @override
  String get eventName;
  @override
  String get eventDate;
  @override
  String get activityType;
  @override
  String get achievementStatus;
  @override
  String get achievementLevel;
  @override
  String get documentProof;
  @override
  int get points;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
