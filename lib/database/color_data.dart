class ColorsConst {
  static const densityColorTable = "density_color_table";
  static const colorTable = "color_table";
  static const isLocked = "is_locked";
  static const colorId = "color_id";
  static const colorCode = "color_code";
  static const selected = "selected";
  static const parentColorCode = "parent_color_code";
  static const previousColor = "previous_color";
  static const int lockedColor = 1;
  static const int unLockedColor = 0;
}

class ColorTable {
  String colorCode;
  int selected;
  int previousColor;
  int isLocked;

  ColorTable({
    required this.colorCode,
    required this.selected,
    required this.previousColor,
    required this.isLocked,
  });

  Map<String, dynamic> toMap() {
    return {
      "color_code": colorCode,
      "selected": selected,
      "previous_color": previousColor,
      "is_locked": isLocked
    };
  }

  factory ColorTable.fromMap(Map<String, dynamic> map) {
    return ColorTable(
        colorCode: map["color_code"],
        previousColor: map["previous_color"],
        selected: map["selected"],
        isLocked: map["is_locked"]);
  }
}

class LockColor {
  String colorCode;
  String selected;
  String previousColor;

  LockColor(
      {required this.previousColor,
      required this.colorCode,
      required this.selected});

  Map<String, dynamic> toMap() {
    return {
      "color_code": colorCode,
      "selected": selected,
      "previous_color": previousColor,
    };
  }

  LockColor fromMap(Map<String, dynamic> map) {
    return LockColor(
        colorCode: map["color_code"],
        previousColor: map["previous_color"],
        selected: map["selected"]);
  }
}

class DensityColor {
  String colorCode;
  String selected;
  String previousColor;
  String parentColorCode;
  DensityColor({
    required this.colorCode,
    required this.selected,
    required this.previousColor,
    required this.parentColorCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "color_code": colorCode,
      "selected": selected,
      "previous_color": previousColor,
      "parent_color_code": parentColorCode
    };
  }

  factory DensityColor.fromMap(Map<String, dynamic> map) {
    return DensityColor(
        colorCode: map["color_code"],
        previousColor: map["previous_color"],
        selected: map["selected"],
        parentColorCode: map["parent_color_code"]);
  }
}
