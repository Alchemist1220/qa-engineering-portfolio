# QA Engineering Testing Portfolio

This repository contains independent QA testing projects demonstrating
manual web testing, test documentation, exploratory testing, and API
testing using Postman.

## Project 1 — SauceDemo Web Application Testing

### 1. Project Overview

This project documents an independent manual testing exercise conducted
on SauceDemo, a demo e-commerce web application.

The objective is to practice test case design, manual test execution,
result documentation, exploratory testing, and cross-module workflow
validation.

### 2. Application Under Test

- Application: SauceDemo / Swag Labs
- URL: https://www.saucedemo.com/
- Testing Approach: Manual Functional Testing and Exploratory Testing
- Environment: Google Chrome on Windows
- Browser and OS versions: Not recorded

### 3. Testing Scope

- Login with valid and invalid credentials
- Required-field validation
- Locked-account behavior
- Product listing and product detail consistency
- Shopping cart operations
- Checkout information and order review
- Order completion and PDF receipt generation
- Exploratory observations using selected demo accounts

### 4. Test Artifacts

Workbook: `QA_Testing_ECommerce_Portfolio_Updated.xlsx`

The workbook contains four worksheets:

- `Test_Cases`: Documented test cases and expected results
- `Test_Execution`: Actual results and execution status
- `Bug_Reports`: Preliminary issue reports and exploratory observations
- `Test_Summary`: Testing scope, execution summary, conclusions,
  and recommendations

### 5. Initial Test Results

- Total documented test executions: 13
- Passed: 12
- Failed: 1
- Blocked: 0

Recorded test groups:

- Login: 8 test cases passed
- Checkout required-field validation: 3 test cases passed
- End-to-end product-to-order workflow: 1 test case passed
- Product detail navigation: 1 test case failed

The failed test case involved product navigation when using the
`problem_user` demo account. Selecting Sauce Labs Backpack displayed
Sauce Labs Fleece Jacket instead.

### 6. Exploratory Testing Observations

Exploratory testing with selected demo accounts revealed possible
inconsistencies involving:

- Product images and product information
- Product detail navigation
- Shopping cart interactions
- Product price display
- User interface layout

These findings are documented as preliminary observations and require
appropriate verification before being classified as confirmed defects.

### 7. Project Limitations

This is an independent practice project conducted on a demo application.
The findings reflect observed behavior during the documented test
sessions and do not establish the overall quality or production
readiness of the application.

---

## Project 2 — API Testing with Postman

### 1. Project Overview

This project documents API testing exercises using Postman and the
JSONPlaceholder public testing API.

The objective is to practice sending HTTP requests, inspecting response
data, validating status codes, checking JSON structures, and writing
JavaScript-based post-response assertions.

### 2. Application Under Test

- API: JSONPlaceholder
- Base URL: https://jsonplaceholder.typicode.com/
- Tool: Postman
- Testing Approach: Manual API Testing and Automated Response Assertions

### 3. Testing Scope

- Retrieve a single post using GET
- Retrieve a list of posts using GET
- Submit a new post using POST
- Retrieve a non-existent post ID
- Validate HTTP status codes
- Validate JSON response format and structure
- Validate required response fields
- Compare submitted request values with returned response values
- Validate error responses for a non-existent resource

### 4. Test Artifacts

Workbook: `API_Testing_JSONPlaceholder_Portfolio.xlsx`

The workbook contains three worksheets:

- `API_Test_Execution`: Request details, expected results, actual
  results, and execution status
- `API_Assertion_Results`: Detailed results of Postman assertions
- `API_Test_Summary`: API testing metrics, observations, and conclusions

### 5. Initial Test Results

- API request scenarios executed: 4
- API request scenarios passed: 4
- API request scenarios failed: 0
- Postman assertions passed: 19
- Postman assertions failed: 0

The recorded API scenarios include:

- GET a single post
- GET a list of posts
- POST a new post
- GET a non-existent post ID

All 19 documented Postman assertions passed according to the
recorded execution results.

### 6. Testing Limitations

JSONPlaceholder simulates resource creation. A successful POST response
does not establish that the new resource is stored permanently on the
server.

The results represent the documented requests and assertions only and
do not constitute a comprehensive assessment of the API.

---

## Tools and Skills Practiced

- Manual Functional Testing
- Test Case Design and Execution
- Exploratory Testing
- Expected and Actual Result Analysis
- Defect Documentation
- Test Summary Reporting
- Postman API Testing
- HTTP Methods and Status Codes
- JavaScript-Based Postman Assertions
- Excel-Based Test Documentation
- Basic Jira Issue Tracking

## Future Learning Goals

- Strengthen Jira defect lifecycle practice
- Refresh SQL and database validation
- Practice integration testing
- Expand API testing scenarios
- Learn introductory web test automation
