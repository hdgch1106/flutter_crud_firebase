import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiKey =
      dotenv.env["API_KEY"] ?? "No está configurado el API_KEY";

  static String databaseName =
      dotenv.env["DATABASE_NAME"] ?? "No está configurado el DATABASE_NAME";
}
