import 'package:dox_queue/dox_queue.dart';
import 'package:dox_sample/config/queue.dart';

/// Queue service
/// --------------------------
/// Sets up the queue, so jobs can be dispatched.
/// If this project does not need a queue, delete this file
/// (Dox finds every DoxService class, see lib/generated/container.g.dart).
class AppQueueService extends QueueService {
  AppQueueService() : super(queueConfig);
}
