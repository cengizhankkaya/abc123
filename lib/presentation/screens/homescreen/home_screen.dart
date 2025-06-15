import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/presentation/screens/drawscreen/draw_screen.dart';
import 'package:abc123/presentation/screens/drawscreen/widgets/admob_banner_widget.dart';
import 'package:abc123/presentation/screens/homescreen/tutorialscreen/tutorial_screen.dart';
import 'package:abc123/presentation/screens/lettersscreen/letter_draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/image_manager.dart';
import '../../../core/constants/image_constants.dart';
import '../../providers/language_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../providers/counter_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId:
          'ca-app-pub-1254894147284178/7964725662', // Gerçek ödüllü reklam ID
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  void _showRewardedAd(BuildContext context) {
    if (_isRewardedAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) async {
          await Provider.of<CounterProvider>(context, listen: false)
              .increment(1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tebrikler! 1 puan kazandınız.')),
          );
        },
      );
      _rewardedAd = null;
      _isRewardedAdLoaded = false;
      _loadRewardedAd();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reklam yüklenemedi, lütfen tekrar deneyin.')),
      );
      _loadRewardedAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final lang = context.watch<LanguageProvider>().language;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Açık mavi arka plan
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: AdmobBannerWidget(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(height: 8),
                        // Başlık
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Abc123',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: isLandscape
                                ? size.height * 0.02
                                : size.height * 0.03),
                        // Karşılama kartı
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors
                                .panelColor, // Mavi-gri renginde arka plan
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              // Robot görseli için yer
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey.withOpacity(0.3),
                                  child: ImageManager.getRobotImage(
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getLocalizedText('hello', lang),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      getLocalizedText('slogan', lang),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: isLandscape
                                ? size.height * 0.03
                                : size.height * 0.04),
                        // Aktivite kartları
                        isLandscape
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Sol taraf: Aktivite kartları
                                  Expanded(
                                    flex: 3,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          // Rakamları Çiziyorum Kartı
                                          SizedBox(
                                            width: 160,
                                            height: 160,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DrawScreen()),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: SizedBox(
                                                      width: 160,
                                                      height: 160,
                                                      child:
                                                          ImageManager.getImage(
                                                        ImageConstants
                                                            .numberImage,
                                                        width: 160,
                                                        height: 160,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          // Harfleri Çiziyorum Kartı
                                          SizedBox(
                                            width: 160,
                                            height: 160,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LetterDrawScreen()),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: SizedBox(
                                                      width: 160,
                                                      height: 160,
                                                      child:
                                                          ImageManager.getImage(
                                                        ImageConstants.abcImage,
                                                        width: 160,
                                                        height: 160,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          // Şekilleri Çiziyorum Kartı (Yeni Kart)
                                          SizedBox(
                                            width: 160,
                                            height: 160,
                                            child: GestureDetector(
                                              onTap: () {
                                                _showRewardedAd(context);
                                              },
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: SizedBox(
                                                      width: 160,
                                                      height: 160,
                                                      child:
                                                          ImageManager.getImage(
                                                        ImageConstants
                                                            .shapesImage,
                                                        width: 160,
                                                        height: 160,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 8,
                                                    left: 8,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        'Şekilleri Çiziyorum',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 8,
                                                    left: 8,
                                                    right: 8,
                                                    child: Consumer<
                                                        CounterProvider>(
                                                      builder: (context,
                                                          counterProvider, _) {
                                                        return Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                getLocalizedText(
                                                                    'watchAdToUnlock',
                                                                    lang),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 11,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                  height: 4),
                                                              LinearProgressIndicator(
                                                                value: counterProvider
                                                                        .counter /
                                                                    500,
                                                                minHeight: 6,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white24,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                              ),
                                                              SizedBox(
                                                                  height: 4),
                                                              Text(
                                                                '${counterProvider.counter} / 500',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  // Sağ taraf: Öğretici
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssetVideoScreen()),
                                            );
                                          },
                                          child: Text(
                                            getLocalizedText(
                                                'seeTutorial', lang),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: size.height * 0.02),
                                          child: GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssetVideoScreen()),
                                              );
                                            },
                                            child: Container(
                                              height: size.height * 0.2,
                                              width: double.infinity,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Container(
                                                      height: size.height * 0.2,
                                                      width: double.infinity,
                                                      color: AppColors
                                                          .backgroundColor, // Açık sarı arka plan
                                                      child:
                                                          ImageManager.getImage(
                                                        ImageConstants
                                                            .tutorialImage,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 8,
                                                    left: 8,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        getLocalizedText(
                                                            'tutorial', lang),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Dikey ekran yerleşimi: Önce aktivite kartları
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // Rakamları Çiziyorum Kartı
                                        SizedBox(
                                          width: 160,
                                          height: 160,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DrawScreen()),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: SizedBox(
                                                    width: 160,
                                                    height: 160,
                                                    child:
                                                        ImageManager.getImage(
                                                      ImageConstants
                                                          .numberImage,
                                                      width: 160,
                                                      height: 160,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        // Harfleri Çiziyorum Kartı
                                        SizedBox(
                                          width: 160,
                                          height: 160,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LetterDrawScreen()),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: SizedBox(
                                                    width: 160,
                                                    height: 160,
                                                    child:
                                                        ImageManager.getImage(
                                                      ImageConstants.abcImage,
                                                      width: 160,
                                                      height: 160,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        // Şekilleri Çiziyorum Kartı (Yeni Kart)
                                        SizedBox(
                                          width: 160,
                                          height: 160,
                                          child: GestureDetector(
                                            onTap: () {
                                              _showRewardedAd(context);
                                            },
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: SizedBox(
                                                    width: 160,
                                                    height: 160,
                                                    child:
                                                        ImageManager.getImage(
                                                      ImageConstants
                                                          .shapesImage,
                                                      width: 160,
                                                      height: 160,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 8,
                                                  left: 8,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  left: 8,
                                                  right: 8,
                                                  child:
                                                      Consumer<CounterProvider>(
                                                    builder: (context,
                                                        counterProvider, _) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              getLocalizedText(
                                                                  'watchAdToUnlock',
                                                                  lang),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 11,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(height: 4),
                                                            LinearProgressIndicator(
                                                              value: counterProvider
                                                                      .counter /
                                                                  500,
                                                              minHeight: 6,
                                                              backgroundColor:
                                                                  Colors
                                                                      .white24,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              '${counterProvider.counter} / 500',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  // Öğreticiye bak başlığı
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssetVideoScreen()),
                                      );
                                    },
                                    child: Text(
                                      getLocalizedText('seeTutorial', lang),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  // Öğretici görseli
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssetVideoScreen()),
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.2,
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Container(
                                              height: size.height * 0.2,
                                              width: double.infinity,
                                              color: AppColors.accentColor,
                                              child: ImageManager.getImage(
                                                ImageConstants.tutorialImage,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    // Sağ üst köşe dil seçici buton
                    Positioned(
                      top: 0,
                      right: 0,
                      child: PopupMenuButton<AppLanguage>(
                        icon: Icon(Icons.language,
                            color: Colors.orange, size: 32),
                        onSelected: (AppLanguage selectedLang) {
                          final provider = context.read<LanguageProvider>();
                          provider.setLanguage(selectedLang);
                        },
                        itemBuilder: (context) => [
                          for (final langOption in supportedLanguages)
                            PopupMenuItem(
                              value: langOption.value,
                              child: Row(
                                children: [
                                  Text(langOption.flag),
                                  SizedBox(width: 8),
                                  Text(langOption.label),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: AdmobBannerWidget(),
      ),
    );
  }
}
