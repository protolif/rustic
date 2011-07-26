Factory.define :user do |user|
  user.fname   "Joseph"
  user.lname   "Khamel"
  user.email   "joseph.khamel@example.com"
  user.tel     "123.456.7890"
  user.address "123 Example Street"
  user.city    "Indianapolis"
  user.state   "IN"
  user.zip     "46268"
  user.password              "pa55w0rD"
  user.password_confirmation "pa55w0rD"
end

Factory.sequence :email do |n|
  "user-#{n}@example.com"
end