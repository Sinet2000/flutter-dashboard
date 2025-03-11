class Address {
  final String addressLine;
  final String postalCode;
  final String additionalDetails;
  final String country;
  final String city;

  Address({
    required this.addressLine,
    required this.postalCode,
    required this.additionalDetails,
    required this.country,
    required this.city,
  });

  String get fullAddress => '$addressLine, $city, $country, $postalCode';
}

// Contact class
class Contact {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final Address address;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
  });
}
