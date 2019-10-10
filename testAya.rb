require 'selenium-webdriver'
require 'yaml'

Selenium::WebDriver::Chrome.driver_path="/Users/ayynurp/Downloads/chromedriver"
driver = Selenium::WebDriver.for :chrome

driver.navigate.to "https://github.com/"
signin = driver.find_element(:class, 'HeaderMenu-link.no-underline.mr-3')
signin.click
username = driver.find_element(:id, 'login_field')
password = driver.find_element(:id, 'password')

username1=YAML.load_file('account.yml').fetch('username')
password2=YAML.load_file('account.yml').fetch('password')

signinBtn = driver.find_element(:name, "commit")
signinBtn.click

dropdownmenu = driver.find_element(:class, 'Header-link')
dropdownmenu.click
newgist = driver.find_element(:href, 'https://gist.github.com')
newgist.click

#As a user, I want to create a public gist.
puts "User create a new gist"
gistdesc = driver.find_element(:name, 'gist[description]')
gistdesc.send_keys "Aya New Gist"
filenameext = driver.find_element(:name, 'gist[contents][][name]')
filenameext.send_keys "ayanewgist.txt"
codebody = driver.find_element(:class, 'CodeMirror-scroll')
codebody.send_keys "This is my first NEW gist"
createpubgistBtn = driver.find_element(:name, 'gist[public]')
createpubgistBtn.click
fileinfo = wait.until {
  filename = browser.find_element(:class, 'file-info')
  filename if filename.displayed?
}
puts "Test Passed: New Gist File found" if fileinfo.displayed?

#As a user, I want to edit an existing gist.
puts "User edit existing gist"
editBtn = driver.find_element(:class, 'btn.btn-sm')
editBtn.click
gistdesc = driver.find_element(:name, 'gist[description]')
gistdesc.send_keys "Aya Edit Gist"
filenameext = driver.find_element(:name, 'gist[contents][][name]')
filenameext.send_keys "ayaeditgist.txt"
codebody = driver.find_element(:class, 'CodeMirror-scroll')
codebody.send_keys "This is my first EDIT gist"
indentmode = driver.find_element(:id, 'indent-mode')
indentmode.click
indentchoosen = driver.find_element(:value, "tab")
indentchoosen.click
indentsize = driver.find_element(:id, 'indent-size')
indentsize.click
indentsizechoosen = driver.find_element(:value, "2")
indentsizechoosen.click
linewrapmode = driver.find_element(:id, 'line-wrap-mode')
linewrapmode.click
linewrapchoosen = driver.find_element(:value, "off")
linewrapchoosen.click
updateBtn = driver.find_element(:class, 'btn.btn-primary')
updateBtn.click
fileinfo = wait.until {
  filename = browser.find_element(:class, 'file-info')
  filename if filename.displayed?
}
puts "Test Passed: Edited Gist File found" if fileinfo.displayed?

#As a user, I want to delete an existing gist.
puts "User delete existing gist"
deleteBtn = driver.find_element(:class, 'btn.btn-sm.btn-danger')
deleteBtn.click
driver.switch_to.alert.accept
deleteGist = driver.find_element(:xpath, "//*[text()='Gist deleted successfully.']")
deleteGist.displayed?

#As a user, I want to see my list of gists.
puts "User can see their own gist"
profile = driver.find_element(:class, 'Header-link name')
profile.click
yourGist = driver.find_element(:xpath, "//*[text()='Your gists']")
yourGist.click
allGist = driver.find_element(:xpath, "//*[text()='All gists']")
allGist.displayed?
