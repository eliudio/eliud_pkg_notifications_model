/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 notification_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_notifications_model/model/notification_component_bloc.dart';
import 'package:eliud_pkg_notifications_model/model/notification_component_event.dart';
import 'package:eliud_pkg_notifications_model/model/notification_model.dart';
import 'package:eliud_pkg_notifications_model/model/notification_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_main/apis/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_main/widgets/alert_widget.dart';
import 'package:eliud_core_main/model/app_model.dart';

/*
 * AbstractNotificationComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractNotificationComponent extends StatelessWidget {
  static String componentName = "notifications";
  final AppModel app;
  final String notificationId;

  /*
   * Construct AbstractNotificationComponent
   */
  AbstractNotificationComponent(
      {super.key, required this.app, required this.notificationId});

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationComponentBloc>(
      create: (context) => NotificationComponentBloc(
          notificationRepository:
              notificationRepository(appId: app.documentID)!)
        ..add(FetchNotificationComponent(id: notificationId)),
      child: _notificationBlockBuilder(context),
    );
  }

  Widget _notificationBlockBuilder(BuildContext context) {
    return BlocBuilder<NotificationComponentBloc, NotificationComponentState>(
        builder: (context, state) {
      if (state is NotificationComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is NotificationComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is NotificationComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(app)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, NotificationModel value);
}
