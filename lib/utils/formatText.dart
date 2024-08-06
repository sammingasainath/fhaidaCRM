String formatText(String input) {
  if (input.isEmpty) return '';

  // Capitalize the first letter
  String formatted = '${input[0].toUpperCase()}${input.substring(1)}';

  // Add space before uppercase letters and capitalize them
  formatted =
      formatted.replaceAllMapped(RegExp(r'(?<!^)(?=[A-Z])'), (Match match) {
    return ' ${match.group(0)}';
  });

  return formatted;
}