import 'package:flutter/material.dart';
import 'package:ezflutter/core/services/notification_service.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🔔 Notifications")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // NotificationService.sendNotification("Nouvelle notification", "Ceci est une notification test.");
            NotificationService().sendNotification("Nouvelle notification", "Ceci est une notification test.");
          },
          child: Text("Envoyer une notification"),
        ),
      ),
    );
  }
}
