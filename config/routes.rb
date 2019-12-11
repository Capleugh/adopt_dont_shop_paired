Rails.application.routes.draw do
  root to: 'shelters#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  get '/shelters/:shelter_id/pets', to: 'pets#index'
  # get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  # create a new controller
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/shelters/:shelter_id/pets/:id/edit', to: 'pets#edit'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/reviews/:review_id', to: 'reviews#update'
  delete '/reviews/:review_id', to: 'reviews#destroy'

  get '/cart', to: 'cart#index'
  patch '/cart/pets/:pet_id', to: 'cart#update'

  delete '/cart', to: 'cart#destroy_all'
  delete '/cart/:pet_id', to: 'cart#destroy'

  get '/adoption_apps/new', to: 'adoption_apps#new'
  post '/adoption_apps', to: 'adoption_apps#create'
  get '/adoption_apps/:app_id', to: 'adoption_apps#show'
  get '/pets/:pet_id/adoption_apps', to: 'adoption_apps#index'
  get "/pets/:pet_id/adoption_apps/:app_id", to: 'pets#show'
end
