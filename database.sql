create database tradingPlatform;
use tradingPlatform;

-- creating tables

-- DROP TABLE `Stock`;
CREATE TABLE Stock (
	StockName		VARCHAR(20) NOT NULL,
	StockSymbol		VARCHAR(5) NOT NULL,
	SharePrice		FLOAT(2) NOT NULL,
	StockType		VARCHAR(20),
	NumAvailShares	INTEGER NOT NULL,
	PRIMARY KEY (StockSymbol),
	UNIQUE (StockName)
);

-- DROP TABLE  `Customer`;
CREATE TABLE Customer (
	FirstName		VARCHAR(20) NOT NULL,
	LastName		VARCHAR(20) NOT NULL,
	City			VARCHAR(20),
	Address			VARCHAR(50),
	State			VARCHAR(20),
	Telephone		CHAR(10),
	ZipCode			CHAR(5),
	Email			VARCHAR(50),
	CusId			INTEGER AUTO_INCREMENT NOT NULL,
	PRIMARY KEY (CusId)
);

-- DROP TABLE  `Login`;
CREATE TABLE Login (
	Usr				VARCHAR(20) NOT NULL,
	Pwd				VARCHAR(20) NOT NULL,
	Id				INTEGER NOT NULL,
	AccType			INTEGER NOT NULL,
	PRIMARY KEY (Usr)
);

-- DROP TABLE  `Account_`;
CREATE TABLE Account_ (
	AccNum			INTEGER AUTO_INCREMENT NOT NULL,
	AccCreDate		DATETIME,
	CusId			INTEGER NOT NULL,
	CreditCNum		VARCHAR(16) NOT NULL,
	PRIMARY KEY (AccNum),
	FOREIGN KEY (CusId) REFERENCES Customer (CusId)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

-- DROP TABLE `Order_`;
CREATE TABLE Order_ (
	OrderId			INTEGER AUTO_INCREMENT,
	StockSymbol		VARCHAR(5),
	NumShares		INTEGER NOT NULL,
	OrderType		VARCHAR(4) NOT NULL,
	CusAccNum		INTEGER DEFAULT 0,
	Timestamp_		DATETIME DEFAULT NOW() NOT NULL,
	PriceType		VARCHAR(15) NOT NULL,
    
	CurSharePrice	FLOAT(2),
	
    Completed		BOOLEAN DEFAULT 0,
	Recorded		BOOLEAN DEFAULT 0,
	PRIMARY KEY (OrderId),
	UNIQUE (StockSymbol, Timestamp_, CusAccNum),
	FOREIGN KEY (StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (CusAccNum) REFERENCES Account_ (AccNum)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

-- DROP TABLE `Transact`;
CREATE TABLE Transact (
	Id 				INTEGER AUTO_INCREMENT, 
	OrderId			INTEGER,
	TransFee 		FLOAT(2), 
	PricePerShare 	FLOAT(2),
	TimeStamp_ 		DATETIME DEFAULT NOW() NOT NULL, 
	PRIMARY KEY (Id),
	FOREIGN KEY (OrderId) REFERENCES Order_ (OrderId)
		ON DELETE SET NULL
		ON UPDATE CASCADE
 );

-- DROP TABLE `Portfolio`;
CREATE TABLE Portfolio (
	AccNum			INTEGER,
	NumShares		INTEGER,
	StockSymbol		CHAR(5),
	
	PRIMARY KEY (AccNum, StockSymbol),
	FOREIGN KEY (AccNum) REFERENCES Account_ (AccNum)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- inserting data

INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email)
VALUES ('Yang', 'Shang', '123 Success Street', 'Stony Brook', 'NY', '11790', '5166328959', 'syang@cs.sunysb.edu');

INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email)
VALUES ('Du', 'Victor', '456 Fortune Road', 'Stony Brook', 'NY', '11790', '5166324360', 'vicdu@cs.sunysb.edu');

INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email)
VALUES ('Smith', 'John', '789 Peace Blvd.', 'Los Angeles', 'CA', '93536', '3154434321', 'jsmith@ic.sunysb.edu');

INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email)
VALUES ('Philip', 'Lewis', '135 Knowledge Lane', 'Stony Brook', 'NY', '11794', '5166668888', 'pml@cs.sunysb.edu');

