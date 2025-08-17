Test Plan and TDD Rationale

Rationale and Approach

- Adopt a unit-test-first mindset for model and utility classes that are pure code (no DB/tomcat dependency).
- Keep tests fast, deterministic and isolated to enable test automation in CI.
- Focus on core correctness: hashing/verification, model calculations, and constructors/getters/setters.

Test Driven Development (TDD) Usage

- For each requirement, write a failing test first (not shown historically) then implement code until tests pass.
- Tests added now validate the existing behavior and will be used as regression checks for future refactors.

Test Data

- Passwords: simple known strings ("Secret123!", "abc", "def") to validate hashes deterministically.
- InvoiceItem: quantities and prices using BigDecimal strings to avoid floating point issues.
- Models: small synthetic values and dates (LocalDate.now()) to validate constructors and defaults.

Test Plan

- Unit tests cover: PasswordUtil, InvoiceItem, Item, Customer, Invoice.
- Each test class contains multiple test methods to cover normal and edge cases.
- Tests will be executed using Maven (mvn test) and should be run locally and in CI.

Classes and Tests Added

- src/test/java/com/pahanaedu/util/PasswordUtilTest.java

  - testHashAndVerify
  - testVerifyWrongPassword
  - testSimpleHashConsistency

- src/test/java/com/pahanaedu/model/InvoiceItemTest.java

  - testCalculateLineTotal
  - testSettersUpdateLineTotal

- src/test/java/com/pahanaedu/model/ItemTest.java

  - testConstructorDefaults
  - testSetPriceAndGet

- src/test/java/com/pahanaedu/model/CustomerTest.java

  - testConstructorAndUnitsConsumedDefault
  - testSetCustomerTypeAndGet

- src/test/java/com/pahanaedu/model/InvoiceTest.java
  - testDefaultConstructorDefaults
  - testInvoiceConstructorFields

Automation

- Tests run with Maven surefire/junit-jupiter (configured via pom.xml).
- To run locally: mvn test

Evaluation and Lessons Learned

- Success criteria: all tests pass and are fast (< few seconds locally).
- If tests are flaky (e.g., time-dependent), replace time usages with injectable clocks.
- Future improvements: add DAO/service integration tests with an in-memory DB (H2) or mocks.

Traceability

- Password hashing/verification requirement -> PasswordUtilTest
- Invoice line total calculation -> InvoiceItemTest
- Model default states and constructors -> ItemTest, CustomerTest, InvoiceTest

\*\*\* End of Test Plan
