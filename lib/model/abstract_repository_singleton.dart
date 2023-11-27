/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/abstract_repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/notification_repository.dart';
import '../model/notification_dashboard_repository.dart';
import 'package:eliud_core_main/tools/etc/member_collection_info.dart';

NotificationRepository? notificationRepository({String? appId}) =>
    AbstractRepositorySingleton.singleton.notificationRepository(appId);
NotificationDashboardRepository? notificationDashboardRepository(
        {String? appId}) =>
    AbstractRepositorySingleton.singleton
        .notificationDashboardRepository(appId);

abstract class AbstractRepositorySingleton {
  static List<MemberCollectionInfo> collections = [];
  static late AbstractRepositorySingleton singleton;

  NotificationRepository? notificationRepository(String? appId);
  NotificationDashboardRepository? notificationDashboardRepository(
      String? appId);

  void flush(String? appId) {
    notificationRepository(appId)!.flush();
    notificationDashboardRepository(appId)!.flush();
  }
}
