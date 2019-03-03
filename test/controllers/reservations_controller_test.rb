require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "should redirect to login" do
    get reservations_url
    assert_response :redirect
  end

  test "should get index" do
     @customer = customers(:one)
    login_as(@customer, :scope => :customer)
    get reservations_url
    assert_response :success
  end

  test "should get new" do
     @customer = customers(:one)
    login_as(@customer, :scope => :customer)
    date = (Date.today + 1).strftime("%Y-%m-%d")
    get new_reservation_url(selected_day: date)
    assert_response :success
  end

end
