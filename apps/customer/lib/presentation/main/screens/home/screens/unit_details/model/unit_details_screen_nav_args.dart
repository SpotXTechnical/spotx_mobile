class UnitDetailsScreenNavArgs {
  String id;
  UnitDetailsScreenType type;
  UnitDetailsScreenNavArgs(this.id, this.type);
}

enum UnitDetailsScreenType { offer, normalUnit }
