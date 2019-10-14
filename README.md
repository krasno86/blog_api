# README

Documentation gem - rswag, location - /api-docs/index.html.
registration - devise_token_auth

There is planned to have new type of posts in the future - questionnaire.
Answer: In that case I prefer STI(Single Table Inheritance) with basic model article and two types of model - post and questionnaire. if in the future we need to add additional type, we can easily do it.

STI PROS:
- Simple to implement
- DRY — saves replicated code using inheritance and shared attributes
- Allows subclasses to have own behavior as necessary
