-- 1.Составить общее текстовое описание БД и решаемых ею задач
/*
 * Описание БД: 
 * БД пиццерии будет хранить в себе следующие таблицы:
 * 1) profiles Профили пользователей
 * 2) users Информацию о клиентах
 * 3) cities Список городов, где располагаются филиалы пиццерии
 * 4) toppings Список возможных топпингов для пиццы
 * 5) orders_pizzas Список пицц для каждого заказа
 * 6) pizzas_toppings Список топпингов для каждой пиццы
 * 7) pizzerias Информацию о филиалах пиццерии
 * 8) discounts Таблица скидок для всех пользователей
 * 9) pizzas Список всех пицц
 * 10) orders Таблица с заказами
 * 
 * Решаемые задачи:
 * База данных автоматизирует и сокращает время время управления информацией внутри предприятия
 */

USE MyPizzeria;

-- *** ТАБЛИЦЫ *** --


-- Пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY COMMENT 'Идентификатор пользователя',
	name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
	lastname VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
	surname VARCHAR(100) COMMENT 'Отчество пользователя (заполнение необязательно)',
	address VARCHAR(100) NOT NULL COMMENT 'Адрес пользователя',
	phone BIGINT UNSIGNED NOT NULL COMMENT 'Телефон пользователя',
	email VARCHAR(100) COMMENT 'почта пользователя (заполнение необязательно)',
	INDEX users_lastname(lastname)
) COMMENT 'Таблица пользователей сервиса';

-- Профили 1-1
DROP TABLE IF EXISTS profiles;
CREATE TABLE IF NOT EXISTS profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	`password` VARCHAR(30) NOT NULL COMMENT 'Пароль пользователя',
	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания профиля',
	updated_at DATETIME ON UPDATE NOW() COMMENT 'Дата обновления профиля',
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица профилей пользователей сервиса';

-- Топпинги
DROP TABLE IF EXISTS toppings;
CREATE TABLE IF NOT EXISTS toppings(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL COMMENT 'Название топпинга'
) COMMENT 'Таблица топпингов для пиццы';


-- Заказы 1-М
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'Ключ на пользователя',
	status ENUM('Обрабатывается', 'Готовится', 'Передан курьеру', 'Отменен') COMMENT 'Статус заказа',
	payment ENUM('Наличными', 'Картой') COMMENT 'Способ оплаты',
	created_at DATETIME DEFAULT NOW() COMMENT 'Время создания заказа',
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица заказов';


-- Пиццы
DROP TABLE IF EXISTS pizzas;
CREATE TABLE IF NOT EXISTS pizzas(
	id SERIAL PRIMARY KEY,
	name VARCHAR(250) NOT NULL COMMENT 'Название пиццы',
	composition VARCHAR(250) NOT NULL COMMENT 'Состав пиццы',
	price INT UNSIGNED NOT NULL COMMENT 'Цена пиццы',
	`size` ENUM('Большая', 'Средняя', 'Маленькая')
) COMMENT 'Таблица видов пицц';


