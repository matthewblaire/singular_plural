import 'constants.dart';

/// Converts a singular English word to its plural form.
///
/// This function handles regular plural forms and many irregular cases.
/// It preserves the original capitalization of the word.
///
/// Example:
/// ```dart
/// print(pluralize('cat')); // 'cats'
/// print(pluralize('Child')); // 'Children'
/// print(pluralize('sheep')); // 'sheep'
/// ```
String pluralizeImpl(String word) {
  // Handle empty strings
  if (word.isEmpty) return word;
  // Check for invariant words that remain the same in singular and plural
  if (invariantWords.contains(word.toLowerCase())) {
    return word; // Return as-is
  }
  // Handle compound words with internal pluralization
  if (word.contains('-') &&
      compoundPluralPatterns.containsKey(word.toLowerCase())) {
    String plural = compoundPluralPatterns[word.toLowerCase()]!;
    return word[0].toUpperCase() == word[0] ? capitalize(plural) : plural;
  }
  if (multiWordPlurals.containsKey(word.toLowerCase())) {
    String plural = multiWordPlurals[word.toLowerCase()]!;
    return word[0].toUpperCase() == word[0] ? capitalize(plural) : plural;
  }
  // Preserve original capitalization
  bool isCapitalized = word.isNotEmpty && word[0].toUpperCase() == word[0];
  // Convert to lowercase for consistency in lookup
  String lowercaseWord = word.toLowerCase();
  // Check for already plural forms
  if (pluralToSingular.containsKey(lowercaseWord)) {
    return isCapitalized ? capitalize(lowercaseWord) : lowercaseWord;
  }
  // Check for irregular plurals first
  if (singularToPlural.containsKey(lowercaseWord)) {
    String plural = singularToPlural[lowercaseWord]!;
    return isCapitalized ? capitalize(plural) : plural;
  }
  // Check for pattern ending in "man" not in singularToPlural
  if (lowercaseWord.endsWith('man') &&
      !manExceptions.contains(lowercaseWord) &&
      !singularToPlural.containsKey(lowercaseWord)) {
    String plural =
        lowercaseWord.substring(0, lowercaseWord.length - 3) + 'men';
    return isCapitalized ? capitalize(plural) : plural;
  }
  // Check for special 'o' → 'oes' cases
  if (oPlurals.containsKey(lowercaseWord)) {
    String plural = oPlurals[lowercaseWord]!;
    return isCapitalized ? capitalize(plural) : plural;
  }
  // Check for special 'f/fe' → 'ves' cases
  if (fPlurals.containsKey(lowercaseWord)) {
    String plural = fPlurals[lowercaseWord]!;
    return isCapitalized ? capitalize(plural) : plural;
  }
  // Apply regular rules
  String result;
  // Rule: Words ending in 'y' preceded by a consonant change 'y' to 'ies'
  if (lowercaseWord.endsWith('y') &&
      lowercaseWord.length > 1 &&
      !isVowel(lowercaseWord[lowercaseWord.length - 2]) &&
      !yExceptions.contains(lowercaseWord)) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1) + 'ies';
  }
  // Rule: Words ending in 's', 'x', 'z', 'ch', 'sh' add 'es'
  else if ((lowercaseWord.endsWith('s') ||
          lowercaseWord.endsWith('x') ||
          lowercaseWord.endsWith('z') ||
          lowercaseWord.endsWith('ch') ||
          lowercaseWord.endsWith('sh')) &&
      !singleFormEndingInS.contains(lowercaseWord)) {
    result = lowercaseWord + 'es';
  }
  // Default rule: Add 's'
  else {
    result = lowercaseWord + 's';
  }
  return isCapitalized ? capitalize(result) : result;
}

