
class TodoEntity{
  final bool complete;
  final String id;
  final String note;
  final String task;

  TodoEntity(this.task, this.id, this.note, this.complete);

  
  @override
  int get hashCode=> 
    complete.hashCode ^ id.hashCode ^ note.hashCode ^ task.hashCode;

  @override
  bool operator ==(Object other)=>
    identical(this, other) ||
    (other is TodoEntity) &&
    runtimeType==other.runtimeType &&
    complete==other.complete &&
    id==other.id &&
    note ==other.note &&
    task == other.task;
  
  @override
  String toString() {      
      return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id}';
    }
  
  Map<String, Object> toJson(){
    return{
      "complete":complete,
      "task":task,      
      "note":note,
      "id":id,
    };
  }

  static TodoEntity fromJson(Map<String, Object> json){
    return TodoEntity(
      json['task'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool
    );
  } 
}