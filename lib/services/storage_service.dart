import 'package:dox_sample/config/storage.dart';
import 'package:dox_storage/dox_storage.dart';

/// Storage service
/// --------------------------
/// Sets up the storage disks from config/storage.dart.
/// If this project does not store files, delete this file
/// (Dox finds every DoxService class, see lib/generated/container.g.dart).
class AppStorageService extends StorageService {
  AppStorageService() : super(storageConfig);
}
