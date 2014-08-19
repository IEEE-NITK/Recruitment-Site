require 'google_drive'
class Applicant < ActiveRecord::Base

    validates :name, presence: true
    validates :email, presence: true
    validates :contact, presence: true
    validates :sig, presence: true
    validates :date, presence: true
    validates :branch, presence: true

    validate :maximum_capacity_reached?, on: :save

    after_save :write_to_sheets

    def maximum_capacity_reached?
        a = Applicant.where(sig: sig).order(:date).pluck(:date)
        if a.count(date) >= 30
            errors.add(:date,"No slot available for the chosen date.")
        end
    end

    def write_to_sheets
        session = GoogleDrive.login("", '')
        ws = session.spreadsheet_by_key('').worksheets[0]

        ws [id,1] = id
        ws [id,2] = name
        ws [id,3] = ieee_number
        ws [id,4] = email
        ws [id,5] = contact
        ws [id,6] = sig
        ws [id,7] = date
        ws [id,8] = branch
        ws [id,9] = interests
        ws [id,10] = summerProject_title
        ws [id,11] = summerProject_contribution
        ws [id,12] = extras
        ws [id,13] = created_at

        puts ws.inspect
        ws.save
    end

end
