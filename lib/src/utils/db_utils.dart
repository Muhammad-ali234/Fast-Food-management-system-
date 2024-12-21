import 'package:postgres/postgres.dart';

class DbUtils {
  static PostgreSQLResult handleError(PostgreSQLResult result) {
    if (result.isEmpty) {
      throw Exception('No records found');
    }
    return result;
  }

  static String buildWhereClause(Map<String, dynamic> filters) {
    if (filters.isEmpty) return '';
    
    final conditions = filters.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key} = @${e.key}')
        .join(' AND ');
        
    return 'WHERE $conditions';
  }

  static Map<String, dynamic> sanitizeParams(Map<String, dynamic> params) {
    return Map.fromEntries(
      params.entries.where((e) => e.value != null)
    );
  }
}