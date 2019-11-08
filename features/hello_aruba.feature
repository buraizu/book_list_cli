Feature: Getting Started With Aruba
  Scenario: First Run of Command
    Given I successfully run `./bin/book_list_cli`
    Then the output should contain:
    """
    Welcome to BookListCLI! Query the GoogleBooks API and construct your own reading list.
    """


    