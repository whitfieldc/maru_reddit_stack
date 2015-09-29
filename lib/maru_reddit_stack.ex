defmodule MaruRedditStack.Router.Homepage do
  use Maru.Router

  get do
    %{ hello: :world }
  end

  namespace :w do
    route_param :route do
      desc "get a subreddit by name"
      get do
        resp = Walmart.get!(params[:route]).body
        json_item = Walmart.strip_to_one_json_item(resp)
        Plug.Conn.send_resp(conn, 200, json_item)
      end
    end
  end
end

defmodule MaruRedditStack.API do
  use Maru.Router

  mount MaruRedditStack.Router.Homepage

  rescue_from :all do
    status 500
    "Server Error"
  end
end

defmodule Walmart do
  use HTTPoison.Base

  @expected_fields ~w(
    items name thumbnailImage productUrl
  )

  def process_url(keyword) do
    "http://api.walmartlabs.com/v1/search?apiKey=" <> System.get_env("WALMART_KEY") <>"&query=" <> keyword <> "&sort=price&order=asc&numItems=25"
  end

  def process_response_body(body) do
    Poison.Parser.parse!(body)
  end

  def strip_to_one_json_item(walmart_map) do
    walmart_map["items"]
    |> hd
    |> Poison.Encoder.encode([])
  end
end