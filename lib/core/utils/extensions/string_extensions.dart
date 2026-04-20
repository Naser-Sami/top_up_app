extension StringExtensions on String {
  /// Extracts up to two initials from a string (e.g., "John Doe" -> "JD").
  String get initials {
    // 'this' refers to the string the extension is called on
    final parts = trim().split(RegExp(r'\s+'));
    
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    
    return parts.isNotEmpty && parts[0].isNotEmpty 
        ? parts[0][0].toUpperCase() 
        : '?';
  }
}