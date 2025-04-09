import 'package:singular_plural/singular_plural.dart';
import 'package:singular_plural/src/constants.dart';
import 'package:singular_plural/src/test_cases.dart';
import 'package:test/test.dart';

void main() {
  group('Pluralization tests', () {
    for (final testCase in testCases) {
      final singular = testCase[0];
      final plural = testCase[1];

      test('pluralize "$singular" → "$plural"', () {
        yExceptions;
        manExceptions;
        noESRemovalWords;
        compoundPluralPatterns;
        multiWordPlurals;
        singularToPlural;
        pluralToSingular;
        ieWords;
        exactPluralToSingular;
        oToEsPlurals;
        fToVesPlurals;
        oPlurals;
        fPlurals;
        esToOPlurals;
        vesToFPlurals;
        invariantWords;
        singleFormEndingInS;
        expect(pluralize(singular), equals(plural));
      });
    }
  });

  group('Singularization tests', () {
    for (final testCase in testCases) {
      final singular = testCase[0];
      final plural = testCase[1];

      test('singularize "$plural" → "$singular"', () {
        yExceptions;
        manExceptions;
        noESRemovalWords;
        compoundPluralPatterns;
        multiWordPlurals;
        singularToPlural;
        pluralToSingular;
        ieWords;
        exactPluralToSingular;
        oToEsPlurals;
        fToVesPlurals;
        oPlurals;
        fPlurals;
        esToOPlurals;
        vesToFPlurals;
        invariantWords;
        singleFormEndingInS;
        expect(singularize(plural), equals(singular));
      });
    }
  });

  group('Case preservation tests', () {
    test('pluralize preserves capitalization', () {
      yExceptions;
      manExceptions;
      noESRemovalWords;
      compoundPluralPatterns;
      multiWordPlurals;
      singularToPlural;
      pluralToSingular;
      ieWords;
      exactPluralToSingular;
      oToEsPlurals;
      fToVesPlurals;
      oPlurals;
      fPlurals;
      esToOPlurals;
      vesToFPlurals;
      invariantWords;
      singleFormEndingInS;
      expect(pluralize('Apple'), equals('Apples'));
      expect(pluralize('BRICK'), equals('BRICKS'));
      expect(pluralize('CamelCase'), equals('CamelCases'));
    });

    test('singularize preserves capitalization', () {
      yExceptions;
      manExceptions;
      noESRemovalWords;
      compoundPluralPatterns;
      multiWordPlurals;
      singularToPlural;
      pluralToSingular;
      ieWords;
      exactPluralToSingular;
      oToEsPlurals;
      fToVesPlurals;
      oPlurals;
      fPlurals;
      esToOPlurals;
      vesToFPlurals;
      invariantWords;
      singleFormEndingInS;
      expect(singularize('Apples'), equals('Apple'));
      expect(singularize('BRICKS'), equals('BRICK'));
      expect(singularize('CamelCases'), equals('CamelCase'));
    });
  });
}
