class Customer {
  Customer(this.id, this.name, this.contactNumber, this.city, {this.remarks = 'NA'});

  final int id;
  final String name;
  final String contactNumber;
  final String city;
  final String remarks;
}
