part of "../avatar_gallery.dart";

AssetImage getAvatar(int index) {
  return AssetImage(
    "lib/assets/$index.png",
    package: "avatar_gallery",
  );
}
