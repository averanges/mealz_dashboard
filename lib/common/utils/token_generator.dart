import 'package:uuid/uuid.dart';

String generateToken() {
  return const Uuid().v4();
}
