import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:abc123/features/home/presentation/widgets/home_learning_mode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeLearningModeCard shows title and subtitle', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 180,
            height: 180,
            child: HomeLearningModeCard(
              title: 'Rakamlar',
              subtitle: '0–9 çiz',
              baseColor: HomeDesignTokens.numbersCard,
              image: const Icon(Icons.image, color: Colors.white),
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Rakamlar'), findsOneWidget);
    expect(find.text('0–9 çiz'), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('HomeTab grid uses two columns', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              4,
              (_) => HomeLearningModeCard(
                title: 'Test',
                subtitle: 'Sub',
                baseColor: HomeDesignTokens.numbersCard,
                image: const Icon(Icons.image, color: Colors.white),
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    expect(grid.gridDelegate, isA<SliverGridDelegateWithFixedCrossAxisCount>());
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 2);
  });
}
