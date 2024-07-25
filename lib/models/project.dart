// models/project.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Update {
  final int id;
  final String title;
  final String date;

  Update({required this.id, required this.title, required this.date});

  factory Update.fromMap(Map<String, dynamic> data) {
    return Update(
      id: data['id'],
      title: data['title'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }
}

class Project {
  final String? id;
  final String location;
  final String name;
  final double? paymentDue;
  final double? paymentReceived;
  final String status;
  final String? quotationUrl;
  final String? reportUrl;
  final String? ownerName;
  final String? ownerPhone;
  final String? customBoqUrl;
  final List<Update> updates;
  final DocumentReference userID;

  // New fields
  final bool? isOwnerDifferent;
  final bool customBoQ;
  final int? boreHoles;
  final double? boreHoleDepth;
  final List<String>? selectedServices;
  final double? area;
  final bool? priority;
  final String? remarks;

  Project({
    this.id,
    required this.location,
    required this.name,
    required this.paymentDue,
    required this.paymentReceived,
    required this.status,
    required this.updates,
    required this.userID,
    this.quotationUrl,
    this.reportUrl,
    this.ownerName,
    this.ownerPhone,
    this.customBoqUrl,
    this.isOwnerDifferent,
    required this.customBoQ,
    this.boreHoles,
    this.boreHoleDepth,
    this.selectedServices,
    this.area,
    required this.priority,
    this.remarks,
  });

  factory Project.fromMap(String id, Map<String, dynamic> data) {
    var updatesFromMap = (data['updates'] as List<dynamic>)
        .map((item) => Update.fromMap(item))
        .toList();

    return Project(
      id: id,
      location: data['location'],
      name: data['name'],
      paymentDue: (data['paymentDue'] as num?)?.toDouble(),
      paymentReceived: (data['paymentReceived'] as num?)?.toDouble(),
      status: data['status'],
      updates: updatesFromMap,
      quotationUrl: data['quotationUrl'],
      reportUrl: data['reportUrl'],
      ownerName: data['ownerName'],
      ownerPhone: data['ownerPhone'],
      customBoqUrl: data['customBoqUrl'],
      userID: data['userID'],
      isOwnerDifferent: data['isOwnerDifferent'] ?? false,
      customBoQ: data['customBoQ'] ?? false,
      boreHoles: data['boreHoles'],
      boreHoleDepth: (data['boreHoleDepth'] as num?)?.toDouble(),
      selectedServices: List<String>.from(data['selectedServices'] ?? []),
      area: (data['area'] as num?)?.toDouble(),
      priority: data['priority'] ?? false,
      remarks: data['remarks'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'name': name,
      'paymentDue': paymentDue,
      'paymentReceived': paymentReceived,
      'status': status,
      'updates': updates.map((update) => update.toMap()).toList(),
      'quotationUrl': quotationUrl,
      'reportUrl': reportUrl,
      'ownerName': ownerName,
      'ownerPhone': ownerPhone,
      'customBoqUrl': customBoqUrl,
      'userID': userID,
      'isOwnerDifferent': isOwnerDifferent,
      'customBoQ': customBoQ,
      'boreHoles': boreHoles,
      'boreHoleDepth': boreHoleDepth,
      'selectedServices': selectedServices,
      'area': area,
      'priority': priority,
      'remarks': remarks,
    };
  }
}
