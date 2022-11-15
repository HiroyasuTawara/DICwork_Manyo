10.times do |n|
  name = "task#{n}"
  priolity = ["低","中","高","最優先"].sample
  status = ["未着手","着手","完了"].sample
  note = "note#{n}"
  expired_at = Date.today + n
  @user = User.find(n + 1) 
  task = Task.find_or_initialize_by(name:  "task#{n}")
  if task.new_record?
    task.name = name
    task.priolity = priolity
    task.status = status
    task.note = note
    task.expired_at = expired_at
    task.user_id = @user.id
    task.save!
  end
end

puts "tasks = #{Task.count}"