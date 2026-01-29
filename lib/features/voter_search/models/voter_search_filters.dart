class VoterSearchFilters {
  final String? epicId;
  final String? doorNo;
  final String? boothNo;
  final String? mobileNumber;

  const VoterSearchFilters({
    this.epicId,
    this.doorNo,
    this.boothNo,
    this.mobileNumber,
  });

  VoterSearchFilters copyWith({
    String? epicId,
    String? doorNo,
    String? boothNo,
    String? mobileNumber,
  }) {
    return VoterSearchFilters(
      epicId: epicId ?? this.epicId,
      doorNo: doorNo ?? this.doorNo,
      boothNo: boothNo ?? this.boothNo,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (epicId != null && epicId!.isNotEmpty) 'epic_id': epicId,
      if (doorNo != null && doorNo!.isNotEmpty) 'door_no': doorNo,
      if (boothNo != null && boothNo!.isNotEmpty) 'booth_no': boothNo,
      if (mobileNumber != null && mobileNumber!.isNotEmpty) 'phone': mobileNumber,
    };
  }

  bool get hasActiveFilters {
    return (epicId?.isNotEmpty ?? false) ||
           (doorNo?.isNotEmpty ?? false) ||
           (boothNo?.isNotEmpty ?? false) ||
           (mobileNumber?.isNotEmpty ?? false);
  }

  VoterSearchFilters clear() {
    return const VoterSearchFilters();
  }
}
