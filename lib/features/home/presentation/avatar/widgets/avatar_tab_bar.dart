import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/fluttermojimodel.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Avatar customizer için AppBar + TabBar + ok butonları.
///
/// AppBar'ı kendi içinde yönetir; ana scaffold tarafından `appBar:` parametresi
/// olarak kullanılmak yerine, `PreferredSizeWidget` olarak expose edilir.
class AvatarTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AvatarTabBar({
    required this.attributes,
    required this.tabController,
    required this.attributesCount,
    required this.theme,
    required this.onArrowTap,
    super.key,
  });

  final List<AttributeItem> attributes;
  final TabController tabController;
  final int attributesCount;
  final FluttermojiThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  @override
  Size get preferredSize =>
      // AppBar yüksekliği (kToolbarHeight) + TabBar yüksekliği (48)
      const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        attributes[tabController.index].title,
        style: theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: _ArrowButton(
        isLeft: true,
        tabController: tabController,
        attributesCount: attributesCount,
        theme: theme,
        onArrowTap: onArrowTap,
      ),
      actions: [
        _ArrowButton(
          isLeft: false,
          tabController: tabController,
          attributesCount: attributesCount,
          theme: theme,
          onArrowTap: onArrowTap,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _AttributeTabBar(
          attributes: attributes,
          tabController: tabController,
          theme: theme,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ok butonu
// ---------------------------------------------------------------------------

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.isLeft,
    required this.tabController,
    required this.attributesCount,
    required this.theme,
    required this.onArrowTap,
  });

  final bool isLeft;
  final TabController tabController;
  final int attributesCount;
  final FluttermojiThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  @override
  Widget build(BuildContext context) {
    final visible = isLeft ? tabController.index > 0 : tabController.index < attributesCount - 1;

    return Visibility(
      visible: visible,
      child: IconButton(
        icon: Icon(
          isLeft ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded,
          color: theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Kaydırılabilir icon TabBar
// ---------------------------------------------------------------------------

class _AttributeTabBar extends StatelessWidget {
  const _AttributeTabBar({
    required this.attributes,
    required this.tabController,
    required this.theme,
  });

  final List<AttributeItem> attributes;
  final TabController tabController;
  final FluttermojiThemeData theme;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      for (var i = 0; i < attributes.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          child: SvgPicture.asset(
            attributes[i].iconAsset!,
            height: attributes[i].iconsize ?? 26,
            colorFilter: ColorFilter.mode(
              i == tabController.index ? theme.selectedIconColor : theme.unselectedIconColor,
              BlendMode.srcIn,
            ),
            semanticsLabel: attributes[i].title,
          ),
        ),
    ];

    return ColoredBox(
      color: theme.primaryBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        indicatorColor: theme.selectedIconColor,
        indicatorPadding: const EdgeInsets.all(2),
        tabs: tabs,
      ),
    );
  }
}
