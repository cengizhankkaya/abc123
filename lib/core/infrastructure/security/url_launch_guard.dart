import 'package:abc123/core/domain/ports/i_url_launcher.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

/// [isAllowedExternalLaunchUri] guard fonksiyonunu ve URL açmayı
/// [IUrlLauncher] portu üzerinden saran infrastructure adapter.
///
/// Kural: Yalnızca HTTPS şemalı, host'u olan URI'lara izin verilir.
@LazySingleton(as: IUrlLauncher)
final class UrlLaunchGuardImpl implements IUrlLauncher {
  const UrlLaunchGuardImpl();

  @override
  bool isAllowed(Uri uri) {
    if (!uri.hasScheme) return false;
    return uri.scheme.toLowerCase() == 'https' && uri.host.isNotEmpty;
  }

  @override
  Future<bool> launch(Uri uri) async {
    if (!isAllowed(uri)) return false;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }
}

/// Eski top-level fonksiyon — geriye dönük uyumluluk için korunur.
/// Yeni kod [IUrlLauncher.isAllowed] kullanmalıdır.
@Deprecated('Use IUrlLauncher.isAllowed via DI instead')
bool isAllowedExternalLaunchUri(Uri uri) {
  if (!uri.hasScheme) return false;
  return uri.scheme.toLowerCase() == 'https' && uri.host.isNotEmpty;
}
