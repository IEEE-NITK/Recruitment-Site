require 'google_drive'

#session = GoogleDrive.login(ENV['id'], ENV['password'])

#ws = session.spreadsheet_by_key(ENV['link']).worksheets[0]
#Member.delete_all
#ws.rows.each do |t|
 #   m = Member.new
 #  m[:name] = t[0]
 #   m[:contact] = t[2]
 #   m[:ieee_number] = t[3]
 #   m[:branch] = t[4]
 #   m[:email] = t[5]
 #   m.save
 #   puts m.inspect
#end

session = GoogleDrive.login("", '')
ws = session.spreadsheet_by_key('').worksheets[0]

m = Applicant.all

m.each do |x|
    ws [x.id,1] =x.id
    ws [x.id,2] = x.name
    ws [x.id,3] = x.ieee_number
    ws [x.id,4] = x.email
    ws [x.id,5] = x.contact
    ws [x.id,6] = x.sig
    ws [x.id,7] = x.date
    ws [x.id,8] = x.branch
    ws [x.id,9] = x.interests
    ws [x.id,10] = x.summerProject_title
    ws [x.id,11] = x.summerProject_contribution
    ws [x.id,12] = x.extras
    ws [x.id,13] = x.created_at
    ws.save
end
