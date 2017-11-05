FactoryGirl.define do
  factory :audit_log do
    user
    status 0
    start_date (Date.today - 8.days)
    end_date nil 
  end
end
