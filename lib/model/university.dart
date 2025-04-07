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
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      applyDate: json['applicationDate'] != null
          ? DateTime.parse(json['applicationDate'])
          : DateTime.now(),
      deadline: json['applicationDeadline'] != null
          ? DateTime.parse(json['applicationDeadline'])
          : DateTime.now(),
      applyLink: json['admissionLink'] ?? '',
      admitCardDownload: json['admitCardDownloadDate'] != null
          ? DateTime.parse(json['admitCardDownloadDate'])
          : DateTime.now(),
      examUnits: json['examUnits'] != null
          ? List<ExamUnit>.from(
              json['examUnits'].map((examUnit) => ExamUnit.fromJson(examUnit)))
          : [],
      imageUrl: json['imageUrl'] ?? '',
      programType: json['programType'] ?? '',
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
      unit: json['unit'] ?? '',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }
}
