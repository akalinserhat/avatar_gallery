library avatar_gallery;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:refreshable_button_group/refreshable_button_group.dart';

part 'src/avatar_gallery.dart';
part 'src/avatar_pickup.dart';
part 'src/avatar_tags_model.dart';
part 'src/avatar_grid_view.dart';
part 'src/circle_avatar_has_action.dart';
part 'src/circle_avatar_has_action_controller.dart';

const String protocolAvatar = "avatar://";
const String protocolHttp = "http://";
const String pathDefaultAvatar = "lib/assets/0.png";
const String package = "avatar_gallery/";
