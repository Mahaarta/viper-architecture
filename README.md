
## What is VIPER
VIPER is an architecture pattern for organizing code in iOS applications. It stands for View, Interactor, Presenter, Entity, and Router. Each component in the VIPER architecture has a specific responsibility, and together they promote a clean and modular structure

## VIPER architecture
### View
- The View is responsible for presenting the user interface and capturing user input.
- It communicates with the Presenter to receive updates and sends user input back to the Presenter
	
 ### Interactor
 - The Interactor contains the business logic of the application. It communicates with the data layer to fetch and manipulate data.
 - It is responsible for making decisions based on business rules and notifies the Presenter of the results

 ### Presenter
- The Presenter acts as an intermediary between the View and the Interactor.
- It receives user input from the View, processes it, and communicates with the Interactor to perform business logic.
- The Presenter then updates the View with the results

 ### Entity
 - The Entity represents the data model of the application. It defines the core data structures and objects used by the Interactor
 
 ### Router
- The Router handles navigation between different modules or screens in the application.
- It is responsible for presenting and dismissing ViewControllers and communicates with the Presenter to initiate navigation

## Unit Test
- Network Manager Test
- Login Test
  - Mock
    - Mock View
    - Mock Router
    - Mock Presenter
    - Mock Interactor
  - Presenter Test
  - Interactor Test
- Register
  - Mock
    - Mock View
    - Mock Interactor
    - Mock Presenter
   - Presenter Test
   - Interactor Test
 
## UI Test 
- LoginViewControllerUITest
- RegisterViewControllerUITest
