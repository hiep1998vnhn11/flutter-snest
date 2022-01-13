import 'package:intl/intl.dart';

class FormatDate {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatTimeAgo(String? dateString, {numericDates = true}) {
    if (dateString == null) return '';
    final DateTime date = DateTime.parse(dateString);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);
    if (difference.inDays > 8) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 ngày trước'
          : '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? 'khoảng 1 giờ trước'
          : '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? 'khoảng 1 phút trước'
          : '${difference.inMinutes} phút trước';
    } else {
      return 'vừa xong';
    }
  }
}
