require 'awesome_print'
require 'capybara'
require 'capybara/cucumber'
require 'os'
require 'selenium-webdriver'

require_relative 'helpers'

World(Helpers)

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV['ENV_TYPE']}.yaml"))

case ENV['BROWSER']
when 'chrome'
  @driver = :selenium_chrome
when 'firefox'
  @driver = :selenium
when 'chrome_headless'
  @driver = :selenium_chrome_headless 
when 'firefox_headless'
  @driver = :selenium_headless
end

Capybara.configure do |config|
  config.default_driver = @driver
  config.app_host = CONFIG['url']
  config.default_max_wait_time = 5
end
