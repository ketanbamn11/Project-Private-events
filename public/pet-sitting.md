# PetSittingDB Schema

## Tables

### Users
- **id** (primary key, unique identifier for each user)
- **username**
- **email**
- **password** (hashed for security)
- **phone_number**
- **address**

### Pets
- **id** (primary key, unique identifier for each pet)
- **name**
- **species** (e.g. dog, cat, bird, etc.)
- **breed**
- **age**
- **owner_id** (foreign key referencing the Users table)

### PetSitters
- **id** (primary key, unique identifier for each pet sitter)
- **user_id** (foreign key referencing the Users table)
- **experience** (text field for pet sitting experience)
- **availability** (text field for availability, e.g. "Monday to Friday, 9am-5pm")

### Bookings
- **id** (primary key, unique identifier for each booking)
- **pet_id** (foreign key referencing the Pets table)
- **pet_sitter_id** (foreign key referencing the PetSitters table)
- **start_date**
- **end_date**
- **status** (e.g. "pending", "confirmed", "cancelled")

### Reviews
- **id** (primary key, unique identifier for each review)
- **booking_id** (foreign key referencing the Bookings table)
- **rating** (integer, 1-5)
- **review_text** (text field for the review)

## Associations

- A user can have multiple pets (one-to-many): Users -> Pets (owner_id)
- A pet can have multiple bookings (one-to-many): Pets -> Bookings (pet_id)
- A pet sitter can have multiple bookings (one-to-many): PetSitters -> Bookings (pet_sitter_id)
- A booking is associated with one pet and one pet sitter (many-to-one): Bookings -> Pets (pet_id) and Bookings -> PetSitters (pet_sitter_id)
- A review is associated with one booking (many-to-one): Reviews -> Bookings (booking_id)



### ER Diagram

![ER Diagram](Screenshot%20from%202024-06-14%2018-31-29.png)
