# frozen_string_literal: true

Rails.application.routes.draw do
  get 'samples/index'
  get 'samples/show'
  get 'samples/new'
  resources :samples

  root 'samples#index'
end
