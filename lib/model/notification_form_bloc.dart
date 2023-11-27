/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 notification_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:eliud_core_helpers/etc/enums.dart';

import 'package:eliud_pkg_notifications_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications_model/model/model_export.dart';

import 'package:eliud_pkg_notifications_model/model/notification_form_event.dart';
import 'package:eliud_pkg_notifications_model/model/notification_form_state.dart';

class NotificationFormBloc
    extends Bloc<NotificationFormEvent, NotificationFormState> {
  final FormAction? formAction;
  final String? appId;

  NotificationFormBloc(this.appId, {this.formAction})
      : super(NotificationFormUninitialized()) {
    on<InitialiseNewNotificationFormEvent>((event, emit) {
      NotificationFormLoaded loaded = NotificationFormLoaded(
          value: NotificationModel(
        documentID: "",
        appId: "",
        description: "",
        reporterId: "",
        assigneeId: "",
      ));
      emit(loaded);
    });

    on<InitialiseNotificationFormEvent>((event, emit) async {
      // Need to re-retrieve the document from the repository so that I get all associated types
      NotificationFormLoaded loaded = NotificationFormLoaded(
          value: await notificationRepository(appId: appId)!
              .get(event.value!.documentID));
      emit(loaded);
    });
    on<InitialiseNotificationFormNoLoadEvent>((event, emit) async {
      NotificationFormLoaded loaded =
          NotificationFormLoaded(value: event.value);
      emit(loaded);
    });
    NotificationModel? newValue;
    on<ChangedNotificationDocumentID>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.addAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableNotificationForm(value: newValue));
        }
      }
    });
    on<ChangedNotificationDescription>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableNotificationForm(value: newValue));
      }
    });
    on<ChangedNotificationRead>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(read: event.value);
        emit(SubmittableNotificationForm(value: newValue));
      }
    });
    on<ChangedNotificationReporterId>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(reporterId: event.value);
        emit(SubmittableNotificationForm(value: newValue));
      }
    });
    on<ChangedNotificationAssigneeId>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(assigneeId: event.value);
        emit(SubmittableNotificationForm(value: newValue));
      }
    });
    on<ChangedNotificationStatus>((event, emit) async {
      if (state is NotificationFormInitialized) {
        final currentState = state as NotificationFormInitialized;
        newValue = currentState.value!.copyWith(status: event.value);
        emit(SubmittableNotificationForm(value: newValue));
      }
    });
  }

  DocumentIDNotificationFormError error(
          String message, NotificationModel newValue) =>
      DocumentIDNotificationFormError(message: message, value: newValue);

  Future<NotificationFormState> _isDocumentIDValid(
      String? value, NotificationModel newValue) async {
    if (value == null) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    if (value.isEmpty) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    Future<NotificationModel?> findDocument =
        notificationRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableNotificationForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }
}
