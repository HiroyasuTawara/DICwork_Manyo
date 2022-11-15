50.times do |n|
  name = "label#{n}"
  color = ["orangered", "mediumseagreen", "royalblue", "darkorange", "lightslategray", "hotpink"].sample
  @user = User.find(n % 10 + 1) 
  label = Label.find_or_initialize_by(name:  "label#{n}")
  if label.new_record?
    label.name = name
    label.color = color
    label.user_id = @user.id
    label.save!
  end
end

puts "labels = #{Label.count}"