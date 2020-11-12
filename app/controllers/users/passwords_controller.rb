# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
    # puts("&&&&&&&&&&&&&&&&&&&")
    # puts("Under create")
    # puts("&&&&&&&&&&&&&&&&&&&")
		# @username = params[:user][:email]
		# @questionID = !params[:user][:security_question_id].nil? ? params[:user][:security_question_id] : nil
		# @answer = !params[:user][:security_question_answer].nil? ? params[:user][:security_question_answer] : nil
    #
		# # first find all matching email can't work with nil
		# @users = User.where(:email => @username)
		# @ret = false
		# if(@users.empty?)
		# 	flash[:error] = "There are no users with the username #{@username}."
		# 	@ret = true
		# end
		# if(@questionID.nil? || @questionID.empty?)
		# 	flash[:error] = "Select the question you originally selected!"
		# 	@ret = true
		# end
		# if(@answer.nil? || @answer.empty?)
		# 	flash[:error] = "Enter your original answer to the security question."
		# 	@ret = true
		# end
		# if(@ret)
		# 	return
		# end
    #
    #
		# # so there's a user by this username
		# @user = User.find_by_email(@username)
		# if(@user.security_question_id.to_s != @questionID.to_s)
		# 	flash[:error] = "That's not the original question you chose! #{@user.security_question_id}  #{@questionID}"
		# 	return
		# end
		# @answerTest = @answer.gsub(/[^0-9a-z]/i, '').downcase
		# @answerTarget = @user.security_question_answer.gsub(/[^0-9a-z]/i, '').downcase
		# if(!@user.nil? && (@user.security_question_id.to_s == @questionID.to_s) && (@answerTest == @answerTarget))
		# 	sign_in @user, :bypass => true
		# 	flash[:notice] =  "You are now logged in!"
		# 	# redirect_to root_path and return
		# 	# return
		# else
		# 	flash[:notice] =  "The answer you entered is not your original answer."
		# end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
