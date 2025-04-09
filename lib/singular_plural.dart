
import 'src/implementation.dart';

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
String pluralize(String word) => pluralizeImpl(word);

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
String singularize(String word) => singularizeImpl(word);
