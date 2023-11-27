/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 notification_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_main/model/app_model.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core_main/apis/action_api/action_model.dart';

import 'package:eliud_core_main/apis/apis.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_main/apis/style/style_registry.dart';

import 'package:eliud_core_helpers/etc/enums.dart';

import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_pkg_notifications_model/model/model_export.dart';

import 'package:eliud_pkg_notifications_model/model/notification_list_bloc.dart';
import 'package:eliud_pkg_notifications_model/model/notification_list_event.dart';
import 'package:eliud_pkg_notifications_model/model/notification_model.dart';
import 'package:eliud_pkg_notifications_model/model/notification_form_bloc.dart';
import 'package:eliud_pkg_notifications_model/model/notification_form_event.dart';
import 'package:eliud_pkg_notifications_model/model/notification_form_state.dart';

class NotificationForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final NotificationModel? value;
  final ActionModel? submitAction;

  NotificationForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the NotificationForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<NotificationFormBloc>(
        create: (context) => NotificationFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseNotificationFormEvent(value: value)),
        child: _MyNotificationForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<NotificationFormBloc>(
        create: (context) => NotificationFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseNotificationFormNoLoadEvent(value: value)),
        child: _MyNotificationForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update Notification'
                      : 'Add Notification'),
          body: BlocProvider<NotificationFormBloc>(
            create: (context) => NotificationFormBloc(
              appId,
              formAction: formAction,
            )..add((formAction == FormAction.updateAction
                ? InitialiseNotificationFormEvent(value: value)
                : InitialiseNewNotificationFormEvent())),
            child: _MyNotificationForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class _MyNotificationForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyNotificationForm({required this.app, this.formAction, this.submitAction});

  @override
  State<_MyNotificationForm> createState() =>
      _MyNotificationFormState(formAction);
}

class _MyNotificationFormState extends State<_MyNotificationForm> {
  final FormAction? formAction;
  late NotificationFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool? _readSelection;
  final TextEditingController _reporterIdController = TextEditingController();
  final TextEditingController _assigneeIdController = TextEditingController();
  int? _statusSelectedRadioTile;

