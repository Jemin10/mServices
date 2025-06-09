enum UserType { customer, provider }

enum OrderType { pending, completed, cancelled }

abstract class ServiceType {
  static final String electrician = "Electrician";
  static final String plumber = "Plumber";
  static final String houseCleaning = "House Cleaning";
  static final String carpenter = "Carpenter";
  static final String acRepair = "AC Repair";
  static final String salonArtist = "Salon Artist";
  static final String gardening = "Gardening";
  static final String tutoring = "Tutoring";

  static final List<String> services = [
    electrician,
    plumber,
    houseCleaning,
    carpenter,
    acRepair,
    salonArtist,
    gardening,
    tutoring,
  ];
}
