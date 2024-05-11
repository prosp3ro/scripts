from selenium import webdriver

chrome_options = webdriver.ChromeOptions()
chrome_options.binary_location = '/usr/bin/chromedriver'
driver = webdriver.Chrome(options=chrome_options)

url = 'http://192.168.32.1'
values = {'txtPwdShow': 'password'}

driver.get(url)

battery_level_element = driver.find_element_by_css_selector('b[data-bind="text: batteryLevel"]')

if battery_level_element:
    battery_level = battery_level_element.text
    print("Battery Level:", battery_level)
else:
    print("Battery level element not found on the page.")

driver.quit()
