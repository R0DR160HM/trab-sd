import consultar_estoque/generic_response
import consultar_estoque/stock
import gleam/erlang/process
import gleam/http
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import mist

pub fn main() {
  io.println("Starting server...")

  let assert Ok(_) =
    router
    |> mist.new
    |> mist.port(8080)
    |> mist.start_http

  io.println("Server started")
  process.sleep_forever()
}

fn router(req: Request(mist.Connection)) -> Response(mist.ResponseData) {
  case req.path, req.method {
    "/api", http.Get -> stock.discount()
    "/api", _ -> generic_response.method_not_allowed()

    _, _ -> generic_response.not_found()
  }
}
