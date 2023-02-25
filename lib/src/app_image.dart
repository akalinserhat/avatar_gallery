part of "../avatar_gallery.dart";

class AppImage extends StatelessWidget {
  final bool isAvatar;
  final Size size;
  final AppImageController controller;
  final double cornerRadius;

  const AppImage({
    super.key,
    this.size = const Size(100, 100),
    this.isAvatar = true,
    this.cornerRadius = 0,
    required this.controller,
  });
  bool get isShowAvatarAddButton => (controller.onTap != null);
  bool get isShowImageAddButton => (controller.onTap != null &&
      controller.url != null &&
      controller.url!.isNotEmpty);

  Future<Widget> getImage(
      BuildContext context, AppImageController controller) async {
    String? url = controller.url;

    if (url == null || url.isEmpty) {
      return Image.asset(pathNoImage, package: package);
    }

    if (url.startsWith(protocolReferance)) {
      UploadTaskServices uploadTaskServices =
          context.read<UploadTaskServices>();
      String? imageLocalPath = uploadTaskServices
          .getUploadingImageUrl(url.replaceFirst(protocolReferance, ""));
      if (imageLocalPath != null) {
        url = imageLocalPath;
      } else {
        url = await uploadTaskServices
            .refToUri(url.replaceFirst(protocolReferance, ""));
      }
    }

    if (url.startsWith(protocolLocal)) {
      return Image.file(
        File(url.replaceFirst(protocolLocal, "")),
        fit: BoxFit.fill,
      );
    }

    if (url.startsWith(protocolAvatar)) {
      String avatarPath = url.replaceFirst(protocolAvatar, "");
      return Image.asset(avatarPath, package: package);
    }

    if (url.startsWith(protocolHttp) || url.startsWith(protocolHttps)) {
      return Image.network(url);
    }

    return Image.asset(pathUndefined, package: package);
  }

  Widget _addImageButton(BuildContext context, Function() onTap) {
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
          child:
              IconButton(onPressed: onTap, icon: const Icon(Icons.add_a_photo)),
        ),
      ),
    );
  }

  Widget _alertBadge(BuildContext context) {
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

  Widget _circleAvatarWidget(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: size.width,
          child: FutureBuilder<Widget>(
            future: getImage(context, controller),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!;
              }

              if (snapshot.hasError) {
                return const CircleAvatar(child: Text("E"));
              }

              return CommonScreens.wait;
            },
          ),
        ),
        Visibility(
          visible: isShowAvatarAddButton,
          child: _addImageButton(context, () => controller.onTap),
        ),
        Visibility(
            visible: controller.showAlertBadge, child: _alertBadge(context))
      ],
    );
  }

  Widget _imageWidget(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => (controller.onTap != null && !isShowImageAddButton)
            ? controller.onTap!(context)
            : null,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            fit: StackFit.loose,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius),
                child: FutureBuilder<Widget>(
                  future: getImage(context, controller),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return snapshot.data!;
                    }

                    if (snapshot.hasError) {
                      return const CircleAvatar(child: Text("E"));
                    }

                    return CommonScreens.wait;
                  },
                ),
              ),
              Visibility(
                visible: isShowImageAddButton,
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: _addImageButton(
                        context, () => controller.onTap!(context))),
              ),
              Visibility(
                  visible: controller.showAlertBadge,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: _alertBadge(context)))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      child: ValueListenableBuilder<AppImageData>(
        valueListenable: controller,
        builder: (context, value, _) {
          if (isAvatar) {
            return _circleAvatarWidget(context);
          }

          return _imageWidget(context);
        },
      ),
    );
  }
}
