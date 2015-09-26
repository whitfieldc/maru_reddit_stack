defmodule MaruRedditStack.Router.Homepage do
  use Maru.Router

  get do
    %{ hello: :world }
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

"http://reddit.com/r/" <> subreddit <> ".json"