INSERT INTO Account_(AccCreDate, CreditCNum, CusId)
VALUES ('2006-10-01 00:00:00', '1234567812345678', 4);

INSERT INTO Account_(AccCreDate, CreditCNum, CusId)
VALUES ('2006-10-15 00:00:00', '5678123456781234', 2);

INSERT INTO Account_(AccCreDate, CreditCNum, CusId)
VALUES ('2016-10-15 00:00:00', '5432123456781234', 1);

INSERT INTO Stock (StockSymbol, StockName, StockType, SharePrice, NumAvailShares)
VALUES ('GM', 'General Motors', 'automotive', 34.23, 1000);

INSERT INTO Stock (StockSymbol, StockName, StockType, SharePrice, NumAvailShares)
VALUES ('IBM', 'IBM', 'computer', 91.43, 500);

INSERT INTO Stock (StockSymbol, StockName, StockType, SharePrice, NumAvailShares)
VALUES ('F', 'Ford', 'automotive', 9.0, 750);

INSERT INTO Portfolio (AccNum, StockSymbol, NumShares)
VALUES (1, 'GM', 250);

INSERT INTO Portfolio (AccNum, StockSymbol, NumShares)
VALUES (1, 'F', 100);

INSERT INTO Portfolio (AccNum, StockSymbol, NumShares)
VALUES (2, 'IBM', 50);

INSERT INTO Portfolio (AccNum, StockSymbol, NumShares)
VALUES (3, 'GM', 50);

INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
VALUES ('F', 'Sell', 30, 1, NOW(), 'Market', 0);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('CoolPerson', '2cool4school', 1, 1);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('DuVic', 'horse', 1, 2);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('Wordsmith', 'pen>sword', 1, 3);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('Clark', 'adventure', 1, 4);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('Dsmith', '12345', 2, 1);

INSERT INTO Login (Usr, Pwd, AccType, Id)
VALUES ('Boss', 'password', 3, 2);

INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
VALUES ('F', 'Buy', 200, 3, NOW(), 'Market', 0);

INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
VALUES ('IBM', 'Buy', 100, 1, NOW(), 'Market', 0);

INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
VALUES ('IBM', 'Sell', 25, 2, NOW(), 'Market', 0);

INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
VALUES ('GM', 'Buy', 100, 1, NOW(), 'Market', 0);

UPDATE Portfolio P
	SET P.NumShares = 200
    WHERE P.AccNum = 1
    AND P.StockSymbol = 'F';
SET SQL_SAFE_UPDATES = 0;

UPDATE Order_ O
	SET Recorded = 0
	WHERE O.OrderId = 10;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE Order_ O
	SET Completed = 0
	WHERE O.OrderId = 1;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE Stock SET SharePrice = 6
	WHERE StockSymbol = 'F';
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE Stock SET SharePrice = 85
	WHERE StockSymbol = 'IBM';
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

-- triggers

-- Make sure share price is positive.
CREATE TRIGGER SharePriceValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.SharePrice = IF
		(NEW.SharePrice > 0,
        NEW.SharePrice,
        NULL);

-- Make sure share price is positive.
CREATE TRIGGER SharePriceValid2
	BEFORE UPDATE ON Stock FOR EACH ROW
	SET NEW.SharePrice = IF
		(NEW.SharePrice > 0,
        NEW.SharePrice,
        NULL);

-- Make sure that there is not a negative number of shares available.
CREATE TRIGGER AvailSharesValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.NumAvailShares = IF
		(NEW.NumAvailShares > -1,
        NEW.NumAvailShares,
        NULL);

-- Make sure the Order being added is for a valid number of shares.
CREATE TRIGGER NumSharesValid
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.NumShares = IF
			(NEW.NumShares > 0,
            NEW.NumShares,
            NULL);

-- Change the prices on an inserted Order.
CREATE TRIGGER GetPrices
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.CurSharePrice = (SELECT S.SharePrice FROM Stock S WHERE S.StockSymbol = NEW.StockSymbol);
		
-- Make sure the order type is in the domain allowed.
CREATE TRIGGER OrderTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.OrderType = IF
			(NEW.OrderType IN ('Buy', 'Sell'),
			NEW.OrderType,
            NULL);

-- Make sure that the price type is allowed.
CREATE TRIGGER PriceTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.PriceType = IF
			(NEW.PriceType IN ('Market', 'Market on Close'),
			NEW.PriceType,
            NULL);

