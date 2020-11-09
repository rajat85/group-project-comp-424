require "prawn"

class HomeController < ApplicationController
  def index
  end

  def download_pdf
    send_data generate_pdf(current_user),
              filename: "#{current_user.first_name}-#{current_user.last_name}.pdf",
              type: "application/pdf"
  end

  private

  def generate_pdf(user)
    Prawn::Document.new do
      text "#{user.first_name} #{user.last_name}", align: :center
      text "Email: #{user.email}"
      text "Date of birth: #{user.date_of_birth.try(:strftime,"%m/%d/%Y")}"
    end.render
  end

end
