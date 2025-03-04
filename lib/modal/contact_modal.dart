class ContactModal {
  late String name, chat, phone, date, time,image;
  int? id;

  ContactModal(
      {this.id,
        required this.image,
      required this.name,
      required this.chat,
      required this.date,
      required this.phone,
      required this.time});

  factory ContactModal.fromMap(Map m1) {
    return ContactModal(
      image: m1['image'],
        name: m1['name'],
        chat: m1['chat'],
        date: m1['date'],
        phone: m1['phone'],
        time: m1['time'],
        id: m1['id']);
  }

 static Map<String, Object?> toMap(ContactModal contact) {
    return {
      'name': contact.name,
      'image':contact.image,
      'id': contact.id,
      'time': contact.time,
      'chat': contact.chat,
      'date': contact.date,
      'phone': contact.phone
    };
  }
}