-- procedures

delimiter $$
-- Set price and fee in Transact table.
CREATE TRIGGER GetPrices2
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN 
		SET NEW.PricePerShare = (SELECT S.SharePrice
								 FROM Stock S, Order_ O
								 WHERE S.StockSymbol = O.StockSymbol
										AND O.OrderId = NEW.OrderId);
		SET NEW.TransFee = NEW.PricePerShare * (SELECT O.NumShares FROM Order_ O WHERE O.OrderId = NEW.OrderId LIMIT 1) * 0.05;
	END;
$$
delimiter ;

delimiter $$
-- Executes a transaction for an order.
-- Checks to make sure that the number of shares being
-- bought or sold is correct.
CREATE TRIGGER DoTransact
	BEFORE UPDATE ON Order_ FOR EACH ROW
		IF(NEW.Recorded <> OLD.Recorded)
			THEN IF(NEW.OrderType = 'Sell')
				THEN IF(NEW.PriceType = 'Market')
					THEN IF(NEW.NumShares <= 
							(SELECT P.NumShares
							FROM Portfolio P
							WHERE NEW.CusAccNum = P.AccNum
							AND NEW.StockSymbol = P.StockSymbol))
						THEN INSERT INTO Transact(OrderId)
							VALUES(NEW.OrderId);
						SET NEW.Completed = 1;
					END IF;
				END IF;
                
			END IF;
            IF(NEW.OrderType = 'Buy')
				THEN IF(NEW.NumShares <= 
						(SELECT S.NumAvailShares
						FROM Stock S
						WHERE NEW.StockSymbol = S.StockSymbol))
					THEN INSERT INTO Transact(OrderId)
						VALUES(NEW.OrderId);
					SET NEW.Completed = 1;
				END IF;
			END IF;
        END IF;
$$
delimiter ;

-- Make sure that there is not a negative number of shares.
CREATE TRIGGER NumSharesValid2
	BEFORE INSERT ON Portfolio FOR EACH ROW
	SET NEW.NumShares = IF
		(NEW.NumShares > -1,
        NEW.NumShares,
        NULL);

delimiter $$
-- Adds or subtracts shares from the portfolio following an order transaction.
CREATE TRIGGER UpdatePortfolio
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Portfolio P
		SET P.NumShares = P.NumShares + 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
				FROM Order_ O, Account_ A
				WHERE NEW.OrderId = O.OrderId
				AND O.CusAccNum = A.AccNum
				AND O.StockSymbol = P.StockSymbol
                AND P.AccNum = A.AccNum
				LIMIT 1)
		WHERE P.AccNum = 
			(SELECT A.AccNum
            FROM Account_ A, Order_ O
            WHERE NEW.OrderID = O.OrderId
			AND O.CusAccNum = A.AccNum
            AND O.StockSymbol = P.StockSymbol
            LIMIT 1);
	END;
$$
delimiter ;

delimiter $$
-- Adds a new portfolio entry to account following a transaction.
CREATE TRIGGER AddToAccount
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		IF(NOT EXISTS(SELECT * FROM Portfolio P, Account_ A, Order_ O
					  WHERE NEW.OrderId = O.OrderId
                      AND O.CusAccNum = A.AccNum
                      AND A.AccNum = P.AccNum
                      AND P.StockSymbol = O.StockSymbol))
		THEN INSERT INTO Portfolio(AccNum, StockSymbol, NumShares)
			VALUES((SELECT O.CusAccNum
					   FROM Order_ O
					   WHERE NEW.OrderId = O.OrderId),
					(SELECT O.StockSymbol
						FROM Order_ O
						WHERE NEW.OrderId = O.OrderId),
					(SELECT O.NumShares
						FROM Order_ O
						WHERE NEW.OrderId = O.OrderId));
		END IF;
	END;
$$
delimiter ;

delimiter $$
-- Updates the number of available shares of a stock
-- after an order is executed.
CREATE TRIGGER UpdateStockQuantity
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Stock S
		SET S.NumAvailShares = S.NumAvailShares - 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId
            LIMIT 1)
		WHERE S.StockSymbol = 
			(SELECT O.StockSymbol
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId
            LIMIT 1);
	END;
$$
delimiter ;

-- transactions

