-- USERS Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user', -- roles: 'user', 'admin'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PRODUCTS Table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    is_subscription BOOLEAN DEFAULT FALSE,
    file_url TEXT,                     -- Download link or video/course file
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ORDERS Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    payment_status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'paid', 'failed'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SUBSCRIPTIONS Table
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    stripe_subscription_id VARCHAR(255),
    status VARCHAR(50) DEFAULT 'active',   -- 'active', 'canceled', 'past_due'
    start_date TIMESTAMP,
    end_date TIMESTAMP
);
