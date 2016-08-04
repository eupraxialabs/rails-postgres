require 'test_helper'

class PvprovisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pvprovision = pvprovisions(:one)
  end

  test "should get index" do
    get pvprovisions_url
    assert_response :success
  end

  test "should get new" do
    get new_pvprovision_url
    assert_response :success
  end

  test "should create pvprovision" do
    assert_difference('Pvprovision.count') do
      post pvprovisions_url, params: { pvprovision: {  } }
    end

    assert_redirected_to pvprovision_url(Pvprovision.last)
  end

  test "should show pvprovision" do
    get pvprovision_url(@pvprovision)
    assert_response :success
  end

  test "should get edit" do
    get edit_pvprovision_url(@pvprovision)
    assert_response :success
  end

  test "should update pvprovision" do
    patch pvprovision_url(@pvprovision), params: { pvprovision: {  } }
    assert_redirected_to pvprovision_url(@pvprovision)
  end

  test "should destroy pvprovision" do
    assert_difference('Pvprovision.count', -1) do
      delete pvprovision_url(@pvprovision)
    end

    assert_redirected_to pvprovisions_url
  end
end
