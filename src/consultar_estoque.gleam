import consultar_estoque/calculadora
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
  case request.path_segments(req), req.method {
    // 02/10
    ["api"], http.Get -> stock.discount()
    ["api"], _ -> generic_response.method_not_allowed()

    // 09/10
    ["soma", value1, value2], http.Get -> calculadora.soma(value1, value2)
    ["sub", value1, value2], http.Get -> calculadora.subtracao(value1, value2)
    ["mult", value1, value2], http.Get ->
      calculadora.multiplicacao(value1, value2)
    ["div", value1, value2], http.Get -> calculadora.divisao(value1, value2)

    _, _ -> generic_response.not_found()
  }
}
