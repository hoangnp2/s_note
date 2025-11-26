import '../repositories/notification_repository.dart';

class ScheduleNotificationUseCase {
  final NotificationRepository repository;

  ScheduleNotificationUseCase(this.repository);

  Future<void> call({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) {
    return repository.scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
    );
  }
}
