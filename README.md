# NOTEBOOK - Contact management API

### Ruby on Rails API

- **Rails version:** 8.0.1
- **Database:** SQLite (configured in config/database.yml)
- **JSON:API:** Uses ActiveModel::Serializer for serialization
- **Authentication:** Uses Devise Token Auth


### Set up:

- **Clone repository** (HTTPS):
```bash
git clone https://github.com/fatimampg/notebook-api.git
```

- **Install dependencies:**
```bash
bundle install
```

- **Set up the database:**
```bash
rails db:create
rails db:migrate
```

- **Populate the database (Data generated using Faker gem):**</br>

Development database:
```bash
rake dev:setup
```
Test database:
```bash
rake test_db:setup
```

- **Start server:**</br>

 Using Foreman (processes and commands defined in Procfile):
```bash
foreman start
```
Without Foreman:
```bash
rails server
```
(Available at : http://localhost:3000/)

- **List of Routes (Browser):**</br>
 Go to: http://localhost:3000/rails/info/routes

- **Run tests (RSpec):**

```bash
bundle exec rspec
```