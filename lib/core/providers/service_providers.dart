import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loyalty_card_storage_app/core/services/auth_service.dart';
import 'package:loyalty_card_storage_app/core/services/sync_service.dart';
import 'package:loyalty_card_storage_app/core/services/notification_service.dart';

final authServiceProvider = Provider((ref) => AuthService());
final syncServiceProvider = Provider((ref) => SyncService());
final notificationServiceProvider = Provider((ref) => NotificationService());

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).user;
});
