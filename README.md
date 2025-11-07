# SafEATy
SafEATy is a database project designed to support restaurants in the management of allergens, ingredients and dishes but its main goal is to help allergic clients to stay safe and enjoy their meal.  This repository contains the database design and supporting documentation developed as part of the Database Design course at the University of Bologna.

Objectives

- Model the relationships between ingredients, allergens, dishes, and menus.

- Provide a system to verify allergen presence automatically.

- Enable queries and reports to support allergen-free menu planning.

- Apply best practices in data modeling, normalization, and schema validation.


## **Database Design**
### Conceptual Design (E/R)

The conceptual schema models:

- Allergens and their classifications

- Ingredients (each linked to one or more allergens)

- Dishes composed of ingredients

- Menus including dishes served on specific dates

- Reports showing which dishes are suitable for specific allergy profiles

### Logical Design

The database follows third normal form (3NF) to minimize redundancy and ensure consistency.

### Example Queries

- List of dishes containing a specific allergen.

- Safe dishes for a customer with multiple allergies.

- Daily menu with allergen summary.

- Count of dishes per allergen type.

Each query is annotated for clarity and can be executed on PostgreSQL or any SQL-compliant system.

### Documentation

The full project documentation [Language ITA] includes:

- Requirement analysis and glossary

- Entity–relationship diagram

- Volume estimation and validation

- Relational schema derivation

- Query explanations and expected results


_____________________________________________________________________________________________________________________________________

#### Note on inclusive language usage 
This project intentionally adopts inclusive and gender-neutral language in all documentation and examples.
Technical terminology and examples are formulated to avoid gender bias and to promote accessibility and respect for all users.

____________________________________________________________________________________________________________________________________

#### License
##### Author: Laura Pala
Student of Computer Systems Technologies and Data Analysis — University of Bologna - Start2Impact
##### Citation 
😁 If you use or reference this project, please cite it as:
"safEATy — Allergen Management Database System, Laura Pala, University of Bologna, 2025."
