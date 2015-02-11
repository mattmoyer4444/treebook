require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:matt).profile_name

    assert !user.save
    puts user.errors.inspect
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Matt2', last_name: "Moyer2", email: "moyer_m2@yahoo.com")
    user.password = user.password_confirmation = 'password22'


    user.profile_name = "My Profile With Spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Matt2', last_name: "Moyer2", email: "moyer_m2@yahoo.com")
    user.password = user.password_confirmation = 'password22'

    user.profile_name = 'mattmoyer_122'
    assert user.valid?
  end

end
