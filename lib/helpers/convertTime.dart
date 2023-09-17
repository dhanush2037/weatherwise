String convertTime(String inputTimeString) {
  List<String> parts = inputTimeString.split(' ')[1].split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  String amPm = hour < 12 ? 'AM' : 'PM';
  hour = hour % 12;
  if (hour == 0) {
    hour = 12;
  }
  String formattedTime = '${hour.toString().padLeft(2, '0')}:${parts[1]} $amPm';
  return formattedTime;
}
