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
String pluralize(String word) {
  // Handle empty strings
  if (word.isEmpty) return word;

  // Preserve original capitalization
  bool isCapitalized = word.isNotEmpty && word[0].toUpperCase() == word[0];

  // Convert to lowercase for consistency in lookup
  String lowercaseWord = word.toLowerCase();

  // Check for already plural forms
  if (_pluralToSingular.containsKey(lowercaseWord)) {
    return isCapitalized ? _capitalize(lowercaseWord) : lowercaseWord;
  }

  // Check for irregular plurals first
  if (_singularToPlural.containsKey(lowercaseWord)) {
    String plural = _singularToPlural[lowercaseWord]!;
    return isCapitalized ? _capitalize(plural) : plural;
  }

  // Check for special 'o' → 'oes' cases
  if (_oPlurals.containsKey(lowercaseWord)) {
    String plural = _oPlurals[lowercaseWord]!;
    return isCapitalized ? _capitalize(plural) : plural;
  }

  // Check for special 'f/fe' → 'ves' cases
  if (_fPlurals.containsKey(lowercaseWord)) {
    String plural = _fPlurals[lowercaseWord]!;
    return isCapitalized ? _capitalize(plural) : plural;
  }

  // Apply regular rules
  String result;

  // Rule: Words ending in 'y' preceded by a consonant change 'y' to 'ies'
  if (lowercaseWord.endsWith('y') &&
      lowercaseWord.length > 1 &&
      !_isVowel(lowercaseWord[lowercaseWord.length - 2])) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1) + 'ies';
  }
  // Rule: Words ending in 's', 'x', 'z', 'ch', 'sh' add 'es'
  else if (lowercaseWord.endsWith('s') ||
      lowercaseWord.endsWith('x') ||
      lowercaseWord.endsWith('z') ||
      lowercaseWord.endsWith('ch') ||
      lowercaseWord.endsWith('sh')) {
    result = lowercaseWord + 'es';
  }
  // Default rule: Add 's'
  else {
    result = lowercaseWord + 's';
  }

  return isCapitalized ? _capitalize(result) : result;
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
String singularize(String word) {
  // Handle empty strings
  if (word.isEmpty) return word;

  // Preserve original capitalization
  bool isCapitalized = word.isNotEmpty && word[0].toUpperCase() == word[0];

  // Convert to lowercase for consistency in lookup
  String lowercaseWord = word.toLowerCase();

  // Check for words that are already singular
  if (_singularToPlural.containsKey(lowercaseWord)) {
    return isCapitalized ? _capitalize(lowercaseWord) : lowercaseWord;
  }

  // Check for irregular singulars first
  if (_pluralToSingular.containsKey(lowercaseWord)) {
    String singular = _pluralToSingular[lowercaseWord]!;
    return isCapitalized ? _capitalize(singular) : singular;
  }

  // Check for special 'oes' → 'o' cases
  if (_esToOPlurals.containsKey(lowercaseWord)) {
    String singular = _esToOPlurals[lowercaseWord]!;
    return isCapitalized ? _capitalize(singular) : singular;
  }

  // Check for special 'ves' → 'f/fe' cases
  if (_vesToFPlurals.containsKey(lowercaseWord)) {
    String singular = _vesToFPlurals[lowercaseWord]!;
    return isCapitalized ? _capitalize(singular) : singular;
  }

  // Apply regular rules
  String result;

  // Rule: Words ending in 'ies' change 'ies' to 'y'
  if (lowercaseWord.endsWith('ies') && lowercaseWord.length > 3) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 3) + 'y';
  }
  // Rule: Words ending in 'ses', 'xes', 'zes', 'ches', 'shes' remove 'es'
  else if (lowercaseWord.endsWith('es') &&
      lowercaseWord.length > 2 &&
      (lowercaseWord.endsWith('ses') ||
          lowercaseWord.endsWith('xes') ||
          lowercaseWord.endsWith('zes') ||
          lowercaseWord.endsWith('ches') ||
          lowercaseWord.endsWith('shes'))) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 2);
  }
  // Rule: Words ending in 's' but not 'ss' and not a singular word ending in 's'
  else if (lowercaseWord.endsWith('s') &&
      !lowercaseWord.endsWith('ss') &&
      !_singleFormEndingInS.contains(lowercaseWord)) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1);
  }
  // Default: The word might already be singular
  else {
    result = lowercaseWord;
  }

  return isCapitalized ? _capitalize(result) : result;
}

