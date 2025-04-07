class University {
  final String name;
  final String location;
  final DateTime applyDate;
  final DateTime deadline;
  final String applyLink;
  final DateTime admitCardDownload;
  final List<ExamUnit> examUnits;
  final String imageUrl;
  final String programType;

  University({
    required this.name,
    required this.location,
    required this.applyDate,
    required this.deadline,
    required this.applyLink,
    required this.admitCardDownload,
    required this.examUnits,
    required this.imageUrl,
    required this.programType,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '', // Provide default empty string for null values
      location: json['location'] ??
          '', // Provide default empty string for null values
      applyDate: json['applicationDate'] != null
          ? DateTime.parse(json['applicationDate'])
          : DateTime.now(), // Handle null value with current date
      deadline: json['applicationDeadline'] != null
          ? DateTime.parse(json['applicationDeadline'])
          : DateTime.now(), // Handle null value with current date
      applyLink: json['admissionLink'] ??
          '', // Provide default empty string for null values
      admitCardDownload: json['admitCardDownloadDate'] != null
          ? DateTime.parse(json['admitCardDownloadDate'])
          : DateTime.now(), // Handle null value with current date
      examUnits: json['examUnits'] != null
          ? List<ExamUnit>.from(
              json['examUnits'].map((examUnit) => ExamUnit.fromJson(examUnit)))
          : [], // Handle null examUnits array
      imageUrl: json['imageUrl'] ??
          '', // Provide default empty string for null values
      programType: json['programType'] ??
          '', // Provide default empty string for null values
    );
  }
}

class ExamUnit {
  final String unit;
  final DateTime date;

  ExamUnit({
    required this.unit,
    required this.date,
  });

  factory ExamUnit.fromJson(Map<String, dynamic> json) {
    return ExamUnit(
      unit: json['unit'] ?? '', // Provide default empty string for null values
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(), // Handle null value with current date
    );
  }
}
