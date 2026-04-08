# test_kt_4


-- 1. Проверка регистрации пользователя
-- Ожидаем: 1 запись
SELECT COUNT(*) AS user_count
FROM users
WHERE email = 'ivan@test.local;
<img width="195" height="73" alt="image" src="https://github.com/user-attachments/assets/6e3bcd3f-05e5-4683-a19e-c1dbfa7bfc1e" />

-- Ожидаем: корректные данные пользователя
SELECT id, name, email
FROM users
WHERE email = 'ivan@test.local';
<img width="314" height="82" alt="image" src="https://github.com/user-attachments/assets/8eae053b-387b-4a4a-ba36-9913d8916ecc" />

-- Ожидаем: 0 дублей
SELECT COUNT(*) - 1 AS duplicate_count
FROM users
WHERE email = 'ivan@test.local';
<img width="224" height="77" alt="image" src="https://github.com/user-attachments/assets/e7b97367-134e-4e5d-9239-0e39e6c10026" />


-- 2. Проверка оформления заказа
-- Ожидаем: 1 заказ со статусом paid
SELECT COUNT(*) AS order_count
FROM orders
WHERE user_id = 1 AND status = 'paid';
<img width="529" height="84" alt="image" src="https://github.com/user-attachments/assets/3641d0f1-9d46-469f-bcdd-c36abdd1deec" />

-- Ожидаем: корректные поля заказа
SELECT id, user_id, status
FROM orders
WHERE id = 1;
<img width="424" height="99" alt="image" src="https://github.com/user-attachments/assets/1e26d4e3-afca-4c0c-bbe6-79c1165810b5" />

-- Ожидаем: 2 позиции в заказе
SELECT COUNT(*) AS order_items_count
FROM order_items
WHERE order_id = 1;
<img width="277" height="101" alt="image" src="https://github.com/user-attachments/assets/8eaacf6f-f430-43b9-9627-a92738ceccba" />

-- Ожидаем: нет "осиротевших" order_items
SELECT COUNT(*) AS broken_order_links
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.id
WHERE o.id IS NULL;
<img width="300" height="91" alt="image" src="https://github.com/user-attachments/assets/9088650f-b551-4886-b389-8c8c010b9848" />


-- 3. Проверка добавления комментария
-- Ожидаем: 1 комментарий
SELECT COUNT(*) AS comment_count
FROM comments
WHERE user_id = 1 AND product_id = 1;
<img width="246" height="91" alt="image" src="https://github.com/user-attachments/assets/17febcbb-3438-4834-b812-4ce1caeae595" />

-- Ожидаем: корректный текст комментария
SELECT id, user_id, product_id, text
FROM comments
WHERE user_id = 1 AND product_id = 1;
<img width="520" height="85" alt="image" src="https://github.com/user-attachments/assets/e6e651f6-fbb7-4202-a01c-c519ac6d4c7e" />

-- Ожидаем: нет комментариев без пользователя
SELECT COUNT(*) AS broken_comment_user_links
FROM comments c
LEFT JOIN users u ON c.user_id = u.id
WHERE u.id IS NULL;
<img width="344" height="101" alt="image" src="https://github.com/user-attachments/assets/6f2dfba0-a6de-431d-ad82-9cc2a01232e0" />


-- 4. Проверка каскадного удаления
-- Шаг 1: выполнить вручную
-- DELETE FROM users WHERE id = 1;
<img width="356" height="105" alt="image" src="https://github.com/user-attachments/assets/3c0adb13-33cb-4b83-ab33-0073c14f0ba2" />

-- Шаг 2: после удаления ожидаем 0 заказов пользователя
SELECT COUNT(*) AS orders_after_user_delete
FROM orders
WHERE user_id = 1;
<img width="300" height="96" alt="image" src="https://github.com/user-attachments/assets/f0ac22dd-7291-463f-ae57-fbe3ba33f92a" />

-- Шаг 3: после удаления ожидаем 0 комментариев пользователя
SELECT COUNT(*) AS comments_after_user_delete
FROM comments
WHERE user_id = 1;
<img width="302" height="104" alt="image" src="https://github.com/user-attachments/assets/e9d0e8c3-c2cc-4cab-a251-112bae904066" />

-- Шаг 4: после удаления ожидаем 0 order_items для удалённого заказа
SELECT COUNT(*) AS items_after_user_delete
FROM order_items
WHERE order_id = 1;
<img width="249" height="110" alt="image" src="https://github.com/user-attachments/assets/b1ce9442-d7bd-41ff-903e-589ca3a54a58" />
