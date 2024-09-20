CREATE TABLE Roles (
                       role_id INT PRIMARY KEY,
                       role_name VARCHAR(50) NOT NULL
);

-- 2. Таблица Permissions (Права)
CREATE TABLE Permissions (
                             permission_id INT PRIMARY KEY,
                             permission_name VARCHAR(100) NOT NULL
);

-- 3. Таблица RolePermissions (Роли и Права)
CREATE TABLE Roles_Permissions_Rel (
                                       role_id INT,
                                       permission_id INT,
                                       FOREIGN KEY (role_id) REFERENCES Roles(role_id),
                                       FOREIGN KEY (permission_id) REFERENCES Permissions(permission_id)
);

-- 4. Таблица UserStatus (Статусы пользователей)
CREATE TABLE User_Statuses (
                               status_id INT PRIMARY KEY,
                               status_name VARCHAR(20) NOT NULL
);

-- 5. Таблица Users (Пользователи)
CREATE TABLE Users (
                       user_id INT PRIMARY KEY generated always as identity,
                       username VARCHAR(50) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(100) NOT NULL,
                       role_id INT,
                       status_id INT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (role_id) REFERENCES Roles(role_id),
                       FOREIGN KEY (status_id) REFERENCES User_Statuses(status_id)
);

-- 6. Таблица Categories (Категории)
CREATE TABLE Categories (
                            category_id INT PRIMARY KEY generated always as identity,
                            name VARCHAR(100) NOT NULL
);

-- 7. Таблица Products (Товары)
CREATE TABLE Products (
                          product_id INT PRIMARY KEY generated always as identity,
                          name VARCHAR(100) NOT NULL,
                          description TEXT,
                          price DECIMAL(10, 2) NOT NULL,
                          stock INT NOT NULL,
                          category_id INT,
                          FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 8. Таблица OrderStatus (Статусы заказов)
CREATE TABLE OrderStatuses (
                               status_id INT PRIMARY KEY generated always as identity,
                               status_name VARCHAR(20) NOT NULL
);

-- 9. Таблица Orders (Заказы)
CREATE TABLE Orders (
                        order_id INT PRIMARY KEY generated always as identity,
                        user_id INT,
                        status_id INT,
                        total_price DECIMAL(10, 2),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES Users(user_id),
                        FOREIGN KEY (status_id) REFERENCES OrderStatuses(status_id)
);

-- 10. Таблица OrderItems (Элементы заказа)
CREATE TABLE OrderItems (
                            order_id INT,
                            product_id INT,
                            quantity INT NOT NULL,
                            price DECIMAL(10, 2) NOT NULL,
                            FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                            FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 11. Таблица PaymentStatus (Статусы оплаты)
CREATE TABLE PaymentStatuses (
                                 status_id INT PRIMARY KEY generated always as identity,
                                 status_name VARCHAR(20) NOT NULL
);

-- 12. Таблица Payments (Оплаты)
CREATE TABLE Payments (
                          payment_id INT PRIMARY KEY generated always as identity,
                          order_id INT,
                          amount DECIMAL(10, 2) NOT NULL,
                          payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          status_id INT,
                          FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                          FOREIGN KEY (status_id) REFERENCES PaymentStatuses(status_id)
);

-- 13. Таблица ShipmentStatus (Статусы доставки)
CREATE TABLE ShipmentStatuses (
                                  status_id INT PRIMARY KEY generated always as identity,
                                  status_name VARCHAR(20) NOT NULL
);

CREATE TABLE Addresses (
                           address_id INT PRIMARY KEY generated always as identity,
                           city VARCHAR(50) NOT NULL,
                           street VARCHAR(50) NOT NULL,
                           house INT NOT NULL,
                           index VARCHAR(8) NOT NULL,
                           flat INT not null

);

-- 14. Таблица Shipments (Доставка)
CREATE TABLE Shipments (
                           shipment_id INT PRIMARY KEY generated always as identity,
                           order_id INT,
                           shipment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           status_id INT,
                           address_id INT,
                           FOREIGN KEY (address_id) REFERENCES Addresses(address_id),
                           FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                           FOREIGN KEY (status_id) REFERENCES ShipmentStatuses(status_id)
);

-- 15. Таблица Employees (Сотрудники)
CREATE TABLE Employees (
                           employee_id INT PRIMARY KEY generated always as identity,
                           user_id INT,
                           position VARCHAR(100),
                           department VARCHAR(100),
                           phone VARCHAR(15),
                           email VARCHAR(100),
                           FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


