-- 1. Проверка регистрации пользователя
-- Ожидаем: 1 запись
SELECT COUNT(*) AS user_count
FROM users
WHERE email = 'ivan@test.local';

-- Ожидаем: корректные данные пользователя
SELECT id, name, email
FROM users
WHERE email = 'ivan@test.local';

-- Ожидаем: 0 дублей
SELECT COUNT(*) - 1 AS duplicate_count
FROM users
WHERE email = 'ivan@test.local';


-- 2. Проверка оформления заказа
-- Ожидаем: 1 заказ со статусом paid
SELECT COUNT(*) AS order_count
FROM orders
WHERE user_id = 1 AND status = 'paid';

-- Ожидаем: корректные поля заказа
SELECT id, user_id, status
FROM orders
WHERE id = 1;

-- Ожидаем: 2 позиции в заказе
SELECT COUNT(*) AS order_items_count
FROM order_items
WHERE order_id = 1;

-- Ожидаем: нет "осиротевших" order_items
SELECT COUNT(*) AS broken_order_links
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.id
WHERE o.id IS NULL;


-- 3. Проверка добавления комментария
-- Ожидаем: 1 комментарий
SELECT COUNT(*) AS comment_count
FROM comments
WHERE user_id = 1 AND product_id = 1;

-- Ожидаем: корректный текст комментария
SELECT id, user_id, product_id, text
FROM comments
WHERE user_id = 1 AND product_id = 1;

-- Ожидаем: нет комментариев без пользователя
SELECT COUNT(*) AS broken_comment_user_links
FROM comments c
LEFT JOIN users u ON c.user_id = u.id
WHERE u.id IS NULL;


-- 4. Проверка каскадного удаления
-- Шаг 1: выполнить вручную
-- DELETE FROM users WHERE id = 1;

-- Шаг 2: после удаления ожидаем 0 заказов пользователя
SELECT COUNT(*) AS orders_after_user_delete
FROM orders
WHERE user_id = 1;

-- Шаг 3: после удаления ожидаем 0 комментариев пользователя
SELECT COUNT(*) AS comments_after_user_delete
FROM comments
WHERE user_id = 1;

-- Шаг 4: после удаления ожидаем 0 order_items для удалённого заказа
SELECT COUNT(*) AS items_after_user_delete
FROM order_items
WHERE order_id = 1;
