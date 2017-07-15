class RegistrationsController < Devise::RegistrationsController

      def
        after_sign_up_path_for(resources)
        user_path(resources)
      end

  private

      def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
end