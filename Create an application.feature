
Feature: Create an application

Background: 
Given the user with ID "1" is authenticated for the seasion and valid token is given

Scenario: Create an unique application
Given the valid token is placed in Authorization tab, Token field
When a POST request is made to https://api.playgroundtech.io/v1/application with
```
{
    "phone_number": "1234567", 
    "email": "email@email.com", 
    "linkedin": "linkedin.com", 
    "github": "github.com", 
    "homepage": "www.homepage.com"
}
```
Then application created
And response returned
* with status: 200 OK
* with body
```
{
    "applicant_id": 112,
    "user_id": 1,
    "phone_number": "1234567",
    "email": "email@email.com",
    "linkedin": "linkedin.com",
    "github": "github.com",
    "homepage": "www.homepage.com",
    "created_at": "2023-01-18T16:05:00.912668Z",
    "updated_at": "2023-01-18T16:05:00.912668Z"
}
```
Examples:
  | "applicant_id" | "user_id" | "phone_number" | "email"         | "linkedin"   | "github"   | "homepage"       | Status |
  | 112            | 1         | 1234567        | email@email.com | linkedin.com | github.com | www.homepage.com | 200    |
  | 113            | 1         | 1234567        | email@email.com | linkedin.com | github.com | www.homepage.com | 200    |
  | 114            | 1         | 1234567        | email@0.com     | linkedin.com | github.com | www.homepage.com | 200    |
  | 115            | 1         | 1234567        | n/a             | linkedin.com | github.com | www.homepage.com | 422    |

Scenario: Create an existing application 
Given the application with  "applicant_id": 112 exists
When a POST request is made to https://api.playgroundtech.io/v1/application with
```
{
    "applicant_id": 112,
    "phone_number": "1234567", 
    "email": "email@email.com", 
    "linkedin": "linkedin.com", 
    "github": "github.com", 
    "homepage": "www.homepage.com"
}
```
Then an application should not be created
And error response should be returned
* with status: 500
* with message "application already exists" 
But not with a message "email already taken"

# status code 500 pass, but message returns "email already taken" even when email is different(as seen in examples bellow). 

Examples:
  | "applicant_id" | "user_id" | "phone_number" | "email"        | "linkedin"   | "github"   | "homepage"       | Status | Message
  | 112            | 1         | 1234567        | email@0.com    | linkedin.com | github.com | www.homepage.com | 500    | "email already taken" |
  | 112            | 1         | 1234567        | 7#$E@email.com | linkedin.com | github.com | www.homepage.com | 500    | "email already taken" |
  | 112            | 1         | 1234567        | n/a            | linkedin.com | github.com | www.homepage.com | 422    | "required email"      |

