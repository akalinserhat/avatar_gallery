part of "../avatar_gallery.dart";

class AppImageController extends ValueNotifier<AppImageData> {
  AppImageController({
    String? url,
    Function(BuildContext context)? onTap,
  }) : super(AppImageData(url: url, onTap: onTap));
  String? get url => value.url;
  bool get showAlertBadge => value.showAlertBadge;
  Function(BuildContext context)? get onTap => value.onTap;

  set onTap(Function(BuildContext context)? newValue) {
    var map = value.toMap();
    map[AppImageData.fieldOnTap] = newValue;
    value = AppImageData.fromMap(map);
  }

  set url(String? newUrl) {
    var map = value.toMap();
    map[CircleAvatarData.fieldUrl] = newUrl;
    value = AppImageData.fromMap(map);
  }

  set showAlertBadge(bool newValue) {
    var map = value.toMap();
    map[CircleAvatarData.fieldShowAlertBadge] = newValue;
    value = AppImageData.fromMap(map);
  }
}
