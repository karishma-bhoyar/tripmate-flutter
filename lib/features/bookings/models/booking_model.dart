enum BookingStatus { upcoming, completed, cancelled }

class BookingModel {
  final String id;
  final String hotelName;
  final String location;
  final String imageUrl;
  final String roomName;
  final double roomPrice;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guestCount;
  final double totalAmount;
  final BookingStatus status;

  const BookingModel({
    required this.id,
    required this.hotelName,
    required this.location,
    required this.imageUrl,
    required this.roomName,
    required this.roomPrice,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
    required this.totalAmount,
    required this.status,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotelName': hotelName,
      'location': location,
      'imageUrl': imageUrl,
      'roomName': roomName,
      'roomPrice': roomPrice,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'guestCount': guestCount,
      'totalAmount': totalAmount,
      'status': status.name,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String,
      hotelName: map['hotelName'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      roomName: map['roomName'] as String,
      roomPrice: (map['roomPrice'] as num).toDouble(),
      checkInDate: DateTime.parse(map['checkInDate'] as String),
      checkOutDate: DateTime.parse(map['checkOutDate'] as String),
      guestCount: map['guestCount'] as int,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: BookingStatus.values.byName(map['status'] as String),
    );
  }
}
