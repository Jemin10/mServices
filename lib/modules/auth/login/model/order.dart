class OrderModel {
  String? customer;
  String? hours;
  String? date;
  String? location;
  String? status;

  OrderModel({
    this.customer,
    this.hours,
    this.date,
    this.location,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        customer: json["customer"] ?? "",
        hours: json["hours"] ?? "",
        date: json["date"] ?? "",
        location: json["location"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "customer": customer ?? "",
        "hours": hours ?? "",
        "date": date ?? "",
        "location": location ?? "",
        "status": status ?? "",
      };
}
