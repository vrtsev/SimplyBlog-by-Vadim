FactoryGirl.define do 

	factory :post do

		title "Название поста"
		content "Lorem ipsum dolor sit amet"
		likes 1
		association(:user)

	end
	
end