require 'google_drive'

session = GoogleDrive.login("eternalsushant@gmail.com", ENV['password'])

ws = session.spreadsheet_by_key("1XSNzQXMfbD-NaDnU2mdPf4xag7irV22fHaMjplNJEPw").worksheets[0]
Member.delete_all
ws.rows.each do |t|
    m = Member.new
    m[:name] = t[0]
    m[:contact] = t[2]
    m[:ieee_number] = t[3]
    m[:branch] = t[4]
    m[:email] = t[5]
    m.save
    puts m.inspect
end