delimiter $$
-- Sets the share price of a stock.
CREATE PROCEDURE setSharePrice(IN stock_sym VARCHAR(5), IN share_price FLOAT(2))
	BEGIN
		UPDATE Stock
		SET SharePrice = share_price
		WHERE StockSymbol = stock_sym;
    END
$$ delimiter ;

delimiter $$
-- Gets a sales report for a particular month and year.
CREATE PROCEDURE getSalesReport(IN yr INT, IN mon INT)
	BEGIN
		SELECT T.Transfee, T.OrderId
		FROM Transact T
		WHERE YEAR(T.Timestamp_) = yr
		AND MONTH(T.Timestamp_) = mon;
    END
$$ delimiter ;

delimiter $$
-- Produces a list of all stocks and how many orders are
-- placed for each one.
CREATE PROCEDURE listAllStocks()
	BEGIN
		SELECT S.*, COUNT(O.StockSymbol) AS OrdersPlaced
		FROM Stock S, Order_ O
		WHERE S.StockSymbol = O.StockSymbol
		GROUP BY S.StockSymbol;
	END
$$ delimiter ;

delimiter $$
-- Produces a list of all stocks and how many orders are
-- placed for each one.
CREATE PROCEDURE getNumOrders(IN stock_symbol VARCHAR(5))
	BEGIN
		SELECT COUNT(O.StockSymbol) AS OrdersPlaced
		FROM Order_ O
		WHERE stock_symbol = O.StockSymbol
		GROUP BY O.StockSymbol;
	END
$$ delimiter ;

delimiter $$
-- Creates a list of orders that are ordered by stock symbol
-- or customer name.
CREATE PROCEDURE listOrdersBy(IN field CHAR(5))
	BEGIN
		IF(field = 'order')
        THEN SELECT *
			FROM Order_ O
			ORDER BY O.StockSymbol;
		END IF;
		IF(field = 'name')
        THEN SELECT O.*, C.FirstName, C.LastName
			FROM Order_ O, Customer C
			WHERE O.CusAccNum = C.CusId
			ORDER BY C.LastName, C.FirstName;
		END IF;
    END
$$ delimiter ;

delimiter $$
-- Shows the total revenue produced by each stock.
CREATE PROCEDURE showStockRevenue()
	BEGIN
		SELECT S.StockSymbol, S.StockName, S.TotalRevenue
		FROM StockRevenue S;
    END
$$ delimiter ;

delimiter $$
-- Shows the total revenue produced by each customer.
CREATE PROCEDURE showCustomerRevenue()
	BEGIN
		SELECT C.CusAccNum, C.FirstName, C.LastName, S.TotalRevenue
		FROM CustomerRevenue C;
    END
$$ delimiter ;

-- ----- CUSTOMER REPRESENTATIVE LEVEL TRANSACTIONS ----- --
delimiter $$
-- Records an order, meaning it is ready to be executed.
CREATE PROCEDURE recordOrder(IN order_id INT)
	BEGIN
		UPDATE Order_ O
		SET Recorded = 1
		WHERE O.OrderId = order_id;
    END
$$ delimiter ;

delimiter $$
-- Adds a customer to the database.
CREATE PROCEDURE addCustomer(IN last_name VARCHAR(20), IN first_name VARCHAR(20),
							 IN address VARCHAR(50), IN city VARCHAR(20),
                             IN state VARCHAR(20), IN zipcode CHAR(5),
                             IN telephone CHAR(10), IN email VARCHAR(50))
	BEGIN
		INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email)
		VALUES (last_name, first_name, address, city, state, zipcode, telephone, email);
    END
$$ delimiter ;

-- Delete a customer from db
delimiter $$
CREATE PROCEDURE deleteCustomer(IN cus_id INT)
	BEGIN
		DELETE FROM Customer
        WHERE CusId = cus_id;
    END
$$ delimiter ;

-- ----- CUSTOMER LEVEL TRANSACTIONS ----- --
-- Get customers current stock holdings
delimiter $$
CREATE PROCEDURE getCustomerStockHoldings(IN customer_id INT)
	BEGIN
		SELECT P.AccNum, P.StockSymbol, P.NumShares
		FROM Portfolio P, Account A, Customer C
		WHERE P.AccNum = A.AccNum
			AND A.CusId = C.CusId
			AND C.CusId = customer_id;
    END
$$ delimiter ;

