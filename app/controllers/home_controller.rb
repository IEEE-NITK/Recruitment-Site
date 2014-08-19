require 'json'
require 'open-uri'
class HomeController < ApplicationController

    def index
        @q = JSON.parse(open("http://yodaweb.heroku.com/quote").read)["quote"]
        puts @q
    end

    def insert
        @applicant = Applicant.new
        @dates = getDates
        member = Member.where(ieee_number: session[:ieee_number]).first
        @applicant.name = member.name
        @applicant.email = member.email
        @applicant.ieee_number = member.ieee_number
        @applicant.contact = member.contact
        @applicant.branch = member.branch
    end

    def validate
        ieee_no = params[:IEEE]
        member = Member.where(ieee_number: ieee_no).first
        if member.nil?
            flash[:notice] = "Invalid IEEE Number"
            redirect_to(action: "index")
            return false
        end
        session[:ieee_number] = ieee_no
        temp = Applicant.where(ieee_number: session[:ieee_number]).first
        if temp
            redirect_to action: "registered"
            return false
        end
        redirect_to(action: "insert")
    end

    def submit
        temp = Applicant.where(ieee_number: session[:ieee_number]).first
        if temp.nil?
            member = Member.where(ieee_number: session[:ieee_number])
            if member
                @applicant = Applicant.create(applicant_params)
                if @applicant
                    @applicant.ieee_number = session[:ieee_number]
                    @applicant.save!
                    redirect_to(action: "success")
                else
                    redirect_to(action: "insert")
                    return false
                end
            else
                redirect_to(action: "failure")
                return false
            end
        else
            redirect_to(action: "registered")
            return false
        end
    rescue ActiveRecord::RecordInvalid
        puts @applicant.errors.any?
        @dates = getDates
        render(action: "insert")
        return false
    end

    def success
    end

    def failure
    end

    def registered
    end

    private

    def applicant_params
        params.require(:applicant).permit(:date,:name,:email,:contact,:branch,:sig,:interests,:summerProject_title,:summerProject_contribution,:extras)
    end

    def getDates
        dates = {Python: (25..30).to_a, Piston: (25..30).to_a, Diode: (25..30).to_a}
        s = [:Python, :Piston, :Diode]
        s.each do |q|
            d = Applicant.where(sig: q).order(:date).pluck(:date)
            dates[q].each do |f|
                if d.count(f) == 30
                    dates[q].delete(f)
                end
            end
        end
        return JSON.dump(dates)
    end

end
