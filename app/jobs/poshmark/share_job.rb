# frozen_string_literal: true

require 'selenium-webdriver'
require 'aws-sdk-s3'
require 'sidekiq'

module Poshmark
  class ShareJob < ApplicationJob
    LOGIN_URL = 'https://poshmark.com/login'

    def perform(username_or_email, password)
      # Set your AWS credentials and S3 bucket details
      aws_access_key_id = Rails.application.credentials.dig(:aws, :access_key_id)
      aws_secret_access_key = Rails.application.credentials.dig(:aws, :secret_access_key)
      s3_bucket_name = Rails.application.config.poshmark[:s3_bucket_name]

      # Set up the Selenium WebDriver
      driver = Selenium::WebDriver.for :chrome

      # Navigate to Poshmark login page
      Rails.logger.info "Navigating to #{LOGIN_URL}"
      driver.navigate.to LOGIN_URL

      # Fill in login credentials
      Rails.logger.info "Logging in as #{username_or_email}"
      driver.find_element(name: 'login_form[username_email]').send_keys(username_or_email)
      driver.find_element(name: 'login_form[password]').send_keys(password)

      # Click on the login button
      driver.find_element(css: 'button[data-et-element-type="button"]').click

      # Wait for login to complete (you may need to adjust the wait time)
      wait = Selenium::WebDriver::Wait.new(timeout: 10)
      wait.until { driver.title.downcase.start_with? 'poshmark' }

      # Take a screenshot
      driver.save_screenshot('poshmark_login.png')

      # Upload the screenshot to S3
      s3 = Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(aws_access_key_id, aws_secret_access_key),
        region: 'your_s3_region' # e.g., 'us-east-1'
      )

      obj = s3.bucket(s3_bucket_name).object('poshmark_login.png')
      obj.upload_file('poshmark_login.png')

      # Close the browser
      driver.quit
    end
  end
end
