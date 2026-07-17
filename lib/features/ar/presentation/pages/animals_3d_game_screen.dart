import 'dart:math';

import 'package:abc123/features/ar/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Veri modeli
// ─────────────────────────────────────────────────────────────────────────────

class _Animal {
  const _Animal({
    required this.id,
    required this.assetPath,
    required this.emoji,
    required this.color,
    required this.darkColor,
  });

  final String id;
  final String assetPath;
  final String emoji;
  final Color color;
  final Color darkColor;
}

const List<_Animal> _animals = [
  _Animal(
    id: 'at',
    assetPath: 'assets/models/ar/at.glb',
    emoji: '🐴',
    color: Color(0xFF8B5E3C),
    darkColor: Color(0xFF5C3A1E),
  ),
  _Animal(
    id: 'balik',
    assetPath: 'assets/models/ar/balik.glb',
    emoji: '🐟',
    color: Color(0xFF2196F3),
    darkColor: Color(0xFF1565C0),
  ),
  _Animal(
    id: 'civciv',
    assetPath: 'assets/models/ar/civciv.glb',
    emoji: '🐥',
    color: Color(0xFFFFB300),
    darkColor: Color(0xFFE65100),
  ),
  _Animal(
    id: 'domuz',
    assetPath: 'assets/models/ar/domuz.glb',
    emoji: '🐷',
    color: Color(0xFFFF8A80),
    darkColor: Color(0xFFC62828),
  ),
  _Animal(
    id: 'kedi',
    assetPath: 'assets/models/ar/kedi.glb',
    emoji: '🐱',
    color: Color(0xFF9C27B0),
    darkColor: Color(0xFF6A1B9A),
  ),
  _Animal(
    id: 'elma',
    assetPath: 'assets/models/ar/elma.glb',
    emoji: '🍎',
    color: Color(0xFFE53935),
    darkColor: Color(0xFFB71C1C),
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Ana ekran — 4 sayfa: Landing → Gallery → Detail → Quiz
// ─────────────────────────────────────────────────────────────────────────────

class Animals3DGameScreen extends StatefulWidget {
  const Animals3DGameScreen({super.key});

  @override
  State<Animals3DGameScreen> createState() => _Animals3DGameScreenState();
}

class _Animals3DGameScreenState extends State<Animals3DGameScreen>
    with TickerProviderStateMixin {
  int _page = 0; // 0=landing, 1=gallery, 2=detail, 3=quiz
  _Animal? _selectedAnimal;

  late final AnimationController _bgController;
  late final Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _bgAnim = CurvedAnimation(parent: _bgController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnim,
        builder: (_, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF0D2B14),
                    const Color(0xFF1A3A26),
                    _bgAnim.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF1B4332),
                    const Color(0xFF0A1F14),
                    _bgAnim.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF081C0E),
                    const Color(0xFF163020),
                    _bgAnim.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
            ),
            child: switch (_page) {
              0 => _LandingPage(
                  key: const ValueKey('landing'),
                  onStart: () => setState(() => _page = 1),
                  onQuiz: () => setState(() => _page = 3),
                  onBack: () => Navigator.of(context).pop(),
                ),
              1 => _GalleryPage(
                  key: const ValueKey('gallery'),
                  onAnimal: (a) => setState(() {
                    _selectedAnimal = a;
                    _page = 2;
                  }),
                  onBack: () => setState(() => _page = 0),
                  onQuiz: () => setState(() => _page = 3),
                ),
              2 => _DetailPage(
                  key: ValueKey('detail_${_selectedAnimal?.id}'),
                  animal: _selectedAnimal!,
                  onBack: () => setState(() => _page = 1),
                  onQuiz: () => setState(() => _page = 3),
                ),
              3 => _QuizPage(
                  key: const ValueKey('quiz'),
                  onBack: () => setState(() => _page = 1),
                ),
              _ => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Landing Sayfası
// ─────────────────────────────────────────────────────────────────────────────

class _LandingPage extends StatefulWidget {
  const _LandingPage({
    required this.onStart,
    required this.onQuiz,
    required this.onBack,
    super.key,
  });

  final VoidCallback onStart;
  final VoidCallback onQuiz;
  final VoidCallback onBack;

  @override
  State<_LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<_LandingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceCtrl;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _GlassButton(
                onTap: widget.onBack,
                child: const Icon(Icons.close_rounded,
                    color: Colors.white70, size: 22),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _bounce,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, _bounce.value),
                    child: child,
                  ),
                  child: const Text('🦁', style: TextStyle(fontSize: 100)),
                ),
                const SizedBox(height: 32),
                const Text(
                  '3D Hayvanlar',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                    shadows: [
                      Shadow(
                        color: Color(0x88000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.arL10n.arAnimals3dDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _animals
                      .map((a) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(a.emoji,
                                style: const TextStyle(fontSize: 28)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 40),
                _BigButton(
                  label: context.arL10n.arAnimalsExplore,
                  color: const Color(0xFF43C87A),
                  darkColor: const Color(0xFF27944F),
                  onTap: widget.onStart,
                ),
                const SizedBox(height: 16),
                _BigButton(
                  label: context.arL10n.arAnimalsQuizMode,
                  color: const Color(0xFF7C4DFF),
                  darkColor: const Color(0xFF5727CC),
                  onTap: widget.onQuiz,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Galeri Sayfası
// ─────────────────────────────────────────────────────────────────────────────

class _GalleryPage extends StatelessWidget {
  const _GalleryPage({
    required this.onAnimal,
    required this.onBack,
    required this.onQuiz,
    super.key,
  });

  final void Function(_Animal) onAnimal;
  final VoidCallback onBack;
  final VoidCallback onQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _GlassButton(
                onTap: onBack,
                child: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white70, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '🐾 Hayvanları Keşfet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              _GlassButton(
                onTap: onQuiz,
                child: const Text('🎮', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemCount: _animals.length,
              itemBuilder: (context, i) {
                final animal = _animals[i];
                return _AnimalCard(
                  animal: animal,
                  onTap: () => onAnimal(animal),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hayvan Kartı
// ─────────────────────────────────────────────────────────────────────────────

class _AnimalCard extends StatefulWidget {
  const _AnimalCard({required this.animal, required this.onTap});

  final _Animal animal;
  final VoidCallback onTap;

  @override
  State<_AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<_AnimalCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.animal;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                a.color.withValues(alpha: 0.85),
                a.darkColor.withValues(alpha: 0.95),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: a.darkColor.withValues(alpha: 0.5),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(a.emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 10),
              Text(
                context.getArModelName(a.id),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  context.arL10n.arAnimalsView3d,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Detay / 3D Görüntüleme Sayfası
// ─────────────────────────────────────────────────────────────────────────────

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    required this.animal,
    required this.onBack,
    required this.onQuiz,
    super.key,
  });

  final _Animal animal;
  final VoidCallback onBack;
  final VoidCallback onQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _GlassButton(
                onTap: onBack,
                child: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white70, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                '${animal.emoji}  ${context.getArModelName(animal.id)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              _GlassButton(
                onTap: onQuiz,
                child: const Text('🎮', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ModelViewer(
            src: animal.assetPath,
            alt: '${context.getArModelName(animal.id)} 3D modeli',
            ar: true,
            arModes: const ['scene-viewer', 'webxr', 'quick-look'],
            autoRotate: true,
            autoRotateDelay: 0,
            rotationPerSecond: '30deg',
            cameraControls: true,
            shadowIntensity: 1,
            shadowSoftness: 1,
            backgroundColor: Colors.transparent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(animal.emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Text(
                      context.getArModelName(animal.id),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '💡 ${context.getArAnimalFact(animal.id)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.arL10n.arAnimalsInstruction,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.55),
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

// ─────────────────────────────────────────────────────────────────────────────
// Quiz Sayfası
// ─────────────────────────────────────────────────────────────────────────────

class _QuizPage extends StatefulWidget {
  const _QuizPage({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  State<_QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<_QuizPage> with TickerProviderStateMixin {
  late _Animal _currentAnimal;
  late List<_Animal> _choices;
  int _score = 0;
  int _round = 0;
  bool _answered = false;
  _Animal? _picked;

  late final AnimationController _confettiCtrl;
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shake;

  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _confettiCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shake = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
    _nextQuestion();
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    final shuffled = [..._animals]..shuffle(_rng);
    _currentAnimal = shuffled.first;
    final wrongPool = shuffled.skip(1).take(3).toList();
    _choices = [...wrongPool, _currentAnimal]..shuffle(_rng);
    setState(() {
      _answered = false;
      _picked = null;
    });
  }

  void _pick(_Animal choice) {
    if (_answered) return;
    setState(() {
      _picked = choice;
      _answered = true;
    });
    if (choice == _currentAnimal) {
      _score++;
      // ignore: discarded_futures
      _confettiCtrl.forward(from: 0);
      // ignore: discarded_futures
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _round++;
          _nextQuestion();
        }
      });
    } else {
      // ignore: discarded_futures
      _shakeCtrl.forward(from: 0);
      // ignore: discarded_futures
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          _round++;
          _nextQuestion();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = _picked == _currentAnimal;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  _GlassButton(
                    onTap: widget.onBack,
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white70, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '🎮 Quiz',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFF43C87A).withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: const Color(0xFF43C87A).withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      '⭐ $_score / $_round',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
              child: Text(
                'Bu 3D hayvan hangisi?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: AnimatedBuilder(
                animation: _shake,
                builder: (_, child) {
                  final offset = _answered && !isCorrect
                      ? sin(_shake.value * pi * 8) * 14
                      : 0.0;
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: ModelViewer(
                  key: ValueKey(_currentAnimal.assetPath),
                  src: _currentAnimal.assetPath,
                  alt: '${context.getArModelName(_currentAnimal.id)} 3D modeli',
                  autoRotate: true,
                  autoRotateDelay: 0,
                  rotationPerSecond: '20deg',
                  cameraControls: true,
                  shadowIntensity: 1,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.6,
                ),
                itemCount: _choices.length,
                itemBuilder: (ctx, i) {
                  final choice = _choices[i];
                  final isPicked = _picked == choice;
                  final isRight = choice == _currentAnimal;

                  Color bg;
                  if (!_answered) {
                    bg = Colors.white.withValues(alpha: 0.10);
                  } else if (isRight) {
                    bg = const Color(0xFF43C87A).withValues(alpha: 0.35);
                  } else if (isPicked) {
                    bg = Colors.red.withValues(alpha: 0.30);
                  } else {
                    bg = Colors.white.withValues(alpha: 0.04);
                  }

                  return GestureDetector(
                    onTap: () => _pick(choice),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _answered && isRight
                              ? const Color(0xFF43C87A)
                              : _answered && isPicked
                                  ? Colors.red
                                  : Colors.white.withValues(alpha: 0.18),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(choice.emoji,
                              style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 8),
                          Text(
                            context.getArModelName(choice.id),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          if (_answered && isRight)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Text('✅',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          if (_answered && isPicked && !isRight)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Text('❌',
                                  style: TextStyle(fontSize: 16)),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        if (_answered && isCorrect)
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _confettiCtrl,
              builder: (_, __) => CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _ConfettiPainter(
                  progress: _confettiCtrl.value,
                  rng: _rng,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Konfeti Painter
// ─────────────────────────────────────────────────────────────────────────────

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress, required this.rng});

  final double progress;
  final Random rng;

  static final List<Color> _colors = [
    const Color(0xFF43C87A),
    const Color(0xFFFFD700),
    const Color(0xFFFF6B6B),
    const Color(0xFF74B9FF),
    const Color(0xFFA29BFE),
    Colors.white,
  ];

  static final _particles = List.generate(50, (i) {
    final r = Random(i * 37 + 13);
    return (
      x: r.nextDouble(),
      vy: 0.4 + r.nextDouble() * 0.6,
      vx: (r.nextDouble() - 0.5) * 0.4,
      size: 6.0 + r.nextDouble() * 8,
      color: _colors[r.nextInt(_colors.length)],
      rot: r.nextDouble() * 2 * 3.14159,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0 || progress == 1) return;
    for (final p in _particles) {
      final x = (p.x + p.vx * progress) * size.width;
      final y = (p.vy * progress) * size.height;
      final rot = p.rot + progress * 6;
      final opacity = (1 - progress * 1.2).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.5,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Yardımcı widget'lar
// ─────────────────────────────────────────────────────────────────────────────

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1.2,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _BigButton extends StatefulWidget {
  const _BigButton({
    required this.label,
    required this.color,
    required this.darkColor,
    required this.onTap,
  });

  final String label;
  final Color color;
  final Color darkColor;
  final VoidCallback onTap;

  @override
  State<_BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<_BigButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        // ignore: discarded_futures
        _ctrl.forward();
      },
      onTapUp: (_) {
        // ignore: discarded_futures
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        // ignore: discarded_futures
        _ctrl.reverse();
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.color, widget.darkColor],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: widget.darkColor.withValues(alpha: 0.55),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
