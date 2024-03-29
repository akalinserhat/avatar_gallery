part of '../avatar_gallery.dart';

class CircleAvatarHasAction extends StatefulWidget {
  final CircleAvatarHasActionController controller;
  final double? size;

  const CircleAvatarHasAction({
    Key? key,
    required this.controller,
    this.size,
  }) : super(key: key);

  @override
  State<CircleAvatarHasAction> createState() => _CircleAvatarHasActionState();
}

class _CircleAvatarHasActionState extends State<CircleAvatarHasAction> {
  bool get isButtonShow => widget.controller.onTap != null;
  bool get isAlertBadgeShow => controller.showAlertBadge;
  CircleAvatarHasActionController get controller => widget.controller;
  Function(BuildContext context)? get onTapButton => controller.onTap;
  double? get size => widget.size;

  Widget _avatar(BuildContext context, double size, CircleAvatarData value) {
    var child;
    if (value.url == null) {
      child = const AssetImage(pathDefaultAvatar, package: package);
    } else if (value.url!.startsWith(protocolAvatar)) {
      var avatarPath = value.url!.replaceFirst(protocolAvatar, "");
      child = AssetImage(avatarPath, package: package);
    } else {
      child = Image.network(value.url!);
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: child,
    );
  }

  Widget _iconButton(Function() onTapButton) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
            color: Theme.of(context).shadowColor,
          )
        ]),
        child: CircleAvatar(
          child: IconButton(
              onPressed: () => onTapButton(),
              icon: const Icon(Icons.add_a_photo)),
        ),
      ),
    );
  }

  Widget _alertBadge() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
            color: Theme.of(context).shadowColor,
          )
        ]),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).hintColor,
          child: const Icon(Icons.circle_notifications_outlined),
        ),
      ),
    );
  }

  double _getSize(BoxConstraints constraints) {
    if (size != null) return size!;
    return (constraints.maxWidth > constraints.maxHeight)
        ? constraints.maxHeight
        : constraints.maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widthAndHeight = _getSize(constraints);
        return UnconstrainedBox(
          child: SizedBox(
              width: widthAndHeight,
              height: widthAndHeight,
              child: ValueListenableBuilder<CircleAvatarData>(
                valueListenable: controller,
                builder: (context, value, child) {
                  return Stack(children: [
                    _avatar(context, widthAndHeight, value),
                    (isButtonShow)
                        ? _iconButton(() => onTapButton!(context))
                        : Container(),
                    (isAlertBadgeShow) ? _alertBadge() : Container(),
                  ]);
                },
              )),
        );
      },
    );
  }
}
