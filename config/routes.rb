DropTab::Application.routes.draw do
  resources :entries
  resources :submissions

  # for notifications that our videos have been transcoded
  post "/zencoder-callback" => "zencoder_callback#create", :as => "zencoder_callback"

  root :to => 'entries#index'
end
