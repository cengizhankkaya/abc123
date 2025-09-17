import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/presentation/tutorial/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/utils/image_manager.dart';
import '../../../../shared/counter_provider.dart';
import '../../../../shared/language_provider.dart';
import '../../../draw/presentation/screens/draw_screen.dart';
import '../../../letters/presentation/screens/letter_draw_screen.dart';
import '../widgets/welcome_card.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_font_sizes.dart';
import '../../../../core/constants/app_radii.dart';
import '../../../../core/utils/rewarded_ad_helper.dart';
import '../widgets/activity_card.dart';
import '../tutorial/tutorial_section.dart';
import '../../language/language_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with RewardedAdHelper<HomeScreen> {
  // RewardedAdHelper mixini ile ilgili kodlar dışarı alındı
  @override
  void initState() {
    super.initState();
    loadRewardedAd(context);
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
          padding: EdgeInsets.all(AppSizes.paddingLarge(context)),
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
                                  fontSize: AppFontSizes.title(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: AppSizes.paddingSmall(context)),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: isLandscape
                                ? size.height * 0.02
                                : size.height * 0.03),
                        // Karşılama kartı
                        WelcomeCard(lang: lang),
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
                                          ActivityCard(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DrawScreen()),
                                              );
                                            },
                                            image: ImageManager.getImage(
                                              ImageConstants.numberImage,
                                              width: 160,
                                              height: 160,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          // Harfleri Çiziyorum Kartı
                                          ActivityCard(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LetterDrawScreen()),
                                              );
                                            },
                                            image: ImageManager.getImage(
                                              ImageConstants.abcImage,
                                              width: 160,
                                              height: 160,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          // Şekilleri Çiziyorum Kartı (Yeni Kart)
                                          ActivityCard(
                                            onTap: () {
                                              showRewardedAd(context);
                                            },
                                            image: ImageManager.getImage(
                                              ImageConstants.shapesImage,
                                              width: 160,
                                              height: 160,
                                              fit: BoxFit.cover,
                                            ),
                                            overlay: Stack(
                                              children: [
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
                                                          BorderRadius.circular(
                                                              8),
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
                                                  child:
                                                      Consumer<CounterProvider>(
                                                    builder: (context,
                                                        counterProvider, _) {
                                                      return Container(
                                                        padding: EdgeInsets.all(
                                                            AppSizes
                                                                .paddingSmall(
                                                                    context)),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius
                                                              .circular(AppRadii
                                                                  .cardRadius(
                                                                      context)),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  // Sağ taraf: Öğretici
                                  Expanded(
                                    flex: 2,
                                    child: TutorialSection(
                                      lang: lang,
                                      size: size,
                                      getLocalizedText: getLocalizedText,
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
                                        ActivityCard(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DrawScreen()),
                                            );
                                          },
                                          image: ImageManager.getImage(
                                            ImageConstants.numberImage,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        // Harfleri Çiziyorum Kartı
                                        ActivityCard(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LetterDrawScreen()),
                                            );
                                          },
                                          image: ImageManager.getImage(
                                            ImageConstants.abcImage,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        // Şekilleri Çiziyorum Kartı (Yeni Kart)
                                        ActivityCard(
                                          onTap: () {
                                            showRewardedAd(context);
                                          },
                                          image: ImageManager.getImage(
                                            ImageConstants.shapesImage,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.cover,
                                          ),
                                          overlay: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 8,
                                                left: 8,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                child:
                                                    Consumer<CounterProvider>(
                                                  builder: (context,
                                                      counterProvider, _) {
                                                    return Container(
                                                      padding: EdgeInsets.all(
                                                          AppSizes.paddingSmall(
                                                              context)),
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius: BorderRadius
                                                            .circular(AppRadii
                                                                .cardRadius(
                                                                    context)),
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
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 11,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(height: 4),
                                                          LinearProgressIndicator(
                                                            value: counterProvider
                                                                    .counter /
                                                                500,
                                                            minHeight: 6,
                                                            backgroundColor:
                                                                Colors.white24,
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
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            ),
                                                            textAlign: TextAlign
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
                                                YoutubeVideoScreen()),
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
                                                YoutubeVideoScreen()),
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
                      child: LanguageSelector(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