/// Converts a plural English word to its singular form.
///
/// This function handles regular singular forms and many irregular cases.
/// It preserves the original capitalization of the word.
///
/// Example:
/// ```dart
/// print(singularize('cats')); // 'cat'
/// print(singularize('Children')); // 'Child'
/// print(singularize('sheep')); // 'sheep'
/// ```
String singularizeImpl(String word) {
  // Handle empty strings
  if (word.isEmpty) return word;

  // Special case for 'mechanics' -> 'mechanic'
  if (word.toLowerCase() == 'mechanics') {
    return word[0].toUpperCase() == word[0] ? 'Mechanic' : 'mechanic';
  }

  // Check for invariant words that remain the same in singular and plural
  if (invariantWords.contains(word.toLowerCase()) &&
      word.toLowerCase() != 'mechanics') {
    return word; // Return as-is
  }

  // Handle compound words with internal pluralization
  for (var entry in compoundPluralPatterns.entries) {
    if (entry.value.toLowerCase() == word.toLowerCase()) {
      return word[0].toUpperCase() == word[0]
          ? capitalize(entry.key)
          : entry.key;
    }
  }
  for (var entry in multiWordPlurals.entries) {
    if (entry.value.toLowerCase() == word.toLowerCase()) {
      return word[0].toUpperCase() == word[0]
          ? capitalize(entry.key)
          : entry.key;
    }
  }
  // Preserve original capitalization
  bool isCapitalized = word.isNotEmpty && word[0].toUpperCase() == word[0];
  // Convert to lowercase for consistency in lookup
  String lowercaseWord = word.toLowerCase();
  // Check for words that are already singular
  if (singularToPlural.containsKey(lowercaseWord)) {
    return isCapitalized ? capitalize(lowercaseWord) : lowercaseWord;
  }
  // Check for irregular singulars first
  if (pluralToSingular.containsKey(lowercaseWord)) {
    String singular = pluralToSingular[lowercaseWord]!;
    return isCapitalized ? capitalize(singular) : singular;
  }
  // Check for pattern ending in "men" not in pluralToSingular
  if (lowercaseWord.endsWith('men') &&
      !pluralToSingular.containsKey(lowercaseWord)) {
    String singular =
        lowercaseWord.substring(0, lowercaseWord.length - 3) + 'man';
    return isCapitalized ? capitalize(singular) : singular;
  }
  // Check for special 'oes' → 'o' cases
  if (esToOPlurals.containsKey(lowercaseWord)) {
    String singular = esToOPlurals[lowercaseWord]!;
    return isCapitalized ? capitalize(singular) : singular;
  }
  // Check for special 'ves' → 'f/fe' cases
  if (vesToFPlurals.containsKey(lowercaseWord)) {
    String singular = vesToFPlurals[lowercaseWord]!;
    return isCapitalized ? capitalize(singular) : singular;
  }

  // Special patterns that need exact handling
  if (exactPluralToSingular.containsKey(lowercaseWord)) {
    String singular = exactPluralToSingular[lowercaseWord]!;
    return isCapitalized ? capitalize(singular) : singular;
  }

  // Apply regular rules
  String result;

  // Handle words ending in 'esses' (e.g. 'actresses' -> 'actress')
  if (lowercaseWord.endsWith('esses') && lowercaseWord.length > 5) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 2);
  }
  // Handle words ending in 'sses' (e.g. 'glasses' -> 'glass')
  else if (lowercaseWord.endsWith('sses') && lowercaseWord.length > 4) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 3);
  }
  // Special case for words ending in 'ies' but where they should end in 'ie' not 'y'
  else if (lowercaseWord.endsWith('ies') &&
      (lowercaseWord == 'cookies' ||
          lowercaseWord == 'pies' ||
          ieWords.contains(
            lowercaseWord.substring(0, lowercaseWord.length - 1),
          ))) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1);
  }
  // Rule: Words ending in 'ies' change 'ies' to 'y'
  else if (lowercaseWord.endsWith('ies') && lowercaseWord.length > 3) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 3) + 'y';
  }
  // Rule: Words ending in specific patterns with 'es' remove 'es'
  else if (lowercaseWord.endsWith('es') &&
      lowercaseWord.length > 2 &&
      (lowercaseWord.endsWith('xes') ||
          lowercaseWord.endsWith('zes') ||
          lowercaseWord.endsWith('ches') ||
          lowercaseWord.endsWith('shes'))) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 2);
  }
  // Handle 'uses' endings specifically (e.g. 'statuses' -> 'status')
  else if (lowercaseWord.endsWith('uses') && lowercaseWord.length > 4) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 2);
  }
  // Fix for regular words ending in 'es' like 'houses'
  else if (lowercaseWord.endsWith('es') &&
      lowercaseWord.length > 2 &&
      !noESRemovalWords.contains(lowercaseWord)) {
    // Just remove the 's' for words like 'houses'
    result = lowercaseWord.substring(0, lowercaseWord.length - 1);
  }
  // Rule: Words ending in 's' but not 'ss' and not a singular word ending in 's'
  else if (lowercaseWord.endsWith('s') &&
      !lowercaseWord.endsWith('ss') &&
      !singleFormEndingInS.contains(lowercaseWord)) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1);
  }
  // Default: The word might already be singular
  else {
    result = lowercaseWord;
  }
  return isCapitalized ? capitalize(result) : result;
}

/// Helper function to check if a character is a vowel
bool isVowel(String char) {
  return 'aeiou'.contains(char.toLowerCase());
}

/// Helper function to capitalize a string
String capitalize(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1);
}
