part of "../avatar_gallery.dart";

class AppImageData {
  String? url;
  bool showAlertBadge;
  Function(BuildContext context)? onTap;

  static String get fieldUrl => "url";
  static String get fieldShowAlertBadge => "showAlertBadge";
  static String get fieldOnTap => "onTap";

  AppImageData({required this.url, this.showAlertBadge = false, this.onTap});

  factory AppImageData.fromMap(Map<String, dynamic> map) {
    return AppImageData(
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
