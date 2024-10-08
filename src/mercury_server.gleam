import gleam/bytes_builder
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import mercury_server/generic_response
import mist

pub fn main() {
  io.println("Starting server...")

  let assert Ok(_) =
    router
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  io.println("Server started on port 8000")
  process.sleep_forever()
}

fn router(_req: Request(mist.Connection)) -> Response(mist.ResponseData) {
  let body = bytes_builder.from_string("Hello world!")
  generic_response.ok(body)
}
