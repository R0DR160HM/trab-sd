import gleam/bytes_builder
import gleam/http/response.{type Response}
import mist.{type ResponseData}

pub fn ok(body: bytes_builder.BytesBuilder) -> Response(ResponseData) {
  response.new(200)
  |> response.set_header("Content-Type", "application/json")
  |> response.set_body(mist.Bytes(body))
}

pub fn not_found() -> Response(ResponseData) {
  response.new(404)
  |> response.set_body(mist.Bytes(bytes_builder.from_string("Not found")))
}

pub fn method_not_allowed() -> Response(ResponseData) {
  response.new(405)
  |> response.set_body(
    mist.Bytes(bytes_builder.from_string("Method not allowed!")),
  )
}
