Feature: Edit tags

  Background:
    Given I activate tagedit experimental features

  Scenario: Insert tag
    When I type "<div"
    Then I should see "<div></div>"

  Scenario: Insert tag with attribute
    When I type "<div data-something"
    Then I should see "<div data-something></div>"

  Scenario: Insert self-closing tag
    When I type "<input"
    Then I should see "<input>"
    And I should not see "</input>"

  Scenario: Edit tag
    Given I insert "<div id="abc">def</div>"
    When I go to the end of the word "div"
    And I type "s"
    Then I should see "<divs id="abc">def</divs>"

  Scenario: Break up a tag
    Given I insert "<div id="abc">def</div>"
    When I go to the end of the word "div"
    And I press "C-b"
    And I type " "
    Then I should see "<di v id="abc">def</di>"

  Scenario: Edit self-closing tag
    Given I insert "<input type="text"> abc"
    When I go to the end of the word "input"
    And I type "ss"
    Then I should see "<inputss type="text"></inputss> abc"

  Scenario: Closing a tag with />
    When I type "<h3/"
    Then I should see "<h3/>"
    And I should not see "</h3>"

  # Known bug: reopening a self-closing tag
  #
  # Scenario: Opening a tag with />
  #   Given I insert "<h3/>"
  #   When I go to the end of the word "h3"
  #   And I press "C-f"
  #   And I press "DEL"
  #   Then I should see "<h3></h3>"

  Scenario: Do not allow self-closing divs
    When I type "<div/"
    Then I should see "<div></div>"

  Scenario: Do not allow self-closing spans
    When I type "<span/"
    Then I should see "<span></span>"

  Scenario: JSTL tags
    When I type "<c:forEach"
    Then I should see "<c:forEach></c:forEach>"

  Scenario: Don't destroy invalid markup
    Given I insert "<div id>"
    When I go to the end of the word "div"
    And I type "ss"
    Then I should see "<divss id>"

  # editing the end-tag
  # støtte for, evnt disabled ved, multiple cursors
