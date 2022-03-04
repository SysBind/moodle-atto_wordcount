@editor @editor_atto @atto @atto_wordcount @atto_media @_file_upload
Feature: Atto wordcount button
  To add words count to Atto editor, I need to use the wordcount button.

  Background:
    Given I log in as "admin"
    And I navigate to "Plugins > Text editors > Atto HTML editor" in site administration
    And I set the field "s_editor_atto_toolbar" to multiline:
    """
    collapse = collapse
    style1 = title, bold, italic
    list = unorderedlist, orderedlist, indent
    links = link
    files = emojipicker, image, media, recordrtc, managefiles, h5p
    style2 = underline, strike, subscript, superscript
    align = align
    insert = equation, charmap, table, clear
    undo = undo
    accessibility = accessibilitychecker, accessibilityhelper
    other = html,wordcount
    """
    And I press "Save changes"
    And the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1        | 0        | 1         |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |

  @javascript
  Scenario: Count words on atto is Zero
    Given I open my profile in edit mode
    And I wait until the page is ready
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    And I set the field "Description" to "<p></p>"
    When I click on "HTML" "button"
    Then I should see "Words: 0"

  @javascript
  Scenario: Count words on atto is Words only
    Given I open my profile in edit mode
    And I wait until the page is ready
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    And I set the field "Description" to multiline:
    """
        <p dir="ltr" style="text-align: left;"></p>
    <pre></pre>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam aliquet, metus at euismod porttitor, arcu velit dictum libero, in egestas diam purus in nibh. Donec congue enim pretium, accumsan justo sed, interdum mauris. Donec vestibulum lectus sed arcu convallis, vitae ultricies lorem ultricies. Morbi rhoncus est eget massa lobortis aliquet. Praesent porttitor ex in mi mollis condimentum. Proin eu mi malesuada sapien mollis venenatis nec sit amet dolor. Maecenas ornare felis vel viverra condimentum. Fusce lacinia tempor metus, a gravida metus bibendum ut. Sed mi velit, luctus at nisl vel, feugiat rhoncus nunc. Quisque at ligula et nunc sagittis dictum. Sed luctus lectus sit amet urna congue bibendum. Donec lobortis mi a magna suscipit, id gravida nibh malesuada. Vivamus luctus elit massa, tincidunt iaculis lacus blandit sit amet. Pellentesque semper elit ac varius commodo. Integer semper ex in ex convallis, at egestas arcu efficitur.</p>
    <p>Donec sed ligula vitae quam tristique varius. Quisque consectetur elementum elit ac euismod. Ut rhoncus arcu nec dictum viverra. Nam vel tristique lacus, id venenatis urna. Morbi condimentum ipsum et faucibus ullamcorper. Phasellus ut velit suscipit, congue tortor ac, molestie libero. Pellentesque non scelerisque nisl. Quisque nec pulvinar augue, eu gravida augue. Sed ullamcorper lorem eu lacus molestie, a mattis dui porttitor. Suspendisse vehicula elementum luctus. Praesent luctus eros sit amet auctor imperdiet. Mauris fringilla nisi massa, nec iaculis magna tempus vitae. Praesent suscipit tortor a lectus ultrices, sit amet condimentum sem imperdiet. Donec quis rutrum dolor. Duis ut nisl ac arcu maximus fermentum.</p>
    <p>Aenean mi metus, eleifend at gravida eget, blandit quis mi. Nunc mauris elit, malesuada nec tortor et, tempor cursus sapien. Curabitur facilisis malesuada mauris, in porttitor nunc tristique at. Fusce et nisi at nibh imperdiet vehicula nec in orci. Duis arcu velit, pulvinar a mauris volutpat, lobortis scelerisque urna. Suspendisse et lectus congue, pharetra enim eu, ultricies dolor. Maecenas arcu sem, iaculis ac lobortis et, vulputate in lacus. Nam non turpis fringilla, ornare lacus bibendum, eleifend purus. Aenean accumsan quam vitae eros placerat aliquam sed a orci. Suspendisse sed sodales magna. Nunc feugiat, magna eget ornare suscipit, nulla urna scelerisque tortor, vel facilisis lectus felis sed enim. Aliquam fermentum blandit nisi ac aliquam.</p>
    <p>Duis pellentesque massa turpis, eu tincidunt augue feugiat nec. Vivamus fermentum ornare diam, in rutrum neque. Suspendisse enim dolor, finibus finibus finibus at, semper vitae purus. In porttitor mi vitae nisi maximus, at vehicula mauris sagittis. Nullam quis blandit risus, quis imperdiet enim. Nulla blandit dignissim lacus. Fusce et vestibulum mauris. Fusce et metus id enim consequat gravida vel sit amet erat. Sed et arcu lectus. Class.</p><br>
    <p></p>
    """
    When I click on "HTML" "button"
    Then I should see "Words: 428"

  @javascript
  Scenario: Count words on atto is Words With Multimedia
    Given I am on homepage
    And I follow "Manage private files..."
    And I upload "lib/editor/atto/tests/fixtures/moodle-logo.webm" file to "Files" filemanager
    And I upload "lib/editor/atto/tests/fixtures/moodle-logo.mp4" file to "Files" filemanager
    And I upload "lib/editor/atto/tests/fixtures/moodle-logo.png" file to "Files" filemanager
    And I upload "lib/editor/atto/tests/fixtures/pretty-good-en.vtt" file to "Files" filemanager
    And I upload "lib/editor/atto/tests/fixtures/pretty-good-sv.vtt" file to "Files" filemanager
    And I click on "Save changes" "button"
    And I open my profile in edit mode
    And I wait until the page is ready
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    And I set the field "Description" to multiline:
    """
        <p dir="ltr" style="text-align: left;"></p>
    <pre></pre>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam aliquet, metus at euismod porttitor, arcu velit dictum libero, in egestas diam purus in nibh. Donec congue enim pretium, accumsan justo sed, interdum mauris. Donec vestibulum lectus sed arcu convallis, vitae ultricies lorem ultricies. Morbi rhoncus est eget massa lobortis aliquet. Praesent porttitor ex in mi mollis condimentum. Proin eu mi malesuada sapien mollis venenatis nec sit amet dolor. Maecenas ornare felis vel viverra condimentum. Fusce lacinia tempor metus, a gravida metus bibendum ut. Sed mi velit, luctus at nisl vel, feugiat rhoncus nunc. Quisque at ligula et nunc sagittis dictum. Sed luctus lectus sit amet urna congue bibendum. Donec lobortis mi a magna suscipit, id gravida nibh malesuada. Vivamus luctus elit massa, tincidunt iaculis lacus blandit sit amet. Pellentesque semper elit ac varius commodo. Integer semper ex in ex convallis, at egestas arcu efficitur.</p>
    <p>Donec sed ligula vitae quam tristique varius. Quisque consectetur elementum elit ac euismod. Ut rhoncus arcu nec dictum viverra. Nam vel tristique lacus, id venenatis urna. Morbi condimentum ipsum et faucibus ullamcorper. Phasellus ut velit suscipit, congue tortor ac, molestie libero. Pellentesque non scelerisque nisl. Quisque nec pulvinar augue, eu gravida augue. Sed ullamcorper lorem eu lacus molestie, a mattis dui porttitor. Suspendisse vehicula elementum luctus. Praesent luctus eros sit amet auctor imperdiet. Mauris fringilla nisi massa, nec iaculis magna tempus vitae. Praesent suscipit tortor a lectus ultrices, sit amet condimentum sem imperdiet. Donec quis rutrum dolor. Duis ut nisl ac arcu maximus fermentum.</p>
    <p>Aenean mi metus, eleifend at gravida eget, blandit quis mi. Nunc mauris elit, malesuada nec tortor et, tempor cursus sapien. Curabitur facilisis malesuada mauris, in porttitor nunc tristique at. Fusce et nisi at nibh imperdiet vehicula nec in orci. Duis arcu velit, pulvinar a mauris volutpat, lobortis scelerisque urna. Suspendisse et lectus congue, pharetra enim eu, ultricies dolor. Maecenas arcu sem, iaculis ac lobortis et, vulputate in lacus. Nam non turpis fringilla, ornare lacus bibendum, eleifend purus. Aenean accumsan quam vitae eros placerat aliquam sed a orci. Suspendisse sed sodales magna. Nunc feugiat, magna eget ornare suscipit, nulla urna scelerisque tortor, vel facilisis lectus felis sed enim. Aliquam fermentum blandit nisi ac aliquam.</p>
    <p>Duis pellentesque massa turpis, eu tincidunt augue feugiat nec. Vivamus fermentum ornare diam, in rutrum neque. Suspendisse enim dolor, finibus finibus finibus at, semper vitae purus. In porttitor mi vitae nisi maximus, at vehicula mauris sagittis. Nullam quis blandit risus, quis imperdiet enim. Nulla blandit dignissim lacus. Fusce et vestibulum mauris. Fusce et metus id enim consequat gravida vel sit amet erat. Sed et arcu lectus. Class.</p><br>
    <p></p>
    """
    And I click on "HTML" "button"
    And I click on "Insert or edit an audio/video file" "button"
    And I click on "Audio" "link"
    And I click on "Browse repositories..." "button" in the "#id_description_editor_audio .atto_media_source.atto_media_media_source" "css_element"
    And I click on "Private files" "link" in the ".fp-repo-area" "css_element"
    And I click on "moodle-logo.mp4" "link"
    And I click on "Select this file" "button"
    And I click on "Advanced settings" "link" in the "#id_description_editor_audio" "css_element"
    And the field "audio_media-controls-toggle" matches value "1"
    And I set the field "audio_media-autoplay-toggle" to "1"
    And I set the field "audio_media-mute-toggle" to "1"
    And I set the field "audio_media-loop-toggle" to "1"
    And I click on "Insert media" "button"
    And I click on "Insert or edit an audio/video file" "button"
    And I click on "Video" "link"
    And I click on "Browse repositories..." "button" in the "#id_description_editor_video .atto_media_source.atto_media_media_source" "css_element"
    And I click on "Private files" "link" in the ".fp-repo-area" "css_element"
    And I click on "moodle-logo.webm" "link"
    And I click on "Select this file" "button"
    And I click on "Advanced settings" "link"
    And the field "Show controls" matches value "1"
    And I set the field "Play automatically" to "1"
    And I set the field "Muted" to "1"
    And I set the field "Loop" to "1"
    When I click on "Insert media" "button"
    Then I should see "Words: 4"

  @javascript
  Scenario: Display wordcount in onlinesubmissions if wordlimit is not set
    Given the following "activity" exists:
      | activity                                      | assign                  |
      | course                                        | C1                      |
      | name                                          | Test assignment name    |
      | intro                                         | Submit your online text |
      | submissiondrafts                              | 0                       |
      | assignsubmission_onlinetext_enabled           | 1                       |
      | assignsubmission_onlinetext_wordlimit_enabled | 0                       |
      | assignsubmission_file_enabled                 | 0                       |
    And I am on the "Test assignment name" Activity page logged in as student1
    When I press "Add submission"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Online text | two words |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 2"

  @javascript
  Scenario: Display wordcount in onlinesubmissions if wordlimit is set
    Given the following "activity" exists:
      | activity                                      | assign                  |
      | course                                        | C1                      |
      | name                                          | Test assignment name    |
      | intro                                         | Submit your online text |
      | submissiondrafts                              | 0                       |
      | assignsubmission_onlinetext_enabled           | 1                       |
      | assignsubmission_onlinetext_wordlimit_enabled | 1                       |
      | assignsubmission_onlinetext_wordlimit         | 8010                    |
      | assignsubmission_file_enabled                 | 0                       |
    And I am on the "Test assignment name" Activity page logged in as student1
    When I press "Add submission"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Online text | two words |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 2/8010"

  @javascript
  Scenario: Display wordcount in essay inside quiz if wordlimit is not set
    Given the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "activities" exist:
      | activity   | name   | intro              | course | idnumber |
      | quiz       | Quiz 1 | Quiz 1 description | C1     | quiz1    |
    And the following "questions" exist:
      | questioncategory | qtype | name   | template | maxwordenabled | maxwordlimit |
      | Test questions   | essay | essay1 | editor   | 0              | 0            |
    And quiz "Quiz 1" contains the following questions:
      | question | page |
      | essay1   | 1    |
    And quiz "Quiz 1" contains the following sections:
      | heading   | firstslot | shuffle |
      | Section 1 | 1         | 0       |
    When I am on the "Quiz 1" "mod_quiz > View" page logged in as "student1"
    And I press "Attempt quiz now"
    Then I should see "Section 1" in the "Quiz navigation" "block"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Answer text | I have already written six words! |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 6"

  @javascript
  Scenario: Display wordcount in essay inside quiz if wordlimit is set
    Given the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "activities" exist:
      | activity   | name   | intro              | course | idnumber |
      | quiz       | Quiz 1 | Quiz 1 description | C1     | quiz1    |
    And the following "questions" exist:
      | questioncategory | qtype | name   | template | maxwordenabled | maxwordlimit |
      | Test questions   | essay | essay1 | editor   | 1              | 20           |
    And quiz "Quiz 1" contains the following questions:
      | question | page |
      | essay1   | 1    |
    And quiz "Quiz 1" contains the following sections:
      | heading   | firstslot | shuffle |
      | Section 1 | 1         | 0       |
    When I am on the "Quiz 1" "mod_quiz > View" page logged in as "student1"
    And I press "Attempt quiz now"
    Then I should see "Section 1" in the "Quiz navigation" "block"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Answer text | I have already written nine out of twenty words |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 9/20"

  @javascript
  Scenario: Display wordcount in multiple essays inside quiz if wordlimit is sometimes set
    Given the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "activities" exist:
      | activity   | name   | intro              | course | idnumber |
      | quiz       | Quiz 1 | Quiz 1 description | C1     | quiz1    |
    And the following "questions" exist:
      | questioncategory | qtype | name   | questiontext                  | template | maxwordenabled | maxwordlimit |
      | Test questions   | essay | essay1 | Write not more than 111 words | editor   | 1              | 111          |
      | Test questions   | essay | essay2 | Write as much as you want Nr1 | editor   | 0              | 0            |
      | Test questions   | essay | essay3 | Write not more than 222 words | editor   | 1              | 222          |
      | Test questions   | essay | essay4 | Write as much as you want Nr2 | editor   | 0              | 0            |
      | Test questions   | essay | essay5 | Write not more than 333 words | editor   | 0              | 0            |
      | Test questions   | essay | essay6 | Write as much as you want Nr2 | editor   | 1              | 333          |
    And quiz "Quiz 1" contains the following questions:
      | question | page |
      | essay1   | 1    |
      | essay2   | 1    |
      | essay3   | 1    |
      | essay4   | 1    |
      | essay5   | 2    |
      | essay6   | 2    |
    And quiz "Quiz 1" contains the following sections:
      | heading   | firstslot | shuffle |
      | Section 1 | 1         | 0       |
      | Section 2 | 5         | 0       |
    When I am on the "Quiz 1" "mod_quiz > View" page logged in as "student1"
    And I press "Attempt quiz now"
    Then I should see "Section 1" in the "Quiz navigation" "block"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Answer text | I have already written ten words out of 111 words! |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 10/111"
    When I click on "#quiznavbutton5" "css_element"
    And I wait until the page is ready
    And I set the following fields to these values:
      | Answer text | I have written exaclty fourteen words so far out of as many i want |
    And I click on "Show more buttons" "button"
    And I click on "HTML" "button"
    When I click on "HTML" "button"
    Then I should see "Words: 14"
