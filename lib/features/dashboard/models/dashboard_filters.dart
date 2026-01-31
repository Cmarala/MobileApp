import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_filters.freezed.dart';
part 'dashboard_filters.g.dart';

@freezed
class DashboardFilters with _$DashboardFilters {
  const factory DashboardFilters({
    // Geographic filters
    @Default([]) List<String> selectedGeoUnitIds,
    
    // Demographics filters
    int? ageMin,
    int? ageMax,
    @Default([]) List<String> selectedGenders,
    @Default([]) List<int> selectedReligionIds,
    @Default([]) List<int> selectedCasteIds,
    @Default([]) List<int> selectedEducationIds,
    
    // Status filters
    bool? isPolled,
    bool? isDead,
    bool? isShifted,
    
    // Activity filters
    DateTime? lastVisitedFrom,
    DateTime? lastVisitedTo,
    @Default(false) bool neverVisited,
    
    // Contact filters
    bool? hasPhone,
    @Default(false) bool hasMobile,
    
    // Favorability filters
    @Default([]) List<String> selectedFavorabilities,
  }) = _DashboardFilters;

  factory DashboardFilters.fromJson(Map<String, dynamic> json) =>
      _$DashboardFiltersFromJson(json);
}

extension DashboardFiltersX on DashboardFilters {
  bool get hasActiveFilters {
    return selectedGeoUnitIds.isNotEmpty ||
        ageMin != null ||
        ageMax != null ||
        selectedGenders.isNotEmpty ||
        selectedReligionIds.isNotEmpty ||
        selectedCasteIds.isNotEmpty ||
        selectedEducationIds.isNotEmpty ||
        isPolled != null ||
        isDead != null ||
        isShifted != null ||
        lastVisitedFrom != null ||
        lastVisitedTo != null ||
        neverVisited ||
        hasPhone != null ||
        hasMobile ||
        selectedFavorabilities.isNotEmpty;
  }

  int get activeFilterCount {
    int count = 0;
    if (selectedGeoUnitIds.isNotEmpty) count++;
    if (ageMin != null || ageMax != null) count++;
    if (selectedGenders.isNotEmpty) count++;
    if (selectedReligionIds.isNotEmpty) count++;
    if (selectedCasteIds.isNotEmpty) count++;
    if (selectedEducationIds.isNotEmpty) count++;
    if (isPolled != null) count++;
    if (isDead != null) count++;
    if (isShifted != null) count++;
    if (lastVisitedFrom != null || lastVisitedTo != null) count++;
    if (neverVisited) count++;
    if (hasPhone != null) count++;
    if (hasMobile) count++;
    if (selectedFavorabilities.isNotEmpty) count++;
    return count;
  }
}
