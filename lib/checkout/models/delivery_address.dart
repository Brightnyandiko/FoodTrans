class DeliveryAddress {
  final String name;
  final String phoneNo;
  final String address;
  final String houseNo;
  final String city;

  const DeliveryAddress({
    this.name = '',
    this.phoneNo = '',
    this.address = '',
    this.houseNo = '',
    this.city = '',
  });

  @override
  List<Object> get props => [name, phoneNo, address, houseNo, city];
}

