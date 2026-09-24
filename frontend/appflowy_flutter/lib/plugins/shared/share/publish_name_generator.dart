String replaceInvalidChars(String input) {
  final RegExp invalidCharsRegex = RegExp('[^a-zA-Z0-9-]');
  return input.replaceAll(invalidCharsRegex, '-');
}

Future<String> generateNameSpace() async {
  return '';
}

// The backend limits the publish name to a maximum of 120 characters.
// If the combined length of the ID and the name exceeds 120 characters,
// we will truncate the name to ensure the final result is within the limit.
// The name should only contain alphanumeric characters and hyphens.
Future<String> generatePublishName(String id, String name) async {
  final maxNameLength = 119 - id.length;
  if (maxNameLength < 0) {
    return replaceInvalidChars(id.substring(0, 120));
  }
  if (name.length > maxNameLength) {
    name = name.substring(0, maxNameLength);
  }
  return replaceInvalidChars('$name-$id');
}
