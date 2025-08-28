import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/services/firebase_messaging_service.dart';

final firebaseMessagingServiceProvider = Provider<FirebaseMessagingService>(
  (ref) => FirebaseMessagingService()
);