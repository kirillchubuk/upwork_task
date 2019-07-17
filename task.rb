require 'selenium-webdriver'

class FirefoxBrowser < Selenium::WebDriver::Driver


	def initialize
		# Initialize driver for firefox browser
		@browser = Selenium::WebDriver.for :firefox
		# Maximize the window
		# @browser.manage.window.maximize
		# # Delete all cookies
		# @browser.manage.delete_all_cookies
		Selenium::WebDriver.logger.output = 'selenium.log'
	end

	def navigate(url)
		@browser.navigate.to url
	end

	def find_element(attr, value)
		@element = @browser.find_element(attr, value)
	end

	def click_and_sendkeys(key)
		@element.click
		@element.send_keys key
	end

	def find_element_and_click(attr, value)
		@browser.find_element(attr, value).click
	end

	def element_check_keyword(key)
		puts "'#{key}' keyword found" if @element.text.to_s.downcase.include? key
	end

	def find_elements(attr, value)
		@elements = @browser.find_elements(attr, value)
	end

	def elements_check_keyword(key)
		i = 1
		@elements.each do |el|
			if el.text.to_s.downcase.include? key
				puts "'#{key}' keyword found for element #{i}"	
			else
				puts "'#{key}' keyword NOT found for element #{i}"
			end
			i += 1 
		end
	end



	def close_browser
		@browser.quit
	end
end

url = "https://upwork.com"
keyword = "qa"

puts "Initialize Selenium Firefox driver"
browser = FirefoxBrowser.new

puts "Navigate to the url"
browser.navigate(url)

puts "Find 'Find Freelancers' search-box element"
browser.find_element(:css, '.sticky-sublocation .form-control')

puts "Click 'Find Freelancers' search-box element and insert the keyword"
browser.click_and_sendkeys(keyword)

puts "Submit the search by keyword"
browser.find_element_and_click(:css, '.sticky-sublocation .p-0-left-right')

puts "Find the section with Freelancer profiles"
browser.find_elements(:css, '#oContractorResults .air-card-hover_tile')

puts "Make sure at least 1 attribute contains the keyword "
browser.elements_check_keyword(keyword)

puts "Find the title (only the first one) and click"
browser.find_element_and_click(:css, 'h4 > a')

puts "Find the freelancer profile"
browser.find_element(:class, "air-card m-0-top-bottom")
browser.element_check_keyword(keyword)

puts "Close the browser"
browser.close_browser
