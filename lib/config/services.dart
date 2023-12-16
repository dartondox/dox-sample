import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/services/orm_service.dart';

/// Services to register on dox
/// -------------------------------
/// Since dox run on multi thread isolate, we need to register
/// below extra services to dox so that dox can
/// register again on new isolate.
List<DoxService> services = <DoxService>[
  ORMService(),
];
