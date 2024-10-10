import consultar_estoque/generic_response
import consultar_estoque/utils
import gleam/bytes_builder
import gleam/http/response
import gleam/json
import mist

pub fn soma(i: String, j: String) {
  use f1, f2 <- parse(i, j)
  f1 +. f2
}

pub fn subtracao(i: String, j: String) {
  use f1, f2 <- parse(i, j)
  f1 -. f2
}

pub fn multiplicacao(i: String, j: String) {
  use f1, f2 <- parse(i, j)
  f1 *. f2
}

pub fn divisao(i: String, j: String) {
  case utils.string_to_float(j) {
    Ok(0.0) ->
      response.new(500)
      |> response.set_body(
        mist.Bytes(bytes_builder.from_string("Unable to divide by 0")),
      )
    _ -> {
      use f1, f2 <- parse(i, j)
      f1 /. f2
    }
  }
}

fn parse(value1: String, value2: String, callback: fn(Float, Float) -> Float) {
  case utils.string_to_float(value1), utils.string_to_float(value2) {
    Ok(f1), Ok(f2) -> callback(f1, f2) |> float_to_response
    _, _ -> not_number()
  }
}

fn float_to_response(number: Float) {
  json.object([#("value", json.float(number))])
  |> json.to_string
  |> bytes_builder.from_string
  |> generic_response.ok
}

fn not_number() {
  response.new(500)
  |> response.set_body(
    mist.Bytes(bytes_builder.from_string("Please provide numbers")),
  )
}
