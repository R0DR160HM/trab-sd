import consultar_estoque/generic_response
import gleam/bytes_builder
import gleam/http/response
import gleam/int
import gleam/json
import mist

pub fn discount() -> response.Response(mist.ResponseData) {
  int.random(2)
  |> discount_to_json
  |> bytes_builder.from_string
  |> generic_response.ok
}

fn discount_to_json(discount: Int) -> String {
  json.object([#("desconto", json.int(discount))])
  |> json.to_string
}
