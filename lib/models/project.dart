class Project {
  final String id;
  final String location;
  final String name;
  final int? paymentDue;
  final int? paymentReceived;
  final String status;

  Project({
    required this.id,
    required this.location,
    required this.name,
    required this.paymentDue,
    required this.paymentReceived,
    required this.status,
  });

  factory Project.fromMap(String id, Map<String, dynamic> data) {
    return Project(
      id: id,
      location: data['location'],
      name: data['name'],
      paymentDue: data['paymentDue'],
      paymentReceived: data['paymentReceived'],
      status: data['status'],
    );
  }
}
