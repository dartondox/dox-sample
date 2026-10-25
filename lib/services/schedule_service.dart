import 'package:dox_sample/config/schedule.dart';
import 'package:dox_scheduler/dox_scheduler.dart';

/// Scheduler service
/// --------------------------
/// Runs the schedule inside the server when `scheduleConfig.inProcess`
/// is true (lib/config/schedule.dart). Only the first isolate runs it.
/// When it is off, this service does nothing.
class ScheduleService extends SchedulerService {
  ScheduleService() : super(schedule: schedule, config: scheduleConfig);
}
