part of '../avatar_gallery.dart';

class CircleAvatarData {
  String? url;
  bool showAlertBadge;
  Function(BuildContext context)? onTap;

  static String get fieldUrl => "url";
  static String get fieldShowAlertBadge => "showAlertBadge";
  static String get fieldOnTap => "onTap";

  CircleAvatarData(
      {required this.url, this.showAlertBadge = false, this.onTap});

  factory CircleAvatarData.fromMap(Map<String, dynamic> map) {
    return CircleAvatarData(
      url: map[CircleAvatarData.fieldUrl],
      showAlertBadge: map[CircleAvatarData.fieldShowAlertBadge],
      onTap: map[CircleAvatarData.fieldOnTap],
    );
  }

  Map<String, dynamic> toMap() => {
        CircleAvatarData.fieldUrl: url,
        CircleAvatarData.fieldShowAlertBadge: showAlertBadge,
        CircleAvatarData.fieldOnTap: onTap,
      };
}

class CircleAvatarHasActionController extends ValueNotifier<CircleAvatarData> {
  CircleAvatarHasActionController(
      {Function(BuildContext context)? onTap, String? url})
      : super(CircleAvatarData(
            url: (url != null) ? url : "${protocolAvatar}${pathDefaultAvatar}",
            onTap: onTap));

  String? get url => value.url;
  bool get showAlertBadge => value.showAlertBadge;
  Function(BuildContext context)? get onTap => value.onTap;

  set onTap(Function(BuildContext context)? newValue) {
    var map = value.toMap();
    map[CircleAvatarData.fieldOnTap] = newValue;
    value = CircleAvatarData.fromMap(map);
  }

  set url(String? newUrl) {
    var map = value.toMap();
    map[CircleAvatarData.fieldUrl] = newUrl;
    value = CircleAvatarData.fromMap(map);
  }

  set showAlertBadge(bool newValue) {
    var map = value.toMap();
    map[CircleAvatarData.fieldShowAlertBadge] = newValue;
    value = CircleAvatarData.fromMap(map);
  }
}
