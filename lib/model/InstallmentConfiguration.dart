
class InstallmentConfig {
  String status;
  List<Data> data;
  String message;
  int totalPage;
  int totalRecords;
  bool next;
  bool previous;
  int currentPage;

  InstallmentConfig({
    required this.status,
    required this.data,
    required this.message,
    required this.totalPage,
    required this.totalRecords,
    required this.next,
    required this.previous,
    required this.currentPage,
  });

  factory InstallmentConfig.fromJson(Map<String, dynamic> json) {
    var dataJson = json['Data'] as List;
    List<Data> data = dataJson.map((i) => Data.fromJson(i)).toList();

    return InstallmentConfig(
        status: json['Status'],
        data: data,
        message: json['Message'],
        totalPage: json['TotalPage'],
        totalRecords: json['TotalRecords'],
        next: json['Next'],
        previous: json['Pervious'],
        currentPage: json['CurrentPage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Data'] = this.data.map((i) => i.toJson()).toList();
    data['Message'] = message;
    data['TotalPage'] = totalPage;
    data['TotalRecords'] = totalRecords;
    data['Next'] = next;
    data['Pervious'] = previous;
    data['CurrentPage'] = currentPage;
    return data;
  }
}

class Data {
  int id;
  String description;
  String minValue;
  String maxValue;
  String defaultValue;
  DateTime updatedDate;
  int updatedBy;

  Data({
    required this.id,
    required this.description,
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
    required this.updatedDate,
    required this.updatedBy,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['Id'],
      description: json['Description'],
      minValue: json['MinValue'],
      maxValue: json['MaxValue'],
      defaultValue: json['DefaultValue'],
      updatedDate: DateTime.parse(json['UpdatedDate']),
      updatedBy: json['UpdatedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Description'] = description;
    data['MinValue'] = minValue;
    data['MaxValue'] = maxValue;
    data['DefaultValue'] = defaultValue;
    data['UpdatedDate'] = updatedDate.toIso8601String();
    data['UpdatedBy'] = updatedBy;
    return data;
  }
}


