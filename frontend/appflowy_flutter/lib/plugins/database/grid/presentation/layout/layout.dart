import 'package:appflowy/plugins/database/application/field/field_info.dart';
import 'package:appflowy_backend/protobuf/flowy-database2/field_settings_entities.pbenum.dart';

import 'sizes.dart';

class GridLayout {
  static double headerWidth(double padding, List<FieldInfo> fields) {
    if (fields.isEmpty) return 0;

    final visibleWidths = fields
        .where(
          (element) =>
              element.visibility != null &&
              element.visibility != FieldVisibility.AlwaysHidden,
        )
        .map((fieldInfo) => fieldInfo.width ?? 150)
        .toList();
    if (visibleWidths.isEmpty) {
      return padding + GridSize.newPropertyButtonWidth;
    }

    final fieldsWidth = visibleWidths.reduce((value, element) => value + element);

    return fieldsWidth + padding + GridSize.newPropertyButtonWidth;
  }
}
