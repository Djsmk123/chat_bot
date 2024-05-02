import 'package:logger/logger.dart';

void log(String text, {DateTime? time}) {
  Logger().log(Logger.level, text, time: time);
}
