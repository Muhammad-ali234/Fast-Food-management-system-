import '../models/user.dart';
import '../config/database.dart';

class AuthService {
  final DatabaseConfig _db = DatabaseConfig();

  Future<User> login(String username, String password) async {
    final conn = await _db.connection;
    final results = await conn.query(
      'SELECT * FROM users WHERE username = @username AND password = crypt(@password, password)',
      substitutionValues: {
        'username': username,
        'password': password,
      },
    );

    if (results.isEmpty) {
      throw Exception('Invalid credentials');
    }

    return User.fromJson(results.first.toColumnMap());
  }
}