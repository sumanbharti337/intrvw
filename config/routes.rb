Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }

  resources :documents do
    collection { post :import }
  end

  get 'document_csv', to: 'documents#doc_csv'
  get 'document_xml', to: 'documents#xml_sitemap'
  get 'document_json', to: 'documents#doc_json'

  get 'patient_csv', to: 'patients#doc_csv'
  get 'patient_xml', to: 'patients#xml_sitemap'
  get 'patient_json', to: 'patients#doc_json'

  resources :patients do
    collection { post :import }
  end

  # devise_for :users
  # devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "documents#index"
end
