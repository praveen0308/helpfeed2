class NotificationModel{
  String notificationId;
  String userId;
  String title;
  String description;
  String addedOn;
  bool isSeen;

  NotificationModel(this.notificationId, this.userId, this.title,
      this.description, this.addedOn, this.isSeen);
}