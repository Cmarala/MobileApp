import 'dart:convert';

class VolunteerSettings {
  final String campaignId;
  final String? selectedHeaderAssetId; // Reference to campaign_assets table
  final String? selectedHeaderUrl;     // Cached URL for immediate display
  final String? selectedFooterText;    // Custom or selected Section 3 text

  VolunteerSettings({
    required this.campaignId,
    this.selectedHeaderAssetId,
    this.selectedHeaderUrl,
    this.selectedFooterText,
  });

  // Convert settings to JSON string for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'campaignId': campaignId,
      'selectedHeaderAssetId': selectedHeaderAssetId,
      'selectedHeaderUrl': selectedHeaderUrl,
      'selectedFooterText': selectedFooterText,
    };
  }

  factory VolunteerSettings.fromMap(Map<String, dynamic> map) {
    return VolunteerSettings(
      campaignId: map['campaignId'] ?? '',
      selectedHeaderAssetId: map['selectedHeaderAssetId'],
      selectedHeaderUrl: map['selectedHeaderUrl'],
      selectedFooterText: map['selectedFooterText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VolunteerSettings.fromJson(String source) => 
      VolunteerSettings.fromMap(json.decode(source));

  // Helper to create a copy with updated fields
  VolunteerSettings copyWith({
    String? selectedHeaderAssetId,
    String? selectedHeaderUrl,
    String? selectedFooterText,
  }) {
    return VolunteerSettings(
      campaignId: campaignId,
      selectedHeaderAssetId: selectedHeaderAssetId ?? this.selectedHeaderAssetId,
      selectedHeaderUrl: selectedHeaderUrl ?? this.selectedHeaderUrl,
      selectedFooterText: selectedFooterText ?? this.selectedFooterText,
    );
  }
}