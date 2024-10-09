import gleam/float
import gleam/int

pub fn string_to_float(n: String) {
  case float.parse(n) {
    Ok(f) -> Ok(f)
    Error(_) ->
      case int.parse(n) {
        Ok(i) -> Ok(int.to_float(i))
        Error(_) -> Error(Nil)
      }
  }
}
