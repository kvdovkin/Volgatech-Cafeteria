package app.cafeteria.exceptions

class NestedEntityNotFoundException(entityName: String, ids: Set<Int>) :
    Exception("Entity ${entityName}, id(s)=${ids.joinToString()} not found in the database")
