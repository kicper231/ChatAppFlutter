String formatTimestamp(String timestamp) {
  if (timestamp == '') return '';
  final int millisecondsSinceEpoch = int.parse(timestamp);
  final DateTime date =
      DateTime.fromMicrosecondsSinceEpoch(millisecondsSinceEpoch);
  return "${date.day}/${date.month}/${date.year}";
}
