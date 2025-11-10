class Customer {
  final int? id;
  final String name;
  final String? phone;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? notes;

  Customer({
    this.id,
    required this.name,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'notes': notes,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      notes: map['notes'],
    );
  }
}
