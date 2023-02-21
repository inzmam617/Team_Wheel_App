class viewCarModel {
  String? status;
  List<Dataa>? data;
  String? message;
  int? totalPage;
  int? totalRecords;
  bool? next;
  bool? pervious;
  int? currentPage;

  viewCarModel(
      {this.status,
        this.data,
        this.message,
        this.totalPage,
        this.totalRecords,
        this.next,
        this.pervious,
        this.currentPage});

  viewCarModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Dataa>[];
      json['Data'].forEach((v) {
        data!.add(Dataa.fromJson(v));
      });
    }
    message = json['Message'];
    totalPage = json['TotalPage'];
    totalRecords = json['TotalRecords'];
    next = json['Next'];
    pervious = json['Pervious'];
    currentPage = json['CurrentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Message'] = message;
    data['TotalPage'] = totalPage;
    data['TotalRecords'] = totalRecords;
    data['Next'] = next;
    data['Pervious'] = pervious;
    data['CurrentPage'] = currentPage;
    return data;
  }
}

class Dataa {
  int? id;
  String? gUID;
  String? name;
  String? description;
  double? totalPrice;
  int? monthlyInstallments;
  int? makeId;
  int? modelId;
  int? bodyTypeId;
  int? engineTypeId;
  int? year;
  String? engineCapacity;
  int? isActive;
  int? isArchive;
  String? createdDate;
  String? updatedDate;
  List<VehicleImages>? vehicleImages;
  String? makeName;
  String? bodyTypeName;
  String? modelName;
  String? engineTypeName;

  Dataa(
      {this.id,
        this.gUID,
        this.name,
        this.description,
        this.totalPrice,
        this.monthlyInstallments,
        this.makeId,
        this.modelId,
        this.bodyTypeId,
        this.engineTypeId,
        this.year,
        this.engineCapacity,
        this.isActive,
        this.isArchive,
        this.createdDate,
        this.updatedDate,
        this.vehicleImages,
        this.makeName,
        this.bodyTypeName,
        this.modelName,
        this.engineTypeName});

  Dataa.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gUID = json['GUID'];
    name = json['Name'];
    description = json['Description'];
    totalPrice = double.parse(json['TotalPrice']);
    monthlyInstallments = json['MonthlyInstallments'];
    makeId = json['MakeId'];
    modelId = json['ModelId'];
    bodyTypeId = json['BodyTypeId'];
    engineTypeId = json['EngineTypeId'];
    year = json['Year'];
    engineCapacity = json['EngineCapacity'];
    isActive = json['IsActive'];
    isArchive = json['IsArchive'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    if (json['VehicleImages'] != null) {
      vehicleImages = <VehicleImages>[];
      json['VehicleImages'].forEach((v) {
        vehicleImages!.add(VehicleImages.fromJson(v));
      });
    }
    makeName = json['MakeName'];
    bodyTypeName = json['BodyTypeName'];
    modelName = json['ModelName'];
    engineTypeName = json['EngineTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['GUID'] = gUID;
    data['Name'] = name;
    data['Description'] = description;
    data['TotalPrice'] = totalPrice;
    data['MonthlyInstallments'] = monthlyInstallments;
    data['MakeId'] = makeId;
    data['ModelId'] = modelId;
    data['BodyTypeId'] = bodyTypeId;
    data['EngineTypeId'] = engineTypeId;
    data['Year'] = year;
    data['EngineCapacity'] = engineCapacity;
    data['IsActive'] = isActive;
    data['IsArchive'] = isArchive;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    if (vehicleImages != null) {
      data['VehicleImages'] =
          vehicleImages!.map((v) => v.toJson()).toList();
    }
    data['MakeName'] = makeName;
    data['BodyTypeName'] = bodyTypeName;
    data['ModelName'] = modelName;
    data['EngineTypeName'] = engineTypeName;
    return data;
  }
}

class VehicleImages {
  int? isMain;
  String? fileName;

  VehicleImages({this.isMain, this.fileName});

  VehicleImages.fromJson(Map<String, dynamic> json) {
    isMain = json['IsMain'];
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsMain'] = isMain;
    data['FileName'] = fileName;
    return data;
  }
}