/// Helper function to check if a character is a vowel
bool _isVowel(String char) {
  return 'aeiou'.contains(char.toLowerCase());
}

/// Helper function to capitalize a string
String _capitalize(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1);
}

/// Map for singular to plural of irregular words
final Map<String, String> _singularToPlural = {
  // Man/Woman cases
  'man': 'men',
  'woman': 'women',
  'spokesman': 'spokesmen',
  'policeman': 'policemen',
  'fireman': 'firemen',
  // Human is an exception to man → men
  'human': 'humans',

  // Child/Children cases
  'child': 'children',

  // Foot/Feet cases
  'foot': 'feet',

  // Tooth/Teeth cases
  'tooth': 'teeth',

  // Goose/Geese cases
  'goose': 'geese',

  // Mouse/Mice cases
  'mouse': 'mice',
  'louse': 'lice',

  // Animal cases that remain the same
  'fish': 'fish',
  'deer': 'deer',
  'sheep': 'sheep',
  'moose': 'moose',
  'swine': 'swine',
  'buffalo': 'buffalo',
  'shrimp': 'shrimp',

  // Classic exceptions
  'person': 'people',
  'die': 'dice',
  'ox': 'oxen',

  // Latin-derived terms
  'criterion': 'criteria',
  'phenomenon': 'phenomena',
  'nucleus': 'nuclei',
  'syllabus': 'syllabi',
  'focus': 'foci',
  'fungus': 'fungi',
  'cactus': 'cacti',
  'thesis': 'theses',
  'crisis': 'crises',
  'axis': 'axes',
  'analysis': 'analyses',
  'datum': 'data',
  'medium': 'media',
  'formula': 'formulae',
  'antenna': 'antennae',
  'index': 'indices',
  'matrix': 'matrices',
  'vertex': 'vertices',
  'appendix': 'appendices',

  // French-derived terms
  'beau': 'beaux',
  'bureau': 'bureaux',
  'tableau': 'tableaux',

  // Words ending in -is
  'basis': 'bases',
  'diagnosis': 'diagnoses',
  'parenthesis': 'parentheses',
  'synopsis': 'synopses',
  'ellipsis': 'ellipses',

  // Words ending in -on/-um
  'memorandum': 'memoranda',
  'curriculum': 'curricula',
  'minimum': 'minima',
  'maximum': 'maxima',
  'stratum': 'strata',

  // Words ending in -us
  'alumnus': 'alumni',
  'radius': 'radii',
  'stimulus': 'stimuli',
  'octopus': 'octopi',
  // Exceptions to -us rule
  'virus': 'viruses',
  'status': 'statuses',

  // Words ending in -a
  'nebula': 'nebulae',
  'vertebra': 'vertebrae',
  'vita': 'vitae',

  // Words that remain the same in plural form
  'aircraft': 'aircraft',
  'series': 'series',
  'species': 'species',
  'scissors': 'scissors',
  'corps': 'corps',
  'means': 'means',
  'headquarters': 'headquarters',
  'waterworks': 'waterworks',
  'works': 'works',
  'news': 'news',
  'gallows': 'gallows',
  'crossroads': 'crossroads',
  'innings': 'innings',
  'salmon': 'salmon',
  'trout': 'trout',
  'spacecraft': 'spacecraft',

  // Other common exceptions
  'quiz': 'quizzes',
  'bus': 'buses',
};

