abstract class BaseDao<T>{

  String get createTableQuery;

  //abstract mapping methods
  T fromMap(Map<String, dynamic> query);
  List<T> fromList(List<Map<String,dynamic>> query);
  Map<String, dynamic> toMap(T object);
}

const tableColumnCreatedDate = 'createdDate';
const tableColumnModifiedDate = 'modifiedDate';