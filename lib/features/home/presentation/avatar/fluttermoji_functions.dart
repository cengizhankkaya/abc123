import 'dart:convert';

import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/clothes/clothes.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/face/eyebrow/eyebrow.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/face/eyes/eyes.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/face/mouth/mouth.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/face/nose/nose.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/fluttermojimodel.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/skin.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/style.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/top/accessories/accessories.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/top/facialHair/facialHair.dart';
import 'package:abc123/features/home/presentation/avatar/fluttermoji_assets/top/hairStyles/hairStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FluttermojiFunctions {

  FluttermojiFunctions() {
    _decodedList = {
      'topType': 4,
      'accessoriesType': 0,
      'hairColor': 1,
      'facialHairType': 0,
      'facialHairColor': 1,
      'clotheType': 4,
      'eyeType': 0,
      'eyebrowType': 0,
      'mouthType': 1,
      'skinColor': 0,
      'clotheColor': 1,
      'style': 0,
      'graphicType': 0,
    };
  }
  late Map<String, int> _decodedList;

  String _getFluttermojiProperty(String type) {
    return fluttermojiProperties[type]!
        .property!
        .elementAt(_decodedList[type]!);
  }

  /// SharedPreferences'taki fluttermoji verisini siler.
  Future<List<bool>> clearFluttermoji() async {
    final pref = await SharedPreferences.getInstance();
    return Future.wait([
      pref.remove('fluttermojiSelectedOptions'),
      pref.remove('fluttermoji'),
    ]);
  }

  /// Encode edilmiş string'den SVG üretir.
  String decodeFluttermojifromString(String encodedData) {
    if (encodedData != '') {
      final raw = jsonDecode(encodedData) as Map;
      _decodedList = raw.map((k, v) => MapEntry(k.toString(), v as int));
    }

    final fmStyle = fluttermojiStyle[_getFluttermojiProperty('style')]!;
    final clothe = Clothes.generateClothes(
        clotheType: _getFluttermojiProperty('clotheType'),
        clColor: _getFluttermojiProperty('clotheColor'),)!;
    final facialHair = FacialHair.generateFacialHair(
        facialHairType: _getFluttermojiProperty('facialHairType'),
        fhColor: _getFluttermojiProperty('facialHairColor'),)!;
    final mouthSvg = mouth[_getFluttermojiProperty('mouthType')] as String;
    final noseSvg = nose['Default'] as String;
    final eyesSvg = eyes[_getFluttermojiProperty('eyeType')] as String;
    final eyebrowsSvg = eyebrow[_getFluttermojiProperty('eyebrowType')] as String;
    final accessory = accessories[_getFluttermojiProperty('accessoriesType')] as String;
    final hair = HairStyle.generateHairStyle(
        hairType: _getFluttermojiProperty('topType'),
        hColor: _getFluttermojiProperty('hairColor'),)!;
    final skinSvg = skin[_getFluttermojiProperty('skinColor')] as String;

    return '''<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink">
<desc>Fluttermoji on pub.dev</desc>
<defs>
<circle id="path-1" cx="120" cy="120" r="120"></circle>
<path d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z" id="path-3"></path>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>
</defs>
<g id="Fluttermoji" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
<g transform="translate(-825.000000, -1100.000000)" id="Fluttermoji/Circle">
<g transform="translate(825.000000, 1100.000000)">$fmStyle<g id="Mask"></g>
<g id="Fluttermoji" stroke-width="1" fill-rule="evenodd">
<g id="Body" transform="translate(32.000000, 36.000000)">
<mask id="mask-6" fill="white">
<use xlink:href="#path-5"></use>
</mask>
<use fill="#D0C6AC" xlink:href="#path-5"></use>$skinSvg<path d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z" id="Neck-Shadow" opacity="0.100000001" fill="#000000" mask="url(#mask-6)"></path></g>$clothe<g id="Face" transform="translate(76.000000, 82.000000)" fill="#000000">$mouthSvg$facialHair$noseSvg$eyesSvg$eyebrowsSvg$accessory</g>$hair</g></g></g></g></svg>''';
  }

  Future<Map<String, dynamic>> encodeMySVGtoMap() async {
    final pref = await SharedPreferences.getInstance();
    final saved = pref.getString('fluttermojiSelectedOptions');
    if (saved == null || saved.isEmpty) {
      final defaults = Map<String, int>.from(defaultFluttermojiOptions);
      await pref.setString(
          'fluttermojiSelectedOptions', jsonEncode(defaults),);
      return defaults;
    }
    final raw = jsonDecode(saved) as Map;
    return raw.map((k, v) => MapEntry(k.toString(), v as dynamic));
  }

  Future<String> encodeMySVGtoString() async {
    final pref = await SharedPreferences.getInstance();
    final saved = pref.getString('fluttermojiSelectedOptions');
    if (saved == null || saved.isEmpty) {
      final defaults = Map<String, int>.from(defaultFluttermojiOptions);
      await pref.setString(
          'fluttermojiSelectedOptions', jsonEncode(defaults),);
      return jsonEncode(defaults);
    }
    return saved;
  }
}
