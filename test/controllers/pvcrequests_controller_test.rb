require 'test_helper'

class PvcrequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pvcrequest = pvcrequests(:one)
  end

  test "should get index" do
    get pvcrequests_url
    assert_response :success
  end

  test "should get new" do
    get new_pvcrequest_url
    assert_response :success
  end

  test "should create pvcrequest" do
    assert_difference('Pvcrequest.count') do
      post pvcrequests_url, params: { pvcrequest: {  } }
    end

    assert_redirected_to pvcrequest_url(Pvcrequest.last)
  end

  test "should show pvcrequest" do
    get pvcrequest_url(@pvcrequest)
    assert_response :success
  end

  test "should get edit" do
    get edit_pvcrequest_url(@pvcrequest)
    assert_response :success
  end

  test "should update pvcrequest" do
    patch pvcrequest_url(@pvcrequest), params: { pvcrequest: {  } }
    assert_redirected_to pvcrequest_url(@pvcrequest)
  end

  test "should destroy pvcrequest" do
    assert_difference('Pvcrequest.count', -1) do
      delete pvcrequest_url(@pvcrequest)
    end

    assert_redirected_to pvcrequests_url
  end
end
