import 'package:postgres/postgres.dart';

class DatabaseConfig {
  static final DatabaseConfig _instance = DatabaseConfig._internal();
  factory DatabaseConfig() => _instance;
  DatabaseConfig._internal();

  PostgreSQLConnection? _connection;

  Future<PostgreSQLConnection> get connection async {
    if (_connection == null || _connection!.isClosed) {
      _connection = await _createConnection();
    }
    return _connection!;
  }

  Future<PostgreSQLConnection> _createConnection() async {
    final conn = PostgreSQLConnection(
      'localhost',
      5432,
      'ffms_db',
      username: 'postgres',
      password: '07877',
    );
    await conn.open();
    return conn;
  }

  Future<void> closeConnection() async {
    if (_connection != null && !_connection!.isClosed) {
      await _connection!.close();
    }
  }
}
