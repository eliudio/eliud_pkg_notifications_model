/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 notification_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_notifications_model/model/model_export.dart';
import 'package:eliud_pkg_notifications_model/model/entity_export.dart';

import 'dart:async';
import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_core_helpers/helpers/common_tools.dart';
import 'package:eliud_core_helpers/repository/repository_base.dart';

typedef NotificationModelTrigger = Function(List<NotificationModel?> list);
typedef NotificationChanged = Function(NotificationModel? value);
typedef NotificationErrorHandler = Function(dynamic o, dynamic e);

abstract class NotificationRepository
    extends RepositoryBase<NotificationModel, NotificationEntity> {
  @override
  Future<NotificationEntity> addEntity(
      String documentID, NotificationEntity value);
  @override
  Future<NotificationEntity> updateEntity(
      String documentID, NotificationEntity value);
  @override
  Future<NotificationModel> add(NotificationModel value);
  @override
  Future<void> delete(NotificationModel value);
  @override
  Future<NotificationModel?> get(String? id, {Function(Exception)? onError});
  @override
  Future<NotificationModel> update(NotificationModel value);

  @override
  Stream<List<NotificationModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Stream<List<NotificationModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<NotificationModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<NotificationModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});

  @override
  StreamSubscription<List<NotificationModel?>> listen(
      NotificationModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<List<NotificationModel?>> listenWithDetails(
      NotificationModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<NotificationModel?> listenTo(
      String documentId, NotificationChanged changed,
      {NotificationErrorHandler? errorHandler});
  @override
  void flush();

  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<NotificationModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}
