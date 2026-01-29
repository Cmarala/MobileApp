import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

// Model for authenticated user

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @JsonKey(name: 'user_id') required String id,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_phone') String? userPhone,
    @JsonKey(name: 'user_role') String? userRole,
    @JsonKey(name: 'campaign_id') required String campaignId,
    @JsonKey(name: 'geo_unit_id') required String geoUnitId,
    required String token, // PowerSync Token
    @Default(true) @JsonKey(name: 'is_active') bool isActive,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}