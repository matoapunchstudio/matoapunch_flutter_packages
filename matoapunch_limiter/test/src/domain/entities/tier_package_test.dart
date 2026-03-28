// Not required for test files.
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_limiter/matoapunch_limiter.dart';

void main() {
  group('TierPackage', () {
    final limitations = [
      Limitation(
        name: 'max_projects',
        displayName: 'Maximum Projects',
        type: LimitationType.count,
        value: 5,
      ),
      Limitation(
        name: 'enable_export',
        displayName: 'Export Feature',
        type: LimitationType.boolean,
        value: 1,
      ),
    ];

    test('can be instantiated with required fields', () {
      final package = TierPackage(
        id: 'pkg_pro',
        code: 'pro',
        name: 'pro',
        displayName: 'Pro',
        limitations: limitations,
      );

      expect(package.id, 'pkg_pro');
      expect(package.code, 'pro');
      expect(package.name, 'pro');
      expect(package.displayName, 'Pro');
      expect(package.description, '');
      expect(package.rank, 0);
      expect(package.isActive, isTrue);
      expect(package.limitations, limitations);
    });

    test('finds a limitation by name', () {
      final package = TierPackage(
        id: 'pkg_pro',
        code: 'pro',
        name: 'pro',
        displayName: 'Pro',
        limitations: limitations,
      );

      expect(package.limitationByName('max_projects'), limitations.first);
      expect(package.limitationByName('missing_limit'), isNull);
    });

    test('parses from snake_case json', () {
      final json = <String, dynamic>{
        'id': 'pkg_pro',
        'code': 'pro',
        'name': 'pro',
        'display_name': 'Pro',
        'description': 'Professional tier',
        'rank': 2,
        'is_active': false,
        'limitations': [
          {
            'name': 'max_projects',
            'display_name': 'Maximum Projects',
            'type': 'count',
            'value': 5,
          },
        ],
      };

      final package = TierPackage.fromJson(json);

      expect(package.id, 'pkg_pro');
      expect(package.code, 'pro');
      expect(package.name, 'pro');
      expect(package.displayName, 'Pro');
      expect(package.description, 'Professional tier');
      expect(package.rank, 2);
      expect(package.isActive, isFalse);
      expect(package.limitations, hasLength(1));
      expect(package.limitations.first.name, 'max_projects');
    });

    test('roundtrips to json', () {
      final original = TierPackage(
        id: 'pkg_pro',
        code: 'pro',
        name: 'pro',
        displayName: 'Pro',
        description: 'Professional tier',
        rank: 2,
        isActive: false,
        limitations: limitations,
      );

      final restored = TierPackage.fromJson(original.toJson());

      expect(restored, original);
    });

    group('comparison methods', () {
      test('isHigherThan returns true when rank is higher', () {
        final pro = TierPackage(
          id: 'pkg_pro',
          code: 'pro',
          name: 'pro',
          displayName: 'Pro',
          rank: 2,
          limitations: limitations,
        );
        final free = TierPackage(
          id: 'pkg_free',
          code: 'free',
          name: 'free',
          displayName: 'Free',
          limitations: limitations,
        );

        expect(pro.isHigherThan(free), isTrue);
        expect(free.isHigherThan(pro), isFalse);
      });

      test('isLowerThan returns true when rank is lower', () {
        final pro = TierPackage(
          id: 'pkg_pro',
          code: 'pro',
          name: 'pro',
          displayName: 'Pro',
          rank: 2,
          limitations: limitations,
        );
        final free = TierPackage(
          id: 'pkg_free',
          code: 'free',
          name: 'free',
          displayName: 'Free',
          limitations: limitations,
        );

        expect(free.isLowerThan(pro), isTrue);
        expect(pro.isLowerThan(free), isFalse);
      });

      test('isEqualRank returns true when ranks are equal', () {
        final pro1 = TierPackage(
          id: 'pkg_pro1',
          code: 'pro1',
          name: 'pro1',
          displayName: 'Pro 1',
          rank: 2,
          limitations: limitations,
        );
        final pro2 = TierPackage(
          id: 'pkg_pro2',
          code: 'pro2',
          name: 'pro2',
          displayName: 'Pro 2',
          rank: 2,
          limitations: limitations,
        );

        expect(pro1.isEqualRank(pro2), isTrue);
        expect(pro2.isEqualRank(pro1), isTrue);
      });

      test('isEqualRank returns false when ranks differ', () {
        final pro = TierPackage(
          id: 'pkg_pro',
          code: 'pro',
          name: 'pro',
          displayName: 'Pro',
          rank: 2,
          limitations: limitations,
        );
        final free = TierPackage(
          id: 'pkg_free',
          code: 'free',
          name: 'free',
          displayName: 'Free',
          limitations: limitations,
        );

        expect(pro.isEqualRank(free), isFalse);
      });
    });
  });
}
