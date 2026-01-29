import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/voter_report_provider.dart';

class VoterReportController {
  final Ref ref;

  VoterReportController(this.ref);

  Future<void> exportToExcel() async {
    try {
      final db = PowerSyncService().db;
      final filter = ref.read(voterReportFilterProvider);

      // Get campaign and user context
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final userGeoUnitId = prefs.getString('geo_unit_id');

      if (campaignId == null || userGeoUnitId == null) {
        throw Exception('Missing campaign or geo unit context');
      }

      // Build SQL query with the same filters as the report
      final conditions = <String>['campaign_id = ?'];
      final params = <dynamic>[campaignId];

      // Apply user's geo unit hierarchy constraint
      conditions.add('(geo_unit_id = ? OR ancestors LIKE ?)');
      params.add(userGeoUnitId);
      params.add('%"$userGeoUnitId"%');

      // Apply additional filters
      if (filter.boothId != null) {
        conditions.add('geo_unit_id = ?');
        params.add(filter.boothId);
      } else if (filter.mandalId != null) {
        conditions.add('(geo_unit_id = ? OR ancestors LIKE ?)');
        params.add(filter.mandalId);
        params.add('%"${filter.mandalId}"%');
      } else if (filter.districtId != null) {
        conditions.add('(geo_unit_id = ? OR ancestors LIKE ?)');
        params.add(filter.districtId);
        params.add('%"${filter.districtId}"%');
      }

      if (filter.religionId != null) {
        conditions.add('religion_id = ?');
        params.add(filter.religionId);
      }

      if (filter.casteId != null) {
        conditions.add('caste_id = ?');
        params.add(filter.casteId);
      }

      if (filter.subCasteId != null) {
        conditions.add('sub_caste_id = ?');
        params.add(filter.subCasteId);
      }

      if (filter.isVisited != null) {
        if (filter.isVisited!) {
          conditions.add('last_visited_at IS NOT NULL');
        } else {
          conditions.add('last_visited_at IS NULL');
        }
      }

      if (filter.isPolled != null) {
        conditions.add('is_polled = ?');
        params.add(filter.isPolled! ? 1 : 0);
      }

      if (filter.favorability != null) {
        conditions.add('favorability = ?');
        params.add(filter.favorability!.name);
      }

      final whereClause = conditions.join(' AND ');

      // Query voters with relevant fields
      final sql = '''
        SELECT 
          v.id,
          v.name,
          v.epic_id,
          v.age,
          v.gender,
          v.phone,
          v.address,
          v.favorability,
          v.last_visited_at,
          v.is_polled,
          g.name as booth_name,
          r.name as religion_name,
          c.name as caste_name,
          sc.name as sub_caste_name
        FROM voters v
        LEFT JOIN geo_units g ON v.geo_unit_id = g.id
        LEFT JOIN religions r ON v.religion_id = r.id
        LEFT JOIN castes c ON v.caste_id = c.id
        LEFT JOIN sub_castes sc ON v.sub_caste_id = sc.id
        WHERE $whereClause
        ORDER BY g.name, v.name
      ''';

      final rows = await db.getAll(sql, params);

      // Create Excel file
      final excel = Excel.createExcel();
      final sheet = excel['Voter Report'];

      // Add headers
      sheet.appendRow([
        TextCellValue('ID'),
        TextCellValue('Name'),
        TextCellValue('EPIC ID'),
        TextCellValue('Age'),
        TextCellValue('Gender'),
        TextCellValue('Phone'),
        TextCellValue('Address'),
        TextCellValue('Booth'),
        TextCellValue('Religion'),
        TextCellValue('Caste'),
        TextCellValue('Sub-Caste'),
        TextCellValue('Favorability'),
        TextCellValue('Visited'),
        TextCellValue('Polled'),
      ]);

      // Add data rows
      for (final row in rows) {
        sheet.appendRow([
          TextCellValue(row['id']?.toString() ?? ''),
          TextCellValue(row['name']?.toString() ?? ''),
          TextCellValue(row['epic_id']?.toString() ?? ''),
          IntCellValue(row['age'] as int? ?? 0),
          TextCellValue(row['gender']?.toString() ?? ''),
          TextCellValue(row['phone']?.toString() ?? ''),
          TextCellValue(row['address']?.toString() ?? ''),
          TextCellValue(row['booth_name']?.toString() ?? ''),
          TextCellValue(row['religion_name']?.toString() ?? ''),
          TextCellValue(row['caste_name']?.toString() ?? ''),
          TextCellValue(row['sub_caste_name']?.toString() ?? ''),
          TextCellValue(_formatFavorability(row['favorability']?.toString())),
          TextCellValue(row['last_visited_at'] != null ? 'Yes' : 'No'),
          TextCellValue((row['is_polled'] as int? ?? 0) == 1 ? 'Yes' : 'No'),
        ]);
      }

      // Save file
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final filePath = '${directory.path}/voter_report_$timestamp.xlsx';
      final fileBytes = excel.encode();

      if (fileBytes != null) {
        final file = File(filePath);
        await file.writeAsBytes(fileBytes);

        // Share the file
        await Share.shareXFiles(
          [XFile(filePath)],
          subject: 'Voter Report',
          text: 'Voter Insights Report - ${rows.length} voters',
        );

        Logger.logInfo('Excel export successful: ${rows.length} voters');
      } else {
        throw Exception('Failed to encode Excel file');
      }
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Failed to export voter report to Excel');
      rethrow;
    }
  }

  String _formatFavorability(String? favorability) {
    if (favorability == null) return 'Neutral';
    switch (favorability) {
      case 'veryStrong':
        return 'Very Strong';
      case 'strong':
        return 'Strong';
      case 'neutral':
        return 'Neutral';
      case 'leanOther':
        return 'Lean Other';
      case 'notKnown':
        return 'Not Known';
      default:
        return favorability;
    }
  }
}

// Controller Provider
final voterReportControllerProvider = Provider<VoterReportController>((ref) {
  return VoterReportController(ref);
});