-- A history of all current and past orders a customer has placed.
delimiter $$
CREATE PROCEDURE getCustomerOrdersHistory(IN customer_id INT)
	BEGIN
		SELECT O.Timestamp_, O.CusAccNum, O.OrderType, O.StockSymbol, O.NumShares, O.CurSharePrice, 	O.PriceType
		FROM Order_ O, Customer C, Account A
		WHERE O.CusAccNum = A.AccNum
		AND A.CusId = C.CusId AND C.CusId = customer_id;
    END
$$ delimiter ;

-- Stocks available of a particular type 
delimiter $$
CREATE PROCEDURE getStockUsingType(IN stock_type CHAR(20)) 
	BEGIN
		SELECT S.*
		FROM STOCK S
		WHERE S.StockType LIKE CONCAT('%', stock_type, '%');

    END
$$ delimiter ;

-- Most-recent order info of a customer
delimiter $$
CREATE PROCEDURE getMostRecentOrderInfo(IN cus_id INTEGER, IN stock_sym VARCHAR(5))
	BEGIN
		SELECT O.*
		FROM ORDER_ O, CUSTOMER C, ACCOUNT_ A
		WHERE O.CusAccNum = A.AccNum AND A.CusId = C.CusId 
			AND C.CusId = cus_id AND O.StockSymbol = stock_sym
			AND TIMESTAMPDIFF(MONTH, NOW(), O.Timestamp_) <= 3;

    END
$$ delimiter ;

-- Stocks available with a particular keyword or set of keywords in the stock name
delimiter $$
CREATE PROCEDURE getStockUsingKeyword(IN stock_keyword CHAR(20)) 
	BEGIN
		SELECT S.*
		FROM STOCK S
		WHERE S.StockName LIKE CONCAT('%', stock_keyword, '%');
    END
$$ delimiter ;

delimiter $$

CREATE PROCEDURE MarkComplete(IN order_id INT, IN cur_share_price FLOAT(2)) 
	BEGIN
		IF (1 = (SELECT O.Recorded
					FROM ORDER_ O
					WHERE order_id = O.OrderId)
			AND (SELECT O.NumShares
				 FROM Order_ O
                 WHERE O.OrderId = order_id) <= 
                 (SELECT P.NumShares
                  FROM Portfolio P, Order_ O
                  WHERE P.StockSymbol = O.StockSymbol
                  AND O.OrderId = order_id
                  AND O.CusAccNum = P.AccNum))
            THEN UPDATE Order_ O
			SET O.Completed = 1
			WHERE O.OrderId = order_id;
		END IF;
	END;
$$
delimiter ;

-- SELECT * from customer;
-- SELECT * from order_;
-- SELECT * from account_;
-- SELECT * from portfolio;
-- SELECT * from stock;
-- SELECT * from Transact;
-- SELECT * from Login;

-- placing order ->
-- INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
-- VALUES ('IBM', 'Sell', 25, 2, NOW(), 'Market', 0);

-- INSERT INTO Order_ (StockSymbol, OrderType, NumShares, CusAccNum, Timestamp_, PriceType, Recorded)
-- VALUES ('GM', 'Buy', 100, 1, NOW(), 'Market', 0);

-- call recordOrder(6);
-- call recordOrder(7);

-- call MarkComplete(6, 100.00);
-- call MarkComplete(5, 200);

-- droping tables
-- DROP VIEW CUSTOMERREVENUE;
-- DROP VIEW Suggest;
-- DROP VIEW STOCKTYPEREVENUE;
-- DROP VIEW StockRevenue;
-- DROP TRIGGER AddToAccount;
-- DROP TRIGGER SellOrder;

-- DROP PROCEDURE getStockUsingType;
-- DROP PROCEDURE getStockUsingKeyword;
-- DROP PROCEDURE Suggest;
-- DROP PROCEDURE getMostRecentOrderInfo;

-- call getStockUsingType('r');
-- call getStockUsingKeyword('i');
-- call Suggest(4);

-- DROP TABLE Transact;
-- DROP TABLE Order_;
-- DROP TABLE Portfolio;
-- DROP TABLE Account_;
-- DROP TABLE Stock;
-- DROP TABLE Customer;
-- DROP TABLE Login;

-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE STOCK
-- SET SharePrice = 10
-- WHERE StockSymbol = "GM";
-- SET SQL_SAFE_UPDATES = 1;

-- SHOW ERRORS;