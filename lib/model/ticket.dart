class Ticket {
  String from;
  String to;
  String date;
  String returnDate;
  int travelers;
  String bookingClass;
  String time;
  String duration;
  String flightNumber;
  List<String> seats;
  int price;
  String gateNumber;

  Ticket({
    this.from,
    this.to,
    this.date,
    this.returnDate,
    this.travelers,
    this.bookingClass,
    this.time,
    this.duration,
    this.flightNumber,
    this.seats,
    this.price,
    this.gateNumber,
  });
}
