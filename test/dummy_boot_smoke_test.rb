require "test_helper"

# Guards against the dummy app silently failing to boot again (it once crashed before any test
# could run: Devise's ORM adapter never loaded, ModelDrivenApi missing, minitest 6 vs Rails 7.2).
class DummyBootSmokeTest < ActiveSupport::TestCase
  test "dummy app boots with the engine and reaches its own test database" do
    assert_includes Rails.application.railties.map(&:class), ThecoreDownloadDocuments::Railtie
    assert_equal "thecore_download_documents_test", ActiveRecord::Base.connection_db_config.database
    assert_equal 1, ActiveRecord::Base.connection.select_value("SELECT 1").to_i
  end
end
