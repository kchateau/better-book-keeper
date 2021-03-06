Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => redirect('/books/summary')

  resource :books do
    get "shelf"
    get "summary"
    get "search"
    get "more_info"
    post "search_results"
  end
end
