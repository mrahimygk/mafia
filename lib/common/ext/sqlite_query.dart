
extension MakeWhereQuery on List<int> {
  String makeWhereQuery() {
    final StringBuffer whereList = StringBuffer("(");
    forEach((id) {
      whereList.write("?, ");
    });
    final tmp = whereList.toString();
    return tmp.replaceFirst(",", ")", tmp.length - 2);
  }
}
