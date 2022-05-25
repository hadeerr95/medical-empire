import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class NotificationFeedModel {
  final NotificationModel data;

  const NotificationFeedModel({
    required this.data,
  });

  factory NotificationFeedModel.fromJson(Map<String, dynamic> json) {
    return NotificationFeedModel(
      data: NotificationModel.fromJson(json['data'] ?? 'empty'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}

class NotificationModel {
  final Notifications notifications;
  final int status;

  const NotificationModel({
    required this.notifications,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notifications: Notifications.fromJson(json['notifications'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications,
      'status': status,
    };
  }
}

class Notifications {
  Notifications({
    required this.current_page,
    required this.last_page,
    // required this.data,
  });

  late final int current_page;
  late final int  last_page;
  late final List<NotificationsData> data;

  Notifications.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    last_page = json['last_page'];

    if(json['data'] != null) {
      data = List.from(json['data'])
          .map((e) => NotificationsData.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = current_page;
    _data['last_page'] = last_page;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class NotificationsData{

  NotificationsData({
    required this.id,
    required this.notifiable_id,
    required this.readAt,

  });

  late final String  id;
  late final int notifiable_id;
  dynamic readAt;
  late final NotificationsBody data;

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id']??'empty';
    notifiable_id = json['notifiable_id']??0;
    readAt = json['read_at'];
    // readAt = null;
    if(json['data'] != null){
      data = NotificationsBody.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['notifiable_id'] = notifiable_id;
    _data['data'] = data;
    _data['read_at'] = readAt;
    return _data;
  }

}

class NotificationsBody{

  NotificationsBody({
    required this.order,

  });

  late final int  order;
  late final LanguageModel title;
  late final LanguageModel body;

  NotificationsBody.fromJson(Map<String, dynamic> json) {
    order = json['order']??0;
    title =  LanguageModel.fromMap(parseMapFromServer(json['title']));
    body =  LanguageModel.fromMap(parseMapFromServer(json['body']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order'] = order;
    _data['title'] = title;
    _data['body'] = body;
    return _data;
  }

}
