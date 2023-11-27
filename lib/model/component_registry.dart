/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/internal_component.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_spec.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_constructor.dart';
import 'package:eliud_core_main/apis/apis.dart';

import 'notification_dashboard_component_selector.dart';

/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {
  /* 
   * Initialise the component registry
   */
  init(
    ComponentConstructor notificationDashboardComponentConstructorDefault,
    ComponentEditorConstructor notificationDashboardComponentEditorConstructor,
  ) {
    Apis.apis()
        .getRegistryApi()
        .addInternalComponents('eliud_pkg_notifications_model', [
      "notifications",
      "notificationDashboards",
    ]);

    Apis.apis().getRegistryApi().register(
        componentName: "eliud_pkg_notifications_model_internalWidgets",
        componentConstructor: ListComponentFactory());
    Apis.apis().getRegistryApi().addDropDownSupporter(
        "notificationDashboards", DropdownButtonComponentFactory());
    Apis.apis().getRegistryApi().register(
        componentName: "notificationDashboards",
        componentConstructor: notificationDashboardComponentConstructorDefault);
    Apis.apis()
        .getRegistryApi()
        .addComponentSpec('eliud_pkg_notifications_model', 'notifications', [
      ComponentSpec(
          'notificationDashboards',
          notificationDashboardComponentConstructorDefault,
          NotificationDashboardComponentSelector(),
          notificationDashboardComponentEditorConstructor,
          ({String? appId}) => notificationDashboardRepository(appId: appId)!),
    ]);
    Apis.apis().getRegistryApi().registerRetrieveRepository(
        'eliud_pkg_notifications_model',
        'notifications',
        ({String? appId}) => notificationRepository(appId: appId)!);
    Apis.apis().getRegistryApi().registerRetrieveRepository(
        'eliud_pkg_notifications_model',
        'notificationDashboards',
        ({String? appId}) => notificationDashboardRepository(appId: appId)!);
  }
}
