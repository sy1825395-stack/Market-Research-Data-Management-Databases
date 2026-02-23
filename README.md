# MarketResearchDB

A relational database project built with MySQL to manage market research data, including customers, products, surveys, and feedback.

---

## Database Schema

The database consists of four tables:

- **Customer** — Stores customer details (name, age, gender, email)
- **Product** — Stores product details (name, category)
- **Survey** — Links a customer to a survey date
- **Feedback** — Stores ratings and comments for a product within a survey

### Entity Relationships

```
Customer (1) ──── (M) Survey (1) ──── (M) Feedback (M) ──── (1) Product
```

- A **Customer** can participate in many **Surveys**
- A **Survey** can have many **Feedback** entries
- Each **Feedback** entry references one **Product**
- Deleting a Customer cascades to their Surveys and Feedback

---

## Setup & Usage

### Prerequisites

- MySQL 5.7+ or MariaDB

### Run the Script

```bash
mysql -u your_username -p < market_research.sql
```

Or paste the SQL directly into your MySQL client.

---

## Sample Data

| Customer       | Product          | Rating |
|----------------|------------------|--------|
| Rahul Sharma   | Smartphone X     | 5      |
| Sahil Verma    | Organic Shampoo  | 4      |
| Aditi Mehta    | Sports Shoes     | 3      |

---

## Queries & Features

### Join Query
Retrieves each customer's name, the product they reviewed, and their rating by joining all four tables.

### Aggregate Query
Groups feedback by product and returns only products with an average rating greater than 3 using `HAVING`.

### View — `Product_Summary`
A reusable view that shows each product alongside its average rating across all feedback entries.

```sql
SELECT * FROM Product_Summary;
```

### Transactions
Two transactions are demonstrated:

- **Successful transaction** — Inserts a new survey for customer 4 and a feedback entry with rating 5, then commits.
- **Rolled-back transaction** — Attempts to insert a feedback entry with an invalid rating of 10 (violates the `CHECK` constraint of 1–5) and rolls back.

---

## Constraints

| Constraint | Column | Rule |
|---|---|---|
| `UNIQUE` | `Customer.email` | No duplicate emails |
| `NOT NULL` | `Customer.name`, `Survey.survey_date`, etc. | Required fields |
| `CHECK` | `Feedback.rating` | Must be between 1 and 5 |
| `FOREIGN KEY ... ON DELETE CASCADE` | `Survey.customer_id`, `Feedback.survey_id` | Cascading deletes |

---

## License

This project is for educational purposes.
