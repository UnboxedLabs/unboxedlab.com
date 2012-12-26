UnboxedlabCom::Application.routes.draw do

  root to: 'welcome#home'
  post "/subscribe" => "contacts#create"
  get  "/contacts"  => "contacts#index"

end
