class App < Sinatra::Base
  set :public_folder, File.expand_path("../public", __FILE__)
  get "/" do
    erb :index
  end
  post "/write" do
    Bugs.publish params["message"]
    sleep 0.1
    redirect "/"
  end
end