###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

require 'rack/request'
begin
  require 'dotenv'
  Dotenv.load
rescue
end

require 'mail'

Mail.defaults do
  delivery_method :smtp,
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: 'plain',
    enable_ssl: true,
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD']
end

class ContactForm
  def initialize(app)
    @app = app
  end

  def call(env)
    if request(env).path == '/contact_submission'
      # request.params
      # mail = Mail.new do
      #   from 'rowlandjl82@gmail.com'
      #   to 'rowlandjl82@gmail.com'
      #   subject 'Personal Site Contact Inquiry'
      #   body 'hello from test'
      # end
      # mail.deliver
      [200, {'Content-Type' => 'text/html'}, ['Thanks for submitting']]

    else
      @app.call(env)
    end
  end

  protected
  def request(env)
    @request = ::Rack::Request.new(env)
  end
end
use ContactForm
###
# Helpers
###

# activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
# end

page "/feed.xml", layout: false
# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
