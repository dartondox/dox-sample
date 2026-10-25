// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_queue. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_queue/dox_queue.dart';
import 'package:dox_sample/app/jobs/send_welcome_email.job.dart' as i1;

/// Every `@Job()` class of the app.
/// Use it in `QueueConfig(jobs: jobRegistry)`.
const JobRegistry jobRegistry = JobRegistry(<JobCodec>[
  JobCodec('SendWelcomeEmail', i1.SendWelcomeEmail, _encode0, _decode0),
]);

Map<String, Object?> _encode0(DoxJob job) {
  i1.SendWelcomeEmail value = job as i1.SendWelcomeEmail;
  return <String, Object?>{'userId': value.userId};
}

DoxJob _decode0(Map<String, Object?> data) {
  return i1.SendWelcomeEmail(userId: (data['userId'] as num).toInt());
}
