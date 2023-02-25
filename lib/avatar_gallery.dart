library avatar_gallery;

import 'dart:convert';
import 'dart:io';
import 'package:bizdensiparis_common/common_screens/common_screens.dart';
import 'package:bizdensiparis_core/app_services/app_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:refreshable_button_group/refreshable_button_group.dart';

part 'src/avatar_gallery.dart';
part 'src/avatar_pickup.dart';
part 'src/avatar_tags_model.dart';
part 'src/avatar_grid_view.dart';
part 'src/circle_avatar_has_action.dart';
part 'src/circle_avatar_has_action_controller.dart';
part 'src/app_image.dart';
part 'src/app_image_controller.dart';
part 'src/app_image_data.dart';
part 'src/enum.dart';

const String protocolAvatar = "avatar://";
const String protocolHttp = "http://";
const String protocolHttps = "https://";
const String protocolReferance = "firebase://";
const String protocolLocal = "local://";
const String pathNoImage = "lib/assets/system/no-image.png";
const String pathUndefined = "lib/assets/system/undefined-url.png";
const String pathAddImage = "lib/assets/system/add-image.png";
const String pathDefaultAvatar = "lib/assets/0.png";
const String pathDefaultAddressAvatar = "lib/assets/413.png";
const String pathDefaultAddImage = "lib/assets/system/add-image.png";
const String package = "avatar_gallery";
