{
  "id": "Notification",
  "packageName": "eliud_pkg_notifications_model",
  "packageFriendlyName": "notifications",
  "isAppModel": true,
  "generate": {
    "generateComponent": true,
    "generateRepository": true,
    "generateCache": true,
    "hasPersistentRepository": true,
    "generateFirestoreRepository": true,
    "generateRepositorySingleton": true,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": false,
    "generateList": true,
    "generateDropDownButton": true,
    "generateInternalComponent": true,
    "generateEmbeddedComponent": false,
    "isExtension": false,
    "documentSubCollectionOf": "app"
  },
  "fields": [
    {
      "fieldName": "documentID",
      "required": true,
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "timestamp",
      "displayName": "Timestamp",
      "fieldType": "ServerTimestamp",
      "group": "general",
      "hidden": true
    },
    {
      "fieldName": "appId",
      "required": true,
      "displayName": "App Identifier",
      "remark": "This is the identifier of the app to which this feed belongs",
      "fieldType": "String",
      "group": "general",
      "hidden": true
    },
    {
      "fieldName": "description",
      "displayName": "Description",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "read",
      "displayName": "Has this been read?",
      "fieldType": "bool"
    },
    {
      "fieldName": "reporterId",
      "remarks": "The one who sent the message. This is a a string, not a Member to be able to receive messages from members this person has no access to",
      "displayName": "Reporter",
      "fieldType": "String",
      "group": "Reporter"
    },
    {
      "fieldName": "assigneeId",
      "remarks": "The one who assignment is assigned to. This is a a string, not a Member to be able to assign to a Member to which the currently logged in Member does not have access to",
      "displayName": "Assignee",
      "fieldType": "String",
      "group": "Assignee"
    },
    {
      "fieldName": "status",
      "fieldType": "enum",
      "enumName": "NotificationStatus",
      "enumValues" : [ "closed", "open" ]
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    },
    {
        "group": "Reporter",
        "description": "Reporter"
    },
    {
        "group": "Assignee",
        "description": "Assignee"
    }
 ],
  "listFields": {
    "title": "value.timestamp!= null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.timestamp!.toString())) : Container()",
    "subTitle": "Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID))"
  },
  "depends": ["eliud_core_main"]
}