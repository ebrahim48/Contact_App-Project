class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? stressAddress;
  String? dob;
  String? image;
  String? gender;
  String? website;
  bool favorite;

  ContactModel({this.id,
    required this.name,
    required this.mobile,
    this.email,
    this.stressAddress,
    this.dob,
    this.image,
    this.gender,
    this.website,
    this.favorite = false});

  @override
  String toString() {
    return 'ContactModel{'
        'id: $id, '
        'name: $name,'
        'mobile: $mobile, '
        'email: $email, '
        'stressAddress: $stressAddress, '
        'dob: $dob,'
        'image: $image, '
        'gender: $gender,'
        'website: $website}';
  }
}
  final contactListDB = <ContactModel>[
    ContactModel(
        id: 1,
        name: 'Shakib Al Hasan',
        mobile: '01795112198',
        email: 'shakib.crickter@gmail.com',
        stressAddress: 'Ghulsan,Dhaka',
        dob: '24/03/1987',
        gender: 'Male',
        website: 'www.shakib.com',
    ),
    ContactModel(
        id: 2,
        name: 'Mushfiqur Rahim',
        mobile: '01938518415',
        email: 'mushfiq.crickter@gmail.com',
        stressAddress: 'Mirpur,Dhaka',
        dob: '9/05/1987',
        gender: 'Male',
        website: 'www.mushfiq.com',
    ),
  ];