/// Automatically generate the reverse map for plural to singular
final Map<String, String> _pluralToSingular = Map.fromEntries(
  _singularToPlural.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Set of words ending in 'o' that add 'es' in plural form
final Set<String> _oToEsPlurals = {
  'hero',
  'potato',
  'tomato',
  'echo',
  'veto',
  'torpedo',
  'domino',
  'volcano',
  'buffalo',
  'mosquito',
  'embargo',
  'cargo',
  'flamingo',
  'ghetto',
  'grotto',
  'mango',
  'motto',
  'tornado',
};

/// Set of words ending in 'f' or 'fe' that change to 'ves' in plural form
final Set<String> _fToVesPlurals = {
  'leaf',
  'loaf',
  'shelf',
  'thief',
  'wife',
  'life',
  'wolf',
  'half',
  'elf',
  'self',
  'calf',
  'knife',
  'sheaf',
  'hoof',
  'scarf',
  'wharf',
};

/// Automatically generate plurals for _oToEsPlurals
final Map<String, String> _oPlurals = Map.fromEntries(
  _oToEsPlurals.map((word) => MapEntry(word, word + 'es')),
);

/// Automatically generate plurals for _fToVesPlurals
final Map<String, String> _fPlurals = Map.fromEntries(
  _fToVesPlurals.map((word) {
    if (word.endsWith('fe')) {
      return MapEntry(word, word.substring(0, word.length - 2) + 'ves');
    } else {
      return MapEntry(word, word.substring(0, word.length - 1) + 'ves');
    }
  }),
);

/// Automatically generate the reverse mappings
final Map<String, String> _esToOPlurals = Map.fromEntries(
  _oPlurals.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Mapping from plural 'ves' forms back to singular 'f/fe' forms
final Map<String, String> _vesToFPlurals = Map.fromEntries(
  _fPlurals.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Set of common singular words ending in 's' that should not have 's' removed
final Set<String> _singleFormEndingInS = {
  'bus',
  'gas',
  'atlas',
  'bias',
  'canvas',
  'chaos',
  'cosmos',
  'lens',
  'virus',
  'status',
  'campus',
  'circus',
  'census',
  'corpus',
  'genus',
  'octopus',
  'chorus',
  'focus',
  'bonus',
  'plus',
  'tennis',
  'genius',
  'walrus',
  'radius',
  'nexus',
  'excess',
  'access',
  'process',
  'success',
  'circus',
  'cactus',
  'crisis',
  'basis',
  'axis',
  'series',
  'species',
  'apparatus',
  'prospectus',
  'terminus',
  'consensus',
  'syllabus',
  'synopsis',
  'status',
  'congress',
  'torus',
  'fuss',
  'pass',
  'mass',
  'kiss',
  'miss',
  'loss',
  'mess',
  'boss',
  'class',
  'glass',
  'grass',
  'cross',
  'dress',
  'chess',
  'stress',
  'press',
  'progress',
  'address',
  'express',
  'success',
  'process',
  'witness',
  'princess',
  'mattress',
  'fortress',
};

/// Test code to verify functionality
void main() {
  final testCases = [
    // Regular cases
    ['cat', 'cats'],
    ['dog', 'dogs'],
    ['house', 'houses'],

    // Words ending in 'y'
    ['city', 'cities'],
    ['baby', 'babies'],
    ['toy', 'toys'], // 'y' preceded by vowel
    // Words ending in 's', 'x', 'z', 'ch', 'sh'
    ['bus', 'buses'],
    ['box', 'boxes'],
    ['buzz', 'buzzes'],
    ['church', 'churches'],
    ['dish', 'dishes'],

    // Words ending in 'o'
    ['hero', 'heroes'],
    ['potato', 'potatoes'],
    ['photo', 'photos'], // Exception
    // Words ending in 'f' or 'fe'
    ['leaf', 'leaves'],
    ['wife', 'wives'],
    ['roof', 'roofs'], // Exception
    // Irregular plurals
    ['man', 'men'],
    ['woman', 'women'],
    ['child', 'children'],
    ['person', 'people'],
    ['foot', 'feet'],
    ['tooth', 'teeth'],
    ['goose', 'geese'],
    ['mouse', 'mice'],

    // Words that are the same in singular and plural
    ['sheep', 'sheep'],
    ['fish', 'fish'],
    ['deer', 'deer'],
    ['species', 'species'],

    // Capitalized words
    ['Cat', 'Cats'],
    ['City', 'Cities'],
    ['Man', 'Men'],
    ['Child', 'Children'],
  ];

  print('Testing pluralize:');
  for (final test in testCases) {
    final singular = test[0];
    final expectedPlural = test[1];
    final actualPlural = pluralize(singular);
    final result = actualPlural == expectedPlural ? 'PASS' : 'FAIL';
    print('$result: $singular → $actualPlural (expected: $expectedPlural)');
  }

  print('\nTesting singularize:');
  for (final test in testCases) {
    final expectedSingular = test[0];
    final plural = test[1];
    final actualSingular = singularize(plural);
    final result = actualSingular == expectedSingular ? 'PASS' : 'FAIL';
    print('$result: $plural → $actualSingular (expected: $expectedSingular)');
  }
}
