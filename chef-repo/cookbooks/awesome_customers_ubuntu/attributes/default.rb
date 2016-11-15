def random_password
  require 'securerandom'
  SecureRandom.base64
end

default['awesome_customers_ubuntu']['user'] = 'web_admin'
default['awesome_customers_ubuntu']['group'] = 'web_admin'
default['awesome_customers_ubuntu']['document_root'] = '/var/www/customers/public_html'
  
normal_unless['awesome_customers_ubuntu']['database']['root_password'] = random_password
normal_unless['awesome_customers_ubuntu']['database']['admin_password'] = random_password