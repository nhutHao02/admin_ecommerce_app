class Address {
  String? id, firstname, lastname, location, state, city, country, phone, postcode;

  Address({
    this.id,
    this.firstname,
    this.lastname,
    this.location,
    this.state,
    this.city,
    this.country,
    this.phone,
    this.postcode,
  });

  Address.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    firstname = jsonMap['firstname'];
    lastname = jsonMap['lastname'];
    location = jsonMap['location'];
    state = jsonMap['state'];
    city = jsonMap['city'];
    country = jsonMap['country'];
    phone = jsonMap['phone'];
    postcode = jsonMap['postcode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'location': location,
      'state': state,
      'city': city,
      'country': country,
      'phone': phone,
      'postcode': postcode,
    };
  }
}
