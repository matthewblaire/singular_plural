/// Words that end in 'y' preceded by a consonant but don't follow y→ies rule
final Set<String> yExceptions = {
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
final Set<String> manExceptions = {
  'human',
  'german',
  'ottoman',
  'talisman',
  'shaman',
  'roman',
};

/// Words that end in 'es' where we should not just remove the 's'
final Set<String> noESRemovalWords = {
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
final Map<String, String> compoundPluralPatterns = {
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
final Map<String, String> multiWordPlurals = {
  'attorney general': 'attorneys general',
  'notary public': 'notaries public',
  'governor general': 'governors general',
  'postmaster general': 'postmasters general',
  'court martial': 'courts martial',
};

/// Map for singular to plural of irregular words
final Map<String, String> singularToPlural = {
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
final Map<String, String> pluralToSingular = Map.fromEntries(
  singularToPlural.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Words ending in 'ie' where the plural is 'ies'
final Set<String> ieWords = {
  'cookie',
  'pie',
  'movie',
  'rookie',
  'die',
  'tie',
  'lie',
};

/// Additional exact plural to singular mappings for edge cases
final Map<String, String> exactPluralToSingular = {
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
final Set<String> oToEsPlurals = {
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
final Set<String> fToVesPlurals = {
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

/// Automatically generate plurals for oToEsPlurals
final Map<String, String> oPlurals = Map.fromEntries(
  oToEsPlurals.map((word) => MapEntry(word, word + 'es')),
);

/// Automatically generate plurals for fToVesPlurals
final Map<String, String> fPlurals = Map.fromEntries(
  fToVesPlurals.map((word) {
    if (word.endsWith('fe')) {
      return MapEntry(word, word.substring(0, word.length - 2) + 'ves');
    } else {
      return MapEntry(word, word.substring(0, word.length - 1) + 'ves');
    }
  }),
);

/// Automatically generate the reverse mappings
final Map<String, String> esToOPlurals = Map.fromEntries(
  oPlurals.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Mapping from plural 'ves' forms back to singular 'f/fe' forms
final Map<String, String> vesToFPlurals = Map.fromEntries(
  fPlurals.entries.map((entry) => MapEntry(entry.value, entry.key)),
);

/// Words that remain the same in both singular and plural form
final Set<String> invariantWords = {
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
final Set<String> singleFormEndingInS = {
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
