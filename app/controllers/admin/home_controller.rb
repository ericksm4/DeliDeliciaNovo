class Admin::HomeController < ApplicationController
	load_and_authorize_resource :class => Admin::HomeController

    require 'google/api_client'
    # Path to the Service Account's Private Key file #
    SERVICE_ACCOUNT_PKCS12_FILE_PATH = Rails.root.join('config','API Project-a80419b91977.p12').to_s

    def index
        
       service_account_email = '68865177225-clasoaqh1scgfgnoep8vmnbft1vb50vo@developer.gserviceaccount.com' # Email of service account
        key_file = SERVICE_ACCOUNT_PKCS12_FILE_PATH # File containing your private key
        key_secret = 'notasecret' # Password to unlock private key

        client = Google::APIClient.new()

        # Load our credentials for the service account
        key = Google::APIClient::PKCS12.load_key(key_file, key_secret)
        asserter = Google::APIClient::JWTAsserter.new(
            service_account_email,
            'https://www.googleapis.com/auth/analytics.readonly',
            key)

        # Request a token for our service account
        client.authorization = asserter.authorize()
        @token_api = client.authorization.access_token
    end

    
end
