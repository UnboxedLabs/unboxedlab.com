UnboxedlabCom::Application.routes.draw do

  root to: 'welcome#home'
  post "/subscribe" => "contacts#create"
end
