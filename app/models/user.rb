require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable




    include RoleModel

    ROLES = %w[admin usuario]

    def is?(role)
	    roles.include?(role.to_s)
	end

  	def roles=(roles)
	  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
	end

	def roles
	  ROLES.reject do |r|
	    ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
	  end
	end

	def self.search(search)  
    if search  
      where('nome LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end  

end