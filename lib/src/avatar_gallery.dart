part of "../avatar_gallery.dart";

AssetImage getAvatar(int index) {
  return AssetImage(
    "lib/assets/$index.png",
    package: "avatar_gallery",
  );
}

class CircleAvatarWithButton extends StatefulWidget {
  const CircleAvatarWithButton({Key? key}) : super(key: key);

  @override
  State<CircleAvatarWithButton> createState() => _CircleAvatarWithButtonState();
}

class _CircleAvatarWithButtonState extends State<CircleAvatarWithButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
