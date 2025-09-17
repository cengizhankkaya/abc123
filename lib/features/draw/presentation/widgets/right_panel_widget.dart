import 'dart:async';
import 'dart:math';

import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';

class RightPanelWidget extends StatefulWidget {
  final String tanimaText;
  final bool isLoading;
  final bool isSequentialMode;

  const RightPanelWidget({
    super.key,
    required this.tanimaText,
    required this.isLoading,
    this.isSequentialMode = false,
  });

  @override
  State<RightPanelWidget> createState() => _RightPanelWidgetState();
}

class _RightPanelWidgetState extends State<RightPanelWidget>
    with TickerProviderStateMixin {
  int _score = 0;
  bool _isGameStarted = false;
  bool _isGamePaused = false;
  int _timeLeft = 30; // 30 saniyelik oyun
  Timer? _gameTimer;
  final List<Balloon> _balloons = [];
  final List<Timer> _balloonTimers = []; // Balon timerları için liste ekledik
  final Random _random = Random();
  int _currentLevel = 1;
  int _poppedBalloons = 0;
  int _missedBalloons = 0;
  int _totalBalloons = 0; // Toplam balon sayısı
  int _remainingBalloons = 0; // Kalan balon sayısı

  // Oyun alanı boyutları
  late double _gameWidth;
  late double _gameHeight;

  // Dispose edilip edilmediğini takip etmek için bir bayrak
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSize();
    });
  }

  void _initializeSize() {
    if (!mounted || _disposed) return;

    final responsive = ResponsiveSize(context);
    _gameWidth = responsive.width * 0.33;
    _gameHeight = responsive.height * 0.75;
  }

  // Tanıma metninden rakam değerini çıkarır
  int _getNumberFromText() {
    // Eğer metin boş veya yükleniyor ise varsayılan değer
    if (widget.tanimaText.isEmpty || widget.isLoading) {
      return 0;
    }
    // Metinden rakam değerini çıkarmaya çalış
    RegExp regExp = RegExp(r'(\d+)');
    var match = regExp.firstMatch(widget.tanimaText);

    if (match != null) {
      return int.tryParse(match.group(1) ?? "0") ?? 0;
    }
    return 0;
  }

  @override
  void dispose() {
    _disposed = true;
    _cleanupTimers();
    super.dispose();
  }

  void _cleanupTimers() {
    _gameTimer?.cancel();
    _gameTimer = null;

    // Tüm timer'ları iptal et
    for (var timer in List<Timer>.from(_balloonTimers)) {
      try {
        timer.cancel();
      } catch (e) {
        // Sessizce hatayı yoksay
        debugPrint("Timer iptal hatası: $e");
      }
    }
    _balloonTimers.clear();
  }

  // Normal setState yerine Güvenli setState metodu kullanıyoruz
  void _safeSetState(VoidCallback fn) {
    if (mounted && !_disposed) {
      try {
        setState(fn);
      } catch (e) {
        debugPrint("setState hatası: $e");
        // Hata durumunda temizlik yap
        _cleanupTimers();
      }
    }
  }

  void _startGame() {
    if (!mounted || _disposed) return;

    // Çizilen rakamı al - bu sayıda balon olacak
    final drawnNumber = _getNumberFromText();
    // Sayı sınırlaması (1-20 arası bir sayı)
    final balloonCount = drawnNumber.clamp(1, 20);

    _safeSetState(() {
      _isGameStarted = true;
      _score = 0;
      _timeLeft = 30;
      _poppedBalloons = 0;
      _missedBalloons = 0;
      _currentLevel = 1;
      _totalBalloons = balloonCount;
      _remainingBalloons = balloonCount;
      _balloons.clear();
    });

    // Oyun saati başlat
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _safeSetState(() {
          _timeLeft--;
        });

        // Her seviyede zorluk artışı
        if (_poppedBalloons >= _currentLevel * 3) {
          _safeSetState(() {
            _currentLevel++;
          });
        }

        // Ekrandaki balon sayısı 5'ten az ve daha oluşturulacak balon varsa yeni balon ekle
        if (_balloons.length < 5 &&
            _poppedBalloons + _missedBalloons + _balloons.length <
                _totalBalloons) {
          _createBalloon();
        }
      } else {
        _stopGame();
      }
    });

    // Başlangıçta balonları oluştur (max 5 adet)
    final initialBalloons = min(5, balloonCount);
    for (int i = 0; i < initialBalloons; i++) {
      _createBalloon();
    }
  }

  void _pauseGame() {
    if (!mounted || _disposed) return;

    _safeSetState(() {
      _isGamePaused = !_isGamePaused;
    });

    if (_isGamePaused) {
      _gameTimer?.cancel();
    } else {
      // Oyuna devam et
      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeLeft > 0) {
          _safeSetState(() {
            _timeLeft--;
          });

          // Ekrandaki balon sayısı 5'ten az ve daha oluşturulacak balon varsa yeni balon ekle
          if (_balloons.length < 5 &&
              _poppedBalloons + _missedBalloons + _balloons.length <
                  _totalBalloons) {
            _createBalloon();
          }
        } else {
          _stopGame();
        }
      });
    }
  }

  void _stopGame() {
    if (!mounted || _disposed) return;

    _cleanupTimers();

    _safeSetState(() {
      _isGameStarted = false;
      _isGamePaused = false;
      _balloons.clear();
    });
  }

  void _createBalloon() {
    if (!mounted || _disposed) return;

    // Tüm balonlar oluşturulmuşsa daha fazla oluşturma
    if (_poppedBalloons + _missedBalloons + _balloons.length >=
        _totalBalloons) {
      return;
    }

    // Balon boyutu ekran boyutuna göre ayarlanır
    final minSize = _gameWidth * 0.08; // Minimum balon boyutu
    final maxSize = _gameWidth * 0.16; // Maksimum balon boyutu (küçültüldü)
    final size = _random.nextDouble() * (maxSize - minSize) + minSize;

    // Hız faktörü - ekran boyutuna göre ayarlanır, daha yavaş
    final baseSpeed = _gameHeight * 0.001; // Temel hız yarıya indirildi
    final speedFactor =
        _random.nextDouble() * 1.2 + 0.6; // Hız aralığı azaltıldı
    final speed = baseSpeed * speedFactor +
        (_currentLevel * baseSpeed * 0.2); // Seviye artışı daha yavaş

    // X pozisyonu - balonun tamamen ekran içinde kalması sağlanıyor
    final horizontalPadding = size * 0.1; // Kenarlara daha az yaklaşsın
    final maxX = _gameWidth - size - horizontalPadding;
    final minX = horizontalPadding; // Minimum X pozisyonu da belirle
    final x = _random.nextDouble() * (maxX - minX) + minX;

    final balloon = Balloon(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      x: x,
      y: _gameHeight + size, // Ekranın altından başla
      size: size,
      color: Color.fromARGB(
        255,
        _random.nextInt(200) + 55,
        _random.nextInt(200) + 55,
        _random.nextInt(200) + 55,
      ),
      speed: speed,
    );

    _safeSetState(() {
      _balloons.add(balloon);
      _remainingBalloons = _totalBalloons - (_poppedBalloons + _missedBalloons);
    });

    // Balon hareketi için timer - SafeSetState metodu kullanarak
    final timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      // Eğer widget dispose edilmişse veya artık ağaçta değilse
      if (!mounted || _disposed || !_isGameStarted || _isGamePaused) {
        timer.cancel();
        _balloonTimers.remove(timer);
        return;
      }

      try {
        _safeSetState(() {
          final index = _balloons.indexWhere((b) => b.id == balloon.id);
          if (index != -1) {
            // Daha yavaş hareket
            _balloons[index].y -= _balloons[index].speed;

            // Balon ekrandan çıkmasın, sınırları kontrol et
            if (_balloons[index].x < 0) {
              _balloons[index].x = 0;
            } else if (_balloons[index].x >
                _gameWidth - _balloons[index].size) {
              _balloons[index].x = _gameWidth - _balloons[index].size;
            }

            // Balon ekranın üstüne ulaştıysa
            if (_balloons[index].y < -_balloons[index].size) {
              _balloons.removeAt(index);
              _missedBalloons++;
              _remainingBalloons =
                  _totalBalloons - (_poppedBalloons + _missedBalloons);
              timer.cancel();
              _balloonTimers.remove(timer);

              // Tüm balonlar bittiğinde oyunu kontrol et
              if (mounted &&
                  !_disposed &&
                  _poppedBalloons + _missedBalloons >= _totalBalloons) {
                _checkGameEnd();
              } else if (mounted && !_disposed && _balloons.length < 5) {
                // Yeni balon ekle (ekrandaki balon sayısı 5'ten azsa)
                Future.microtask(() => _createBalloon());
              }
            }
          } else {
            timer.cancel();
            _balloonTimers.remove(timer);
          }
        });
      } catch (e) {
        // Hata oluşursa timer'ı iptal et
        timer.cancel();
        _balloonTimers.remove(timer);
        debugPrint("Balon animasyon hatası: $e");
      }
    });

    // Timer'ı listeye ekle
    _balloonTimers.add(timer);
  }

  void _popBalloon(int index) {
    if (!mounted || _disposed) return;

    if (index >= 0 && index < _balloons.length) {
      try {
        _safeSetState(() {
          // Puanı arttır (küçük balonlar daha çok puan)
          final points =
              (100 / _balloons[index].size * _gameWidth * 0.1).round();
          _score += points;
          _poppedBalloons++;
          _balloons.removeAt(index);
          _remainingBalloons =
              _totalBalloons - (_poppedBalloons + _missedBalloons);

          // Tüm balonlar bittiğinde oyunu kontrol et
          if (_poppedBalloons + _missedBalloons >= _totalBalloons) {
            _checkGameEnd();
          } else if (_balloons.length < 5) {
            // Balonları daha uygun aralıklarla eklemek için kısa bir gecikme ekle
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted && !_disposed && _isGameStarted && !_isGamePaused) {
                _createBalloon();
              }
            });
          }
        });
      } catch (e) {
        debugPrint("Balon patlatma hatası: $e");
      }
    }
  }

  void _checkGameEnd() {
    // Tüm balonlar bittiyse oyun biter
    if (_poppedBalloons + _missedBalloons >= _totalBalloons) {
      // Biraz bekleyip oyunu sonlandır (oyuncu son patlatılan balonu görsün)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_disposed) {
          _stopGame();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || _disposed) {
      return const SizedBox.shrink();
    }

    final responsive = ResponsiveSize(context);
    final number = _getNumberFromText();

    // Oyun alanı boyutları güncellenir
    _gameWidth = responsive.width * 0.33;
    _gameHeight = responsive.height * 0.75;

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
                  borderRadius:
                      BorderRadius.circular(AppRadii.cardRadius(context)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Başlık bölümü
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.height * 0.015,
                        horizontal:
                            responsive.width * 0.015, // Yatay dolguyu azalttım
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
                    // Skor ve bilgi ikonları paneli
                    if (_isGameStarted)
                      ScorePanel(
                        score: _score,
                        remainingBalloons: _remainingBalloons,
                        totalBalloons: _totalBalloons,
                        level: _currentLevel,
                        timeLeft: _timeLeft,
                        responsive: responsive,
                      ),
                    // Oyun alanı
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(responsive.height * 0.015),
                        child: widget.isLoading
                            ? _buildLoadingContent(responsive)
                            : _isGameStarted
                                ? _buildGameContent(responsive)
                                : number > 0
                                    ? _buildStartGamePrompt(responsive, number)
                                    : _buildEmptyContent(responsive),
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

  Widget _buildGameStatusIcon({
    required ResponsiveSize responsive,
    required IconData icon,
    required Color color,
    required String value,
    required String tooltip,
  }) {
    // Daha da küçük boyutlar tanımlayalım
    final iconSize = responsive.width * 0.022; // Daha da küçültüldü
    final innerIconSize = responsive.width * 0.012; // Daha da küçültüldü
    final badgeSize = responsive.width * 0.011; // Daha da küçültüldü
    final badgeFontSize = responsive.width * 0.006; // Daha da küçültüldü
    final margin = responsive.width * 0.001; // Daha da azaltıldı

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: Tooltip(
        message: tooltip,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Arka plan daire
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            // İkon
            Icon(icon, color: color, size: innerIconSize),
            // Değer
            Positioned(
              bottom: 0,
              right: -responsive.width * 0.001, // Daha az kaydırma
              child: Container(
                padding: EdgeInsets.all(
                    responsive.width * 0.0005), // Daha az iç dolgu
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white, width: 0.2), // Daha ince kenarlık
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

  Widget _buildGameContent(ResponsiveSize responsive) {
    if (_disposed) return Container(); // Dispose edilmişse boş container döndür

    return Stack(
      children: [
        // Balon patlatma alanı
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
                  // Oyun alanı boyutlarını güncelle
                  _gameWidth = constraints.maxWidth;
                  _gameHeight = constraints.maxHeight;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Balonlar
                      ..._balloons.asMap().entries.map((entry) {
                        final index = entry.key;
                        final balloon = entry.value;

                        // Balonun ekrandan taşmamasını sağla
                        double x = balloon.x;
                        if (x < 0) x = 0;
                        if (x > _gameWidth - balloon.size)
                          x = _gameWidth - balloon.size;

                        return Positioned(
                          left: x,
                          top: balloon.y,
                          child: GestureDetector(
                            onTap: () => _popBalloon(index),
                            child: Container(
                              width: balloon.size,
                              height: balloon.size,
                              decoration: BoxDecoration(
                                color: balloon.color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Balon parlaklığı
                                  Container(
                                    width: balloon.size * 0.25,
                                    height: balloon.size * 0.25,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  // Balon ipi
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
                      }).toList(),

                      // Tüm balonlar patlatıldıysa oyun sonu mesajı
                      if (_poppedBalloons + _missedBalloons >= _totalBalloons &&
                          _totalBalloons > 0)
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
                                  "Tebrikler!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.subtitleFontSize * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: responsive.height * 0.01),
                                Text(
                                  "Tüm balonları patlattın!",
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
        // Duraklat düğmesi
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            radius: responsive.width * 0.02,
            child: IconButton(
              icon: Icon(_isGamePaused ? Icons.play_arrow : Icons.pause),
              onPressed: _pauseGame,
              color: AppColors.primaryColor,
              iconSize: responsive.width * 0.015,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: responsive.width * 0.01,
                minHeight: responsive.width * 0.01,
              ),
            ),
          ),
        ),
        // Duraklatıldı ekranı
        if (_isGamePaused)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OYUN DURAKLATILDI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.subtitleFontSize * 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: responsive.height * 0.02),
                  ElevatedButton.icon(
                    onPressed: _pauseGame,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Devam Et"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
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

  Widget _buildStartGamePrompt(ResponsiveSize responsive, int number) {
    if (_disposed) return Container(); // Dispose edilmişse boş container döndür

    // Sayı sınırlaması (1-20 arası sayı)
    final balloonCount = number.clamp(1, 20);

    return Stack(
      children: [
        // Arka plan için animasyonlu balonlar
        Positioned.fill(
          child: _BackgroundBalloons(
            balloonCount: 12, // Arka planda görünen balon sayısı
            gameWidth: responsive.width * 0.32,
            gameHeight: responsive.height * 0.75,
          ),
        ),
        // Oyun başlatma içeriği
        Center(
          child: Container(
            padding: EdgeInsets.all(responsive.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bubble_chart,
                  color: AppColors.primaryColor,
                  size: responsive.smallIconSize * 2,
                ),
                SizedBox(height: responsive.height * 0.015),
                Text(
                  "$balloonCount adet balonla oynamaya hazır mısın?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.subtitleFontSize * 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: responsive.height * 0.01),
                Text(
                  "Balonları patlatarak puan kazan!\nNe kadar küçük balon patlatırsan o kadar çok puan alırsın.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.bodyFontSize,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: responsive.height * 0.02),
                ElevatedButton.icon(
                  onPressed: _startGame,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("OYUNU BAŞLAT"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
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

  Widget _buildLoadingContent(ResponsiveSize responsive) {
    if (_disposed) return Container(); // Dispose edilmişse boş container döndür

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 4,
        ),
        SizedBox(height: responsive.height * 0.015),
        Text(
          "Balonlar hazırlanıyor...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.subtitleFontSize * 1.1,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyContent(ResponsiveSize responsive) {
    if (_disposed) return Container(); // Dispose edilmişse boş container döndür

    return Stack(
      children: [
        // Arka plan için animasyonlu balonlar (boş ekranda da gösterilir)
        Positioned.fill(
          child: _BackgroundBalloons(
            balloonCount: 8, // Daha az balon
            gameWidth: responsive.width * 0.32,
            gameHeight: responsive.height * 0.75,
          ),
        ),
        // Boş içerik mesajı
        Center(
          child: Container(
            padding: EdgeInsets.all(responsive.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
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
                  "Henüz balon yok!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.bodyFontSize * 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: responsive.height * 0.008),
                Text(
                  "Bir sayı çizerek balon oyununu başlat!",
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

// Skor panelini ayrı bir widget olarak ekliyorum
class ScorePanel extends StatelessWidget {
  final int score;
  final int remainingBalloons;
  final int totalBalloons;
  final int level;
  final int timeLeft;
  final ResponsiveSize responsive;
  const ScorePanel({
    required this.score,
    required this.remainingBalloons,
    required this.totalBalloons,
    required this.level,
    required this.timeLeft,
    required this.responsive,
    super.key,
  });

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
          tooltip: "Puan",
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.bubble_chart,
          color: Colors.blue,
          value: "$remainingBalloons/$totalBalloons",
          tooltip: "Balon Sayısı",
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.trending_up,
          color: Colors.purple,
          value: level.toString(),
          tooltip: "Seviye",
        ),
        _buildGameStatusIcon(
          responsive: responsive,
          icon: Icons.timer,
          color: Colors.red,
          value: timeLeft.toString(),
          tooltip: "Kalan Süre",
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
                color: color.withOpacity(0.1),
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

// Arka planda uçuşan balonlar için widget - StatelessWidget'a dönüştürüldü
class _BackgroundBalloons extends StatelessWidget {
  final int balloonCount;
  final double gameWidth;
  final double gameHeight;

  const _BackgroundBalloons({
    required this.balloonCount,
    required this.gameWidth,
    required this.gameHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Direkt olarak arka plan renk gradyanı - Balonlar olmadan
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

// Balon sınıfı
class Balloon {
  final String id;
  double x;
  double y;
  final double size;
  final Color color;
  final double speed;

  Balloon({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
  });
}
