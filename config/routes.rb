Rails.application.routes.draw do
  root 'pages#home'

  get "/pages/:page", to: "pages#show"
  get "/offline-form-jQuery", to: "visit_notes#jQueryLocalStorage"
  get "/offline-form-pouchDB", to: "visit_notes#pouchDB"
  post "/visit-note", to: "visit_notes#create"
  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all
end