-- Набор пицц в одном заказе. М-М
DROP TABLE IF EXISTS orders_pizzas;
CREATE TABLE IF NOT EXISTS orders_pizzas(
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED NOT NULL COMMENT 'Ключ на заказ',
	pizza_id BIGINT UNSIGNED NOT NULL COMMENT 'Ключ на пиццу',
	`count` INT UNSIGNED NOT NULL COMMENT 'Количество заказа',
	FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (pizza_id) REFERENCES pizzas(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица пицц в заказе';


-- Топпинги для пиццы М-М
DROP TABLE IF EXISTS pizzas_toppings;
CREATE TABLE IF NOT EXISTS pizzas_toppings(
	id SERIAL PRIMARY KEY,
	pizza_id BIGINT UNSIGNED NOT NULL,
	topping_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (pizza_id) REFERENCES pizzas(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (topping_id) REFERENCES toppings(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица топпингов для конкретной пиццы';


-- Города
DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(250) NOT NULL
) COMMENT 'Таблица городов с сетью пиццерий';

-- Пиццерии 1-М
DROP TABLE IF EXISTS pizzerias;
CREATE TABLE IF NOT EXISTS pizzerias(
	id SERIAL PRIMARY KEY,
	address VARCHAR(250),
	phone BIGINT UNSIGNED NOT NULL,
	city_id BIGINT UNSIGNED NOT NULL COMMENT 'Ключ на город',
	FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица точек пиццерий';


-- Скидки
DROP TABLE IF EXISTS discounts;
CREATE TABLE IF NOT EXISTS discounts(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'Ключ на пользователя',
	name VARCHAR(100) NOT NULL COMMENT 'Название скидки',
	discount INT UNSIGNED NOT NULL COMMENT 'Скидка',
	started_at DATETIME DEFAULT NULL,
	finished_at DATETIME DEFAULT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Таблица городов с сетью пиццерий';


-- *** ПРОЦЕДУРЫ ***--


-- Процедура создает нового пользователя в таблицу users. 
-- Параметры (имя, фамилия, отчество, улица, телефон, почта)
DROP PROCEDURE IF EXISTS create_user;
DELIMITER //
CREATE PROCEDURE create_user(new_name VARCHAR(100), new_lastname VARCHAR(100), new_surname VARCHAR(100), new_address VARCHAR(250), new_phone BIGINT, new_email VARCHAR(200))
	BEGIN
		INSERT INTO users(name, lastname, surname, address, phone, email)
		VALUES(new_name, new_lastname, new_surname, new_address, new_phone, new_email);
	END //
DELIMITER ;

CALL create_user('Иван', 'Иванов', 'Иванович', 'Ленина 1', 89000000000, 'mail@gmail.com');

-- Процедура меняет статус заказа. 
-- Параметры (id заказа, новый статус)
DROP PROCEDURE IF EXISTS update_status_order;
DELIMITER //
CREATE PROCEDURE update_status_order(value_order_id BIGINT, new_status VARCHAR(100))
	BEGIN
		UPDATE orders
		SET status = new_status
		WHERE id = value_order_id;
	END //
DELIMITER ;

CALL update_status_order(1, 'Обрабатывается');


-- Процедура удаляет пиццу из таблицы заказов. 
-- Параметры (id заказа)
DROP PROCEDURE IF EXISTS delete_order;
DELIMITER //
CREATE PROCEDURE delete_order(value_order_id BIGINT)
	BEGIN
		DELETE FROM orders
		WHERE id = value_order_id;
	END //
DELIMITER ;

CALL delete_order(29);


-- *** СКРИПТЫ *** --


-- 6.Скрипты характерных выборок
-- Вывести имя, фамилию, телефон клиента и дату заявки, где заказ был совершен не раньше 2000-го года, 
-- сортировать фамилии по алфавиту в порядке возрастания
SELECT
	u.name,
	u.lastname,
	u.phone,
	o.created_at
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.created_at >= '2000-01-01 00:00:00'
ORDER BY u.lastname;

-- Вывести количество заказов по каждому способу оплаты, сортировать в порядке убывания
SELECT
	o.payment,
	COUNT(*) 'Количество'
FROM orders o
GROUP BY o.payment
ORDER BY COUNT(*) DESC;

-- Вывести топ 3 названия пицц по количеству заказов, не учитывая статус "Отменен"
SELECT
	p.name 'Название пиццы',
	SUM(op.`count`) 'Всего заказали'
FROM
	orders_pizzas op
LEFT JOIN pizzas p ON p.id = op.pizza_id
JOIN orders o ON o.id = op.order_id
WHERE o.status != 'Отменен'
GROUP BY p.name
ORDER BY SUM(op.`count`) DESC
LIMIT 3


-- *** ПРЕДСТАВЛЕНИЯ *** --


-- Имя, фамилия клиента, телефон, статус его заказа, сумма заказа, скидка(при наличии), сумма к оплате с учетом скидки
DROP VIEW IF EXISTS active_orders;
CREATE VIEW active_orders AS
SELECT
	u.name 'Имя',
	u.lastname 'Фамилия',
	u.phone 'Телефон',
	o.status 'Статус заказа',
	op.`count` * p.price 'Сумма к оплате',
	d.discount 'Скидка',
	FLOOR((op.`count` * p.price) - (op.`count` * p.price * d.discount / 100)) 'Сумма к оплате со скидкой'
FROM users u
JOIN orders o ON o.user_id = u.id
JOIN orders_pizzas op ON op.order_id = o.id
LEFT JOIN pizzas p ON p.id = op.pizza_id
LEFT JOIN discounts d ON d.user_id = u.id
WHERE 
	o.status != 'Отменен';

-- Показывает в какой пицце какие топпинги
DROP VIEW IF EXISTS names_pizzas_toppings;
CREATE VIEW names_pizzas_toppings AS
SELECT
	p.name 'Название пиццы',
	t.name 'Название топпинга'
FROM toppings t
JOIN pizzas_toppings pt ON t.id = pt.topping_id
JOIN pizzas p ON p.id = pt.pizza_id;




	
	
	
	
	
	


