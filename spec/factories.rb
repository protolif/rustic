Factory.sequence :email do |n|
  "user-#{n}@example.com"
end

Factory.define :user do |user|
  user.fname   "Joseph"
  user.lname   "Khamel"
  user.tel     "123.456.7890"
  user.address "123 Example Street"
  user.city    "Indianapolis"
  user.state   "IN"
  user.zip     "46268"
  user.password              "pa55w0rD"
  user.password_confirmation "pa55w0rD"
  user.sequence(:email) { |n| "foo-#{n}@example.com" }
end

Factory.define :computer do |computer|
  computer.make "Apple"
  computer.model "MacBook Pro"
  computer.serial "a103847594"
  computer.checked_in Time.now
  computer.association :user
end

Factory.define :ticket do |ticket|
  ticket.issue "Lorem ipsum dolor sit amet"
  ticket.status "In Queue"
  ticket.association :customer, :factory => :user
  ticket.association :computer, :factory => :computer
end