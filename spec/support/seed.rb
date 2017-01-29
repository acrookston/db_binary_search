# Creating hourly log items from 2017-01-06 00:00 to 2017-01-09 00:00
start_time = DateTime.parse("2017-01-06 00:00:00")
(0..72).each do |i|
  Log.create(created_at: start_time + i.hours)
end
