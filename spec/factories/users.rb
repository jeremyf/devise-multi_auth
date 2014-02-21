# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :devise_multi_auth_user, class: 'User' do
    email 'test@test.com'
    password '12345678'
    password_confirmation '12345678'
  end
end
