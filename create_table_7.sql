USE books;
CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_date DATE
);

CREATE TABLE publishers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20)
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) UNIQUE NOT NULL,
    author_id INT,
    publisher_id INT,
    publication_date DATE,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) CHECK (phone REGEXP '^[0-9]+$')
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

