/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 notification_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/apis/style/style_registry.dart';
import 'package:eliud_core_helpers/tools/has_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_helpers/tools/delete_snackbar.dart';
import 'package:eliud_core_main/tools/etc/etc.dart';

import 'package:eliud_pkg_notifications_model/model/notification_list_event.dart';
import 'package:eliud_pkg_notifications_model/model/notification_list_state.dart';
import 'package:eliud_pkg_notifications_model/model/notification_list_bloc.dart';
import 'package:eliud_pkg_notifications_model/model/notification_model.dart';

import 'package:eliud_core_main/model/app_model.dart';

typedef NotificationWidgetProvider = Function(NotificationModel? value);

class NotificationListWidget extends StatefulWidget with HasFab {
  final AppModel app;
  final BackgroundModel? listBackground;
  final NotificationWidgetProvider? widgetProvider;
  final bool? readOnly;
  final String? form;
  //final NotificationListWidgetState? state;
  final bool? isEmbedded;

  NotificationListWidget(
      {super.key,
      required this.app,
      this.readOnly,
      this.form,
      this.widgetProvider,
      this.isEmbedded,
      this.listBackground});

  @override
  NotificationListWidgetState createState() {
    return NotificationListWidgetState();
  }

  @override
  Widget? fab(BuildContext context) {
    return null;
/*
    if ((readOnly != null) && readOnly!) return null;
    var state = NotificationListWidgetState();
    return state.fab(context,);
*/
  }
}

class NotificationListWidgetState extends State<NotificationListWidget> {
/*
  Widget? fab(BuildContext aContext) {
    return null;
    return  !Apis.apis().getCoreApi().memberIsOwner(context, widget.app.documentID) ? null : 
      StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().floatingActionButton(widget.app, context, 'PageFloatBtnTag', Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          pageRouteBuilder(widget.app, page: BlocProvider.value(
              value: BlocProvider.of<NotificationListBloc>(context),
              child: NotificationForm(app:widget.app,
                  value: null,
                  formAction: FormAction.addAction)
          )),
        );
      },
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Apis.apis().getCoreApi().buildWhenAccessDetermined(widget.app,
        (context) {
      return BlocBuilder<NotificationListBloc, NotificationListState>(
          builder: (context, state) {
        if (state is NotificationListLoading) {
          return StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context);
        } else if (state is NotificationListLoaded) {
          final values = state.values;
          if ((widget.isEmbedded != null) && widget.isEmbedded!) {
            var children = <Widget>[];
            children.add(theList(
              context,
              values,
            ));
/*
              children.add(
                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app,
                      context, label: 'Add',
                      onPressed: () {
                        Navigator.of(context).push(
                                  pageRouteBuilder(widget.app, page: BlocProvider.value(
                                      value: BlocProvider.of<NotificationListBloc>(context),
                                      child: NotificationForm(app:widget.app,
                                          value: null,
                                          formAction: FormAction.addAction)
                                  )),
                                );
                      },
                    ));
*/
            return ListView(
                padding: const EdgeInsets.all(8),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: children);
          } else {
            return theList(
              context,
              values,
            );
          }
        } else {
          return StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context);
        }
      });
    });
  }

  Widget theList(
    BuildContext context,
    values,
  ) {
    var member = Apis.apis().getCoreApi().getMember(context);
    return Container(
        decoration: widget.listBackground == null
            ? StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminListStyle()
                .boxDecorator(widget.app, context, member)
            : BoxDecorationHelper.boxDecoration(
                widget.app, member, widget.listBackground),
        child: ListView.separated(
            separatorBuilder: (context, index) => StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminListStyle()
                .divider(widget.app, context),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final value = values[index];

              if (widget.widgetProvider != null) {
                return widget.widgetProvider!(value);
              }

              return NotificationListItem(
                app: widget.app,
                value: value,
//            app: accessState.app,
                onDismissed: (direction) {
                  BlocProvider.of<NotificationListBloc>(context)
                      .add(DeleteNotificationList(value: value));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteSnackBar(
                    message: "Notification $value.documentID",
                    onUndo: () => BlocProvider.of<NotificationListBloc>(context)
                        .add(AddNotificationList(value: value)),
                  ));
                },
                onTap: () async {},
              );
            }));
  }
}

class NotificationListItem extends StatelessWidget {
  final AppModel app;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final NotificationModel value;

  NotificationListItem({
    super.key,
    required this.app,
    required this.onDismissed,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__Notification_item_${value.documentID}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: value.timestamp != null
            ? Center(
                child: StyleRegistry.registry()
                    .styleWithApp(app)
                    .frontEndStyle()
                    .textStyle()
                    .text(app, context, value.timestamp!.toString()))
            : Container(),
        subtitle: Center(
            child: StyleRegistry.registry()
                .styleWithApp(app)
                .frontEndStyle()
                .textStyle()
                .text(app, context, value.documentID)),
      ),
    );
  }
}
