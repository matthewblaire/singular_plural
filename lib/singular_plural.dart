import 'package:singular_plural/constants.dart';

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
  // Check for invariant words that remain the same in singular and plural
  if (_invariantWords.contains(word.toLowerCase())) {
    return word; // Return as-is
  }
  // Handle compound words with internal pluralization
  if (word.contains('-') &&
      _compoundPluralPatterns.containsKey(word.toLowerCase())) {
    String plural = _compoundPluralPatterns[word.toLowerCase()]!;
    return word[0].toUpperCase() == word[0] ? _capitalize(plural) : plural;
  }
  if (_multiWordPlurals.containsKey(word.toLowerCase())) {
    String plural = _multiWordPlurals[word.toLowerCase()]!;
    return word[0].toUpperCase() == word[0] ? _capitalize(plural) : plural;
  }
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
  // Check for pattern ending in "man" not in singularToPlural
  if (lowercaseWord.endsWith('man') &&
      !_manExceptions.contains(lowercaseWord) &&
      !_singularToPlural.containsKey(lowercaseWord)) {
    String plural =
        lowercaseWord.substring(0, lowercaseWord.length - 3) + 'men';
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
      !_isVowel(lowercaseWord[lowercaseWord.length - 2]) &&
      !_yExceptions.contains(lowercaseWord)) {
    result = lowercaseWord.substring(0, lowercaseWord.length - 1) + 'ies';
  }
  // Rule: Words ending in 's', 'x', 'z', 'ch', 'sh' add 'es'
  else if ((lowercaseWord.endsWith('s') ||
          lowercaseWord.endsWith('x') ||
          lowercaseWord.endsWith('z') ||
          lowercaseWord.endsWith('ch') ||
          lowercaseWord.endsWith('sh')) &&
      !_singleFormEndingInS.contains(lowercaseWord)) {
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

  // Special case for 'mechanics' -> 'mechanic'
  if (word.toLowerCase() == 'mechanics') {
    return word[0].toUpperCase() == word[0] ? 'Mechanic' : 'mechanic';
  }

  // Check for invariant words that remain the same in singular and plural
  if (_invariantWords.contains(word.toLowerCase()) &&
      word.toLowerCase() != 'mechanics') {
    return word; // Return as-is
  }

  // Handle compound words with internal pluralization
  for (var entry in _compoundPluralPatterns.entries) {
    if (entry.value.toLowerCase() == word.toLowerCase()) {
      return word[0].toUpperCase() == word[0]
          ? _capitalize(entry.key)
          : entry.key;
    }
  }
  for (var entry in _multiWordPlurals.entries) {
    if (entry.value.toLowerCase() == word.toLowerCase()) {
      return word[0].toUpperCase() == word[0]
          ? _capitalize(entry.key)
          : entry.key;
    }
  }
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
  // Check for pattern ending in "men" not in pluralToSingular
  if (lowercaseWord.endsWith('men') &&
      !_pluralToSingular.containsKey(lowercaseWord)) {
    String singular =
        lowercaseWord.substring(0, lowercaseWord.length - 3) + 'man';
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

  // Special patterns that need exact handling
  if (_exactPluralToSingular.containsKey(lowercaseWord)) {
    String singular = _exactPluralToSingular[lowercaseWord]!;
    return isCapitalized ? _capitalize(singular) : singular;
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
          _ieWords.contains(
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
      !_noESRemovalWords.contains(lowercaseWord)) {
    // Just remove the 's' for words like 'houses'
    result = lowercaseWord.substring(0, lowercaseWord.length - 1);
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

/// Words that end in 'y' preceded by a consonant but don't follow y→ies rule
final Set<String> _yExceptions = {
  'monkey',
  'donkey',
  'trolley',
  'journey',
  'valley',
  'chimney',
  'key',
  'bay',
  'day',
  'boy',
  'guy',
  'tray',
  'prey',
  'passerby', // Adding passerby to prevent "passerbies"
  'zombie', // Adding to prevent "zomby" when singularizing
};

/// Words ending in 'man' that don't follow man→men rule
final Set<String> _manExceptions = {
  'human',
  'german',
  'ottoman',
  'talisman',
  'shaman',
  'roman',
};

/// Words that end in 'es' where we should not just remove the 's'
final Set<String> _noESRemovalWords = {
  'axes', // singularize to axis, not axe
  'bases', // singularize to basis, not base
  'crises', // singularize to crisis, not crise
  'testes', // singularize to testis, not teste
  'theses', // singularize to thesis, not these
  'diagnoses', // singularize to diagnosis, not diagnose
  'parentheses', // singularize to parenthesis, not parenthese
  'ellipses', // singularize to ellipsis, not ellipse
  'synopses', // singularize to synopsis, not synopse
  'analyses', // singularize to analysis, not analyse
};

/// Compound words with internal pluralization patterns
final Map<String, String> _compoundPluralPatterns = {
  'mother-in-law': 'mothers-in-law',
  'father-in-law': 'fathers-in-law',
  'brother-in-law': 'brothers-in-law',
  'sister-in-law': 'sisters-in-law',
  'son-in-law': 'sons-in-law',
  'daughter-in-law': 'daughters-in-law',
  'passerby': 'passersby',
  'passer-by': 'passers-by',
  'editor-in-chief': 'editors-in-chief',
  'commander-in-chief': 'commanders-in-chief',
};

/// Multi-word phrases with special pluralization
final Map<String, String> _multiWordPlurals = {
  'attorney general': 'attorneys general',
  'notary public': 'notaries public',
  'governor general': 'governors general',
  'postmaster general': 'postmasters general',
  'court martial': 'courts martial',
};

/// Map for singular to plural of irregular words
final Map<String, String> _singularToPlural = {
  // Man/Woman cases
  'man': 'men',
  'woman': 'women',
  'spokesman': 'spokesmen',
  'policeman': 'policemen',
  'fireman': 'firemen',
  'airman': 'airmen',
  'marksman': 'marksmen',
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
  // Special cases
  'princess': 'princesses',
  'empress': 'empresses',
  'goddess': 'goddesses',
  'waitress': 'waitresses',
  'hostess': 'hostesses',
  'actress': 'actresses',
  'prophetess': 'prophetesses',
  // Wolf/wolves
  'werewolf': 'werewolves',
  // Cyclops
  'cyclops': 'cyclopes',
  // Fresco
  'fresco': 'frescoes',
  // Latin/Greek derived
  'bacterium': 'bacteria',
  'protozoan': 'protozoa',
  'alga': 'algae',
  // Animal cases that remain the same
  'fish': 'fish',
  'deer': 'deer',
  'sheep': 'sheep',
  'moose': 'moose',
  'swine': 'swine',
  'buffalo': 'buffalo',
  'shrimp': 'shrimp',
  'jellyfish': 'jellyfish',
  'plankton': 'plankton',
  // Classic exceptions
  'person': 'people',
  'die': 'dice',
  'ox': 'oxen',
  'penny': 'pence',
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
  'gateau': 'gateaux',
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
  // Updated from octopi to octopuses per test
  'octopus': 'octopuses',
  'platypus': 'platypuses',
  // Exceptions to -us rule
  'virus': 'viruses',
  'status': 'statuses',
  'walrus': 'walruses',
  // Words ending in -a
  'nebula': 'nebulae',
  'vertebra': 'vertebrae',
  'vita': 'vitae',
  // Religious/Cultural terms
  'cherub': 'cherubim',
  'seraph': 'seraphim',
  // Edge cases identified
  'mongoose': 'mongooses',
  'roof': 'roofs',
  'chief': 'chiefs',
  'zombie': 'zombies',
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

/// Words ending in 'ie' where the plural is 'ies'
final Set<String> _ieWords = {
  'cookie',
  'pie',
  'movie',
  'rookie',
  'die',
  'tie',
  'lie',
};

/// Additional exact plural to singular mappings for edge cases
final Map<String, String> _exactPluralToSingular = {
  'cookies': 'cookie',
  'pies': 'pie',
  'grosses': 'gross',
  'mechanics': 'mechanic',
  'movies': 'movie',
  'rookies': 'rookie',
  'ties': 'tie',
  'lies': 'lie',
};

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
  'fresco', // Adding since it appears in test cases
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
  'werewolf', // Added since it appears in the test cases
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

/// Words that remain the same in both singular and plural form
final Set<String> _invariantWords = {
  'diabetes',
  'measles',
  'mumps',
  'rickets',
  'physics',
  'economics',
  'mathematics',
  'ethics',
  'politics',
  'statistics',
  'linguistics',
  'dynamics',
  // Removing 'mechanics' as it needs special handling
  'electrics',
  'optics',
  'acoustics',
  'athletics',
  'billiards',
  'darts',
  'dominoes',
  'draughts',
  'gymnastics',
  'aerobics',
  'aeronautics',
  'genetics',
  'herpes',
  'rabies',
  'scabies',
  'shingles',
  'news',
  'series',
  'species',
  'fish',
  'sheep',
  'deer',
  'moose',
  'aircraft',
  'spacecraft',
  'corps',
  'scissors',
  'means',
  'headquarters',
  'crossroads',
  'innings',
  'salmon',
  'trout',
  'jellyfish', // Adding from test cases
  'plankton', // Adding from test cases
};

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
  'platypus', // Added from test cases
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
  'cyclops', // Added from test cases
  // Adding academic/medical terms that are singular despite ending in 's'
  'diabetes',
  'measles',
  'mumps',
  'rickets',
  'physics',
  'economics',
  'mathematics',
  'ethics',
  'politics',
  'statistics',
  'linguistics',
  'dynamics',
  'mechanics',
  'electrics',
  'optics',
  'acoustics',
  'athletics',
  'billiards',
  'darts',
  'dominoes',
  'draughts',
  'gymnastics',
  'aerobics',
  'aeronautics',
  'genetics',
  'herpes',
  'rabies',
  'scabies',
  'shingles',
};

/// Test code to verify functionality
void main() {
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
