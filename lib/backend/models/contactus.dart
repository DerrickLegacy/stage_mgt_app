class ContactUs {
  final String docId;

  final String phoneNumber;
  final String userId;
  final String username;
  final String emailAddress;
  final String title;
  final String message;
  bool isReadByAdmin;

  ContactUs(
      {required this.docId,
      required this.phoneNumber,
      required this.emailAddress,
      required this.username,
      required this.userId,
      required this.title,
      required this.message,
      this.isReadByAdmin = false});
}
