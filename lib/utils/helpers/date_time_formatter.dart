class PIDateTimeFormatter {
  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static String formatDate(DateTime? dt, {bool useLocal = true}) {
    if (dt == null) return 'N/A';
    final d = useLocal ? dt.toLocal() : dt;
    final day = d.day;
    final month = _months[d.month - 1];
    final year = d.year;
    return '$day $month $year';
  }

  static String formatTime(DateTime? dt, {bool useLocal = true}) {
    if (dt == null) return 'N/A';
    final d = useLocal ? dt.toLocal() : dt;
    final hour = d.hour.toString().padLeft(2, '0');
    final minute = d.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatDateTime(DateTime? dt, {bool useLocal = true}) {
    if (dt == null) return 'N/A';
    return '${formatDate(dt, useLocal: useLocal)} at ${formatTime(dt, useLocal: useLocal)}';
  }

  static int calculateDurationInSeconds(DateTime startTime, DateTime endTime) {
    final duration = endTime.difference(startTime);
    return duration.inSeconds;
  }

  static DateTime? parseAsLocal(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      final hasTimezoneInfo =
          dateString.endsWith('Z') ||
          RegExp(r'[+-]\d{2}:\d{2}$').hasMatch(dateString);

      if (!hasTimezoneInfo) {
        // If no timezone info, treat as local time (don't add Z or convert)
        final parsed = DateTime.tryParse(dateString);
        if (parsed == null) return null;

        return parsed;
      } else {
        final parsed = DateTime.tryParse(dateString);
        if (parsed == null) return null;

        return parsed.toLocal();
      }
    } catch (e) {
      return null;
    }
  }

  static String formatTimeAsLocal(DateTime? dt) {
    if (dt == null) return 'N/A';

    final localDt = dt.toLocal();
    final hour = localDt.hour.toString().padLeft(2, '0');
    final minute = localDt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatDateAsLocal(DateTime? dt) {
    if (dt == null) return 'N/A';

    final localDt = dt.toLocal();
    final day = localDt.day;
    final month = _months[localDt.month - 1];
    final year = localDt.year;
    return '$day $month $year';
  }

  static String formatDayOfWeek(DateTime? dt, {bool useLocal = true}) {
    if (dt == null) return 'N/A';
    final d = useLocal ? dt.toLocal() : dt;
    final dayOfWeek =
        d.weekday - 1; // DateTime.weekday returns 1-7, we need 0-6
    return _daysOfWeek[dayOfWeek];
  }
}
