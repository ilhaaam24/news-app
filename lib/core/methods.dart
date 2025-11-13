String getRelativeTIme(String date) {
  final now = DateTime.now();
  final difference = now.difference(DateTime.parse(date));
  if (difference.inDays > 0) {
    return '${difference.inDays} d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} m ago';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds} s ago';
  } else {
    return 'just now';
  }
}
