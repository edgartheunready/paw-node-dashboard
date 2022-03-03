require "application_system_test_case"

class TribesTest < ApplicationSystemTestCase
  setup do
    @tribe = tribes(:one)
  end

  test "visiting the index" do
    visit tribes_url
    assert_selector "h1", text: "Tribes"
  end

  test "should create tribe" do
    visit tribes_url
    click_on "New tribe"

    fill_in "Name", with: @tribe.name
    fill_in "Uuid", with: @tribe.uuid
    click_on "Create Tribe"

    assert_text "Tribe was successfully created"
    click_on "Back"
  end

  test "should update Tribe" do
    visit tribe_url(@tribe)
    click_on "Edit this tribe", match: :first

    fill_in "Name", with: @tribe.name
    fill_in "Uuid", with: @tribe.uuid
    click_on "Update Tribe"

    assert_text "Tribe was successfully updated"
    click_on "Back"
  end

  test "should destroy Tribe" do
    visit tribe_url(@tribe)
    click_on "Destroy this tribe", match: :first

    assert_text "Tribe was successfully destroyed"
  end
end
