defmodule MaruRedditStack.Router.Homepage do
  use Maru.Router

  get do
    %{ hello: :world }
  end

  get "/:route" do
    # Plug.Conn.send_resp(conn, 200, params[:route] )
    # HTTPoison.start
    # resp = HTTPoison.get!("https://reddit.com/r/" <> params[:route] <> ".json", ["User-Agent": "app:com.marureddit.stack (by /u/retiredhipster)"], [follow_redirect: true])
    # b = Poison.decode! resp.body
    # Plug.Conn.send_resp(conn, 200, resp )
    resp = HTTPoison.get("http://httpbin.org/get", ["User-Agent": "app:com.marureddit.stack (by /u/retiredhipster)"], [follow_redirect: true])
    # IO.puts "hi"
    IO.inspect resp
    # Plug.Conn.send_resp(conn, 200, resp.body )
    # %{ hello: resp }
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

# "http://reddit.com/r/" <> subreddit <> ".json"