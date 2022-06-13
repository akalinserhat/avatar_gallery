part of "../avatar_gallery.dart";

//TO-DO Convert to Stateless widged
class AvatarGridView extends StatefulWidget {
  final List<String> selectedAvatars = [];
  final List<AvatarTags> listAvatarTags;
  final bool multiSelect;
  final Function(List<String> selectedAvatars) onSelectedAvatars;

  AvatarGridView({
    Key? key,
    required this.listAvatarTags,
    required this.onSelectedAvatars,
    this.multiSelect = true,
  }) : super(key: key);

  @override
  State<AvatarGridView> createState() => _AvatarGridViewState();
}

class _AvatarGridViewState extends State<AvatarGridView> {
  List<String> get selectedAvatars => widget.selectedAvatars;
  List<AvatarTags> get listAvatarTags => widget.listAvatarTags;
  int get selectedItemCount => widget.selectedAvatars.length;
  bool get multiSelect => widget.multiSelect;
  Function(List<String> selectedAvatars) get onSelectedAvatars =>
      widget.onSelectedAvatars;

  bool _isSelected(String fileName) {
    return (selectedAvatars.contains(fileName));
  }

  void _deselectAll() {
    selectedAvatars.clear();
  }

  void _deselect(String fileName) {
    setState(() {
      selectedAvatars.remove(fileName);
      onSelectedAvatars(selectedAvatars);
    });
  }

  void _selectIt(String fileName) {
    setState(() {
      if (!multiSelect) _deselectAll();
      selectedAvatars.add(fileName);
      onSelectedAvatars(selectedAvatars);
    });
  }

  void _onLongPressAvatar(String fileName) {
    if (_isSelected(fileName)) {
      _deselect(fileName);
    } else {
      _selectIt(fileName);
    }
  }

  void _onTapAvatar(String fileName) {
    if (_isSelected(fileName)) {
      _deselect(fileName);
    } else {
      _selectIt(fileName);
    }
  }

  Widget _avatarWidget(String fileName) {
    return GestureDetector(
      onLongPress: () => _onLongPressAvatar(fileName),
      onTap: () => _onTapAvatar(fileName),
      child: Stack(children: [
        (_isSelected(fileName))
            ? Container(color: Theme.of(context).focusColor)
            : Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "lib/assets/$fileName",
            package: "avatar_gallery",
          ),
        ),
        (_isSelected(fileName))
            ? Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "lib/assets/check.png",
                  package: "avatar_gallery",
                  width: 20,
                ),
              )
            : Container(),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculate crossAxisCount
    final Size size = MediaQuery.of(context).size;
    final int crossAxisCount = (size.width ~/ 80); // .toInt();

    //Gridview
    return GridView.count(
      padding: const EdgeInsets.all(24),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: crossAxisCount,
      children: listAvatarTags.map((e) => _avatarWidget(e.icon)).toList(),
    );
  }
}
