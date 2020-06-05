Rails.application.routes.draw do
  root to: "cocktails#index"
  resources :doses, only: [:index, :show, :edit, :update, :destroy]
  resources :cocktails, only: [:index, :show, :new, :create, :destroy] do
    resources :doses, only: [:new, :create]
  end


end

# #COCKTAIL

# GET "cocktails"
# GET "cocktails/42"
# GET "cocktails/new"
# POST "cocktails"


# #DOSE
# GET "cocktails/42/doses/new"
# POST "cocktails/42/doses"
# DELETE "doses/25"
