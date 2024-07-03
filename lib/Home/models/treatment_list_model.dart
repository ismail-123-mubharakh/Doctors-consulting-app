
class TreatmentListModel {
  bool? status;
  String? message;
  List<Treatment>? treatments;

  TreatmentListModel({
    this.status,
    this.message,
    this.treatments,
  });

  factory TreatmentListModel.fromJson(Map<String, dynamic> json) => TreatmentListModel(
    status: json["status"],
    message: json["message"],
    treatments: List<Treatment>.from(json["treatments"].map((x) => Treatment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "treatments": List<dynamic>.from(treatments!.map((x) => x.toJson())),
  };
}

class Treatment {
  int? id;
  List<Branch>? branches;
  String? name;
  String? duration;
  String? price;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    id: json["id"],
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    name: json["name"],
    duration: json["duration"],
    price: json["price"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branches": List<dynamic>.from(branches!.map((x) => x.toJson())),
    "name": name,
    "duration": duration,
    "price": price,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Branch {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  Branch({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    patientsCount: json["patients_count"],
    location: json["location"],
    phone: json["phone"],
    mail: json["mail"],
    address: json["address"],
    gst: json["gst"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patients_count": patientsCount,
    "location": location,
    "phone": phone,
    "mail": mail,
    "address": address,
    "gst": gst,
    "is_active": isActive,
  };
}
