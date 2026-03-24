class BookingModel {
  DateTime? date;
  String? time;
  String? service;

  BookingModel({
    this.date,
    this.time,
    this.service,
  });

  @override
  String toString() {
    return 'Booking(date: $date, time: $time, service: $service)';
  }
}
