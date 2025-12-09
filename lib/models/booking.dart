// Model for Booking
class Booking {
  final String id;
  final String courtId;
  final String userId;
  final DateTime date;
  final String startTime; // Format "HH:mm"
  final int duration; // In hours
  final int totalPrice;

  Booking({
    required this.id,
    required this.courtId,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.duration,
    required this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      courtId: json['courtId'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      duration: json['duration'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtId': courtId,
      'userId': userId,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'duration': duration,
      'totalPrice': totalPrice,
    };
  }
}
