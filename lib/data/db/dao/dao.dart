abstract class BaseDao<T>{

  /// abstract mapping methods
  T fromMap(Map<String, dynamic> query);
  List<T> fromList(List<Map<String,dynamic>> query);
  Map<String, dynamic> toMap(T object);

  /// abstract db manipulation methods
  Future<int> insert(T data);
  Future delete(T data);
  Future<List<T>?>? getAllFromDb();
  Future<T?>? getFromDb(int id);
  Future update(T data);
}

const tableColumnCreatedDate = 'createdDate';
const tableColumnModifiedDate = 'modifiedDate';