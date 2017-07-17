RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end

# I believe this is unnecessary, keeping for a little while though
# RSpec.configure do |config|
#   config.before(:suite) do
#     begin
#       DatabaseCleaner.start
#       FactoryGirl.lint
#     ensure
#       DatabaseCleaner.clean_with(:truncation)
#     end
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.strategy = :transaction
#   end
#
#   config.before(:each, :js => true) do
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   config.before(:each) do
#     DatabaseCleaner.start
#   end
#
#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
# end