  _MyNotificationFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<NotificationFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _readSelection = false;
    _reporterIdController.addListener(_onReporterIdChanged);
    _assigneeIdController.addListener(_onAssigneeIdChanged);
    _statusSelectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationFormBloc, NotificationFormState>(
        builder: (context, state) {
      if (state is NotificationFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is NotificationFormLoaded) {
        _documentIDController.text = state.value!.documentID.toString();
        _descriptionController.text = state.value!.description.toString();
        if (state.value!.read != null) {
          _readSelection = state.value!.read;
        } else {
          _readSelection = false;
        }
        _reporterIdController.text = state.value!.reporterId.toString();
        _assigneeIdController.text = state.value!.assigneeId.toString();
        if (state.value!.status != null) {
          _statusSelectedRadioTile = state.value!.status!.index;
        } else {
          _statusSelectedRadioTile = 0;
        }
      }
      if (state is NotificationFormInitialized) {
        List<Widget> children = [];
        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .checkboxListTile(
                widget.app,
                context,
                'Has this been read?',
                _readSelection,
                _readOnly(context, state)
                    ? null
                    : (dynamic val) => setSelectionRead(val)));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _statusSelectedRadioTile,
                'closed',
                'closed',
                !Apis.apis()
                        .getCoreApi()
                        .memberIsOwner(context, widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionStatus(val)));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _statusSelectedRadioTile,
                'open',
                'open',
                !Apis.apis()
                        .getCoreApi()
                        .memberIsOwner(context, widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionStatus(val)));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Document ID',
                icon: Icons.vpn_key,
                readOnly: (formAction == FormAction.updateAction),
                textEditingController: _documentIDController,
                keyboardType: TextInputType.text,
                validator: (_) => state is DocumentIDNotificationFormError
                    ? state.message
                    : null,
                hintText: null));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Description',
                icon: Icons.text_format,
                readOnly: _readOnly(context, state),
                textEditingController: _descriptionController,
                keyboardType: TextInputType.text,
                validator: (_) => state is DescriptionNotificationFormError
                    ? state.message
                    : null,
                hintText: null));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Reporter')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Reporter',
                icon: Icons.text_format,
                readOnly: _readOnly(context, state),
                textEditingController: _reporterIdController,
                keyboardType: TextInputType.text,
                validator: (_) => state is ReporterIdNotificationFormError
                    ? state.message
                    : null,
                hintText: null));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Assignee')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Assignee',
                icon: Icons.text_format,
                readOnly: _readOnly(context, state),
                textEditingController: _assigneeIdController,
                keyboardType: TextInputType.text,
                validator: (_) => state is AssigneeIdNotificationFormError
                    ? state.message
                    : null,
                hintText: null));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        if ((formAction != FormAction.showData) &&
            (formAction != FormAction.showPreloadedData)) {
          children.add(StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminFormStyle()
              .button(
                widget.app,
                context,
                label: 'Submit',
                onPressed: _readOnly(context, state)
                    ? null
                    : () {
                        if (state is NotificationFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<NotificationListBloc>(context)
                                .add(UpdateNotificationList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              timestamp: state.value!.timestamp,
                              appId: state.value!.appId,
                              description: state.value!.description,
                              read: state.value!.read,
                              reporterId: state.value!.reporterId,
                              assigneeId: state.value!.assigneeId,
                              status: state.value!.status,
                            )));
                          } else {
                            BlocProvider.of<NotificationListBloc>(context)
                                .add(AddNotificationList(
                                    value: NotificationModel(
                              documentID: state.value!.documentID,
                              timestamp: state.value!.timestamp,
                              appId: state.value!.appId,
                              description: state.value!.description,
                              read: state.value!.read,
                              reporterId: state.value!.reporterId,
                              assigneeId: state.value!.assigneeId,
                              status: state.value!.status,
                            )));
                          }
                          if (widget.submitAction != null) {
                            Apis.apis()
                                .getRouterApi()
                                .navigateTo(context, widget.submitAction!);
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
              ));
        }

        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .container(
                widget.app,
                context,
                Form(
                  child: ListView(
                      padding: const EdgeInsets.all(8),
                      physics: ((formAction == FormAction.showData) ||
                              (formAction == FormAction.showPreloadedData))
                          ? NeverScrollableScrollPhysics()
                          : null,
                      shrinkWrap: ((formAction == FormAction.showData) ||
                          (formAction == FormAction.showPreloadedData)),
                      children: children),
                ),
                formAction!);
      } else {
        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminListStyle()
            .progressIndicator(widget.app, context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc
        .add(ChangedNotificationDocumentID(value: _documentIDController.text));
  }

  void _onDescriptionChanged() {
    _myFormBloc.add(
        ChangedNotificationDescription(value: _descriptionController.text));
  }

  void setSelectionRead(bool? val) {
    setState(() {
      _readSelection = val;
    });
    _myFormBloc.add(ChangedNotificationRead(value: val));
  }

  void _onReporterIdChanged() {
    _myFormBloc
        .add(ChangedNotificationReporterId(value: _reporterIdController.text));
  }

  void _onAssigneeIdChanged() {
    _myFormBloc
        .add(ChangedNotificationAssigneeId(value: _assigneeIdController.text));
  }

  void setSelectionStatus(int? val) {
    setState(() {
      _statusSelectedRadioTile = val;
    });
    _myFormBloc
        .add(ChangedNotificationStatus(value: toNotificationStatus(val)));
  }

  @override
  void dispose() {
    _documentIDController.dispose();
    _descriptionController.dispose();
    _reporterIdController.dispose();
    _assigneeIdController.dispose();
    super.dispose();
  }

  /// Is the form read-only?
  bool _readOnly(BuildContext context, NotificationFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!Apis.apis()
            .getCoreApi()
            .memberIsOwner(context, widget.app.documentID));
  }
}
