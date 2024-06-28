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
  final String id;
  final String location;
  final String name;
  final int? paymentDue;
  final int? paymentReceived;
  final String status;
  final String? quotationUrl;
  final String? reportUrl;
  final List<Update> updates;

  Project(
      {required this.id,
      required this.location,
      required this.name,
      required this.paymentDue,
      required this.paymentReceived,
      required this.status,
      required this.updates,
      this.quotationUrl,
      this.reportUrl});

  factory Project.fromMap(String id, Map<String, dynamic> data) {
    var updatesFromMap = (data['updates'] as List<dynamic>)
        .map((item) => Update.fromMap(item))
        .toList();

    return Project(
      id: id,
      location: data['location'],
      name: data['name'],
      paymentDue: data['paymentDue'],
      paymentReceived: data['paymentReceived'],
      status: data['status'],
      updates: updatesFromMap,
      quotationUrl: data['quotationUrl'],
      reportUrl: data['reportUrl'],
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
    };
  }
}
