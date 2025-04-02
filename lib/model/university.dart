class University {
  final String name;
  final String location;
  final String applyDate;
  final String deadline;
  final String applyLink;
  final String admitCardDownload;
  final List<String> examUnits;
  final String imageUrl; // Ensure this is included

  University({
    required this.name,
    required this.location,
    required this.applyDate,
    required this.deadline,
    required this.applyLink,
    required this.admitCardDownload,
    required this.examUnits,
    required this.imageUrl, // Initialize image URL
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      location: json['location'],
      applyDate: json['applyDate'],
      deadline: json['deadline'],
      applyLink: json['applyLink'],
      admitCardDownload: json['admitCardDownload'],
      examUnits: List<String>.from(json['examUnits']),
      imageUrl: json['imageUrl'], // Ensure this value is being set
    );
  }
}
