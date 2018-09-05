@javascript
Feature: Guests can view the full Campaign page
    As a Guest, 
    In order to have more information about the Campaign
    I would like to access a full Campaign page.

    Background:
        Given the following campaign exist
        | title                        | description                                | location   |
        | Veronica Maggio in Stockholm | Don't miss a fantastic singer in September | Stockholm |

    Scenario: Guest can view the full description of Campaign
        Given I am on the landing page
        And I click on 'Veronica Maggio in Stockholm'
        Then I should be redirected to the Campaign page for 'Veronica Maggio in Stockholm'
        And I should see 'Veronica Maggio in Stockholm'
        And I should see "Don't miss a fantastic singer in September"
        And I should see 'Stockholm'