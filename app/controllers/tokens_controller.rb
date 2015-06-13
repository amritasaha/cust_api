class TokensController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  prepend_before_filter :authenticate_scope!, :except => [:create, :destroy,:register]
  respond_to :json


  def register
    build_resource(user_params)
    if resource.save
      @user = resource
      @user.set_client(client_params)
      render :status => 200, :json => {:token => @user.authentication_token} and return
    else
      render :status => 400, :json => {:errors => @user.errors.full_messages} and return
    end
  end


  def create
      @user=User.find_by_email(user_params[:email].downcase)
      render :status => 401, :json => {:message => "Invalid email or passoword."} and return if @user.nil?
      if @user.valid_password?(user_params[:password])
        @user.set_client(client_params)
        render :status=>200, :json => {:token => @user.authentication_token}
      else
        render :status=>401, :json => {:message => "Invalid email or password."}
      end
  end



  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status=>404, :json => {:message => "Invalid token."}
    else
      @user.authentication_token=""
      @user.save
      render :status=>200, :json => {:token => params[:id]}
    end
  end

  private
  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation)

  end

  def client_params
    params.require(:client).permit!
    #params.require(:client).permit( :app_version, :app_id, :device_id, :platform,:os_version,:device_name,:model)
  end

  #"client"=> {"app_version"=>"1", "app_id"=>"com.yourcompany.myapp",
  #   "device_id"=>"8FDBD889-531F-4FAE-9B14-DEBF1C3ED3FD", "platform"=>"iPhone OS", "os_version"=>"7.1", "device_name"=>"Mohit's iPad", "model"=>"iPad Mini"}

end