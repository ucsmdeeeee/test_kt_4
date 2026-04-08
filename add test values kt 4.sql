INSERT INTO products (name, price) VALUES
('Ноутбук', 50000.00),
('Мышь', 1500.00),
('Клавиатура', 3000.00);

INSERT INTO users (name, email) VALUES
('Иван Петров', 'ivan@test.local');

INSERT INTO orders (user_id, status) VALUES
(1, 'paid');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2);

INSERT INTO comments (user_id, product_id, text) VALUES
(1, 1, 'Отличный товар');