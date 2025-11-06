bool is18YearsOld(String date) {
  final userYear = DateTime.parse(date).year;
  final currentYear = DateTime.now().year;
  final diff = currentYear - userYear;

  return diff >= 18;
}