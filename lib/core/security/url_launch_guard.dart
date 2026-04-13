/// Dış tarayıcı / uygulama çağrılarında yalnızca HTTPS (`15_security.md`).
bool isAllowedExternalLaunchUri(Uri uri) {
  if (!uri.hasScheme) return false;
  return uri.scheme.toLowerCase() == 'https' && uri.host.isNotEmpty;
}
