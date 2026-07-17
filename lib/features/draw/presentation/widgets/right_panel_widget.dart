
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';
import 'package:abc123/features/draw/presentation/providers/balloon_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightPanelWidget extends StatelessWidget {
  const RightPanelWidget({
    required this.tanimaText,
    required this.isLoading,
    super.key,
    this.isSequentialMode = false,
  });

  final String tanimaText;
  final bool isLoading;
  final bool isSequentialMode;

  int _getNumberFromText() {
    if (tanimaText.isEmpty || isLoading) return 0;
    final regExp = RegExp(r'(\d+)');
    final match = regExp.firstMatch(tanimaText);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '0') ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BalloonGameProvider(),
      child: _RightPanelContent(
        number: _getNumberFromText(),
        isLoading: isLoading,
      ),
    );
  }
}

class _RightPanelContent extends StatelessWidget {
  const _RightPanelContent({
    required this.number,
    required this.isLoading,
  });

  final int number;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final provider = context.watch<BalloonGameProvider>();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: AppSizes.imageSize(context) * 3.2,
        maxHeight: AppSizes.imageSize(context) * 9.8,
      ),
      child: Container(
        margin: EdgeInsets.only(
          right: AppSizes.paddingNormal(context),
          top: AppSizes.paddingSmall(context),
          bottom: AppSizes.paddingSmall(context),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.height * 0.015,
                        horizontal: responsive.width * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bubble_chart,
                            color: Colors.white,
                            size: responsive.smallIconSize,
                          ),
                        ],
                      ),
                    ),
                    if (provider.isGameStarted)
                      _ScorePanel(
                        score: provider.score,
                        remainingBalloons: provider.remainingBalloons,
                        totalBalloons: provider.totalBalloons,
                        level: provider.currentLevel,
                        timeLeft: provider.timeLeft,
                        responsive: responsive,
                      ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(responsive.height * 0.015),
                        child: isLoading
                            ? const _LoadingContent()
                            : provider.isGameStarted
                                ? const _GameContent()
                                : number > 0
                                    ? _StartGamePrompt(number: number)
                                    : const _EmptyContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameContent extends StatelessWidget {
  const _GameContent();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BalloonGameProvider>();
    final responsive = ResponsiveSize(context);

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue.shade100, Colors.blue.shade50],
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<BalloonGameProvider>().updateGameAreaSize(
                          constraints.maxWidth,
                          constraints.maxHeight,
                        );
                  });

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ...provider.balloons.asMap().entries.map((entry) {
                        final index = entry.key;
                        final balloon = entry.value;

                        return Positioned(
                          left: balloon.x,
                          top: balloon.y,
                          child: GestureDetector(
                            onTap: () => context.read<BalloonGameProvider>().popBalloon(index),
                            child: Container(
                              width: balloon.size,
                              height: balloon.size,
                              decoration: BoxDecoration(
                                color: balloon.color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: balloon.size * 0.25,
                                    height: balloon.size * 0.25,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: balloon.size / 2 - 1,
                                    child: Container(
                                      width: 2,
                                      height: balloon.size * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      if (provider.poppedBalloons + provider.missedBalloons >=
                              provider.totalBalloons &&
                          provider.totalBalloons > 0)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(responsive.width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  context.drawL10n!.drawCongratulations,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.subtitleFontSize * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: responsive.height * 0.01),
                                Text(
                                  context.drawL10n!.drawAllBalloonsPopped,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.bodyFontSize * 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            radius: responsive.width * 0.02,
            child: IconButton(
              tooltip: provider.isGamePaused
                  ? context.drawL10n!.drawSemanticResumeGame
                  : context.drawL10n!.drawSemanticPauseGame,
              icon: Icon(provider.isGamePaused ? Icons.play_arrow : Icons.pause),
              onPressed: () => context.read<BalloonGameProvider>().pauseGame(),
              color: ColorScheme.of(context).primary,
              iconSize: (responsive.width * 0.015).clamp(20.0, 28.0),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
            ),
          ),
        ),
        if (provider.isGamePaused)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.drawL10n!.drawGamePausedTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.subtitleFontSize * 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: responsive.height * 0.02),
                  ElevatedButton.icon(
                    onPressed: () => context.read<BalloonGameProvider>().pauseGame(),
                    icon: const Icon(Icons.play_arrow),
                    label: Text(context.drawL10n!.drawContinue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorScheme.of(context).primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.width * 0.02,
                        vertical: responsive.height * 0.012,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _StartGamePrompt extends StatelessWidget {
  const _StartGamePrompt({required this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final l10n = context.drawL10n!;
    final balloonCount = number.clamp(1, 20);

    return Stack(
      children: [
        const Positioned.fill(
          child: _BackgroundBalloons(),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(responsive.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bubble_chart,
                  color: ColorScheme.of(context).primary,
                  size: responsive.smallIconSize * 2,
                ),
                SizedBox(height: responsive.height * 0.015),
                Text(
                  l10n.drawBalloonReady(balloonCount),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.subtitleFontSize * 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: responsive.height * 0.01),
                Text(
                  l10n.drawBalloonScoreHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.bodyFontSize,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                ElevatedButton.icon(
                  onPressed: () => context.read<BalloonGameProvider>().startGame(number),
                  icon: const Icon(Icons.play_arrow),
                  label: Text(l10n.drawStartGame),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorScheme.of(context).primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.width * 0.03,
                      vertical: responsive.height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: ColorScheme.of(context).primary,
          strokeWidth: 4,
        ),
        SizedBox(height: responsive.height * 0.015),
        Text(
          context.drawL10n!.drawBalloonsPreparing,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.subtitleFontSize * 1.1,
            fontWeight: FontWeight.bold,
            color: ColorScheme.of(context).primary,
          ),
        ),
      ],
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    return Stack(
      children: [
        const Positioned.fill(
          child: _BackgroundBalloons(),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(responsive.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bubble_chart,
                  color: Colors.grey,
                  size: responsive.smallIconSize * 2,
                ),
                SizedBox(height: responsive.height * 0.01),
                Text(
                  context.drawL10n!.drawNoBalloonsYet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.bodyFontSize * 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: responsive.height * 0.008),
                Text(
                  context.drawL10n!.drawStartBalloonGameByDrawing,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.bodyFontSize * 1.1,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScorePanel extends StatelessWidget {
  const _ScorePanel({
    required this.score,
    required this.remainingBalloons,
    required this.totalBalloons,
    required this.level,
    required this.timeLeft,
    required this.responsive,
  });

  final int score;
  final int remainingBalloons;
  final int totalBalloons;
  final int level;
  final int timeLeft;
  final ResponsiveSize responsive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.stars,
          color: Colors.amber,
          value: score.toString(),
          tooltip: context.drawL10n!.drawScore,
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.bubble_chart,
          color: Colors.blue,
          value: '$remainingBalloons/$totalBalloons',
          tooltip: context.drawL10n!.drawBalloonCount,
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.trending_up,
          color: Colors.purple,
          value: level.toString(),
          tooltip: context.drawL10n!.drawLevel,
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.timer,
          color: Colors.red,
          value: timeLeft.toString(),
          tooltip: context.drawL10n!.drawTimeLeft,
        ),
      ],
    );
  }

  Widget _buildGameStatusIcon({
    required ResponsiveSize responsive,
    required IconData icon,
    required Color color,
    required String value,
    required String tooltip,
  }) {
    final iconSize = responsive.width * 0.022;
    final innerIconSize = responsive.width * 0.012;
    final badgeSize = responsive.width * 0.011;
    final badgeFontSize = responsive.width * 0.006;
    final margin = responsive.width * 0.001;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: Tooltip(
        message: tooltip,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
            Icon(icon, color: color, size: innerIconSize),
            Positioned(
              bottom: 0,
              right: -responsive.width * 0.001,
              child: Container(
                padding: EdgeInsets.all(responsive.width * 0.0005),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.2),
                ),
                constraints: BoxConstraints(
                  minWidth: badgeSize,
                  minHeight: badgeSize,
                ),
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: badgeFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundBalloons extends StatelessWidget {
  const _BackgroundBalloons();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade50, Colors.blue.shade100],
          ),
        ),
      ),
    );
  }
}
