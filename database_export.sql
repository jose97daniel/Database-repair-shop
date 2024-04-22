-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema miamirepair
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema miamirepair
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `miamirepair` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `miamirepair` ;

-- -----------------------------------------------------
-- Table `miamirepair`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`customer` (
  `Customer_Id` INT NOT NULL,
  `First_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Last_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `St_Address` VARCHAR(50) NOT NULL DEFAULT '',
  `City` VARCHAR(50) NOT NULL DEFAULT '',
  `Postal_Code` CHAR(7) NOT NULL DEFAULT '',
  `Date_Of_Birth` DATE NULL DEFAULT NULL,
  `Email` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  `Phone_No` CHAR(14) NOT NULL,
  PRIMARY KEY (`Customer_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`employee` (
  `Employee_Id` CHAR(10) NOT NULL,
  `First_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Last_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `St_Address` VARCHAR(50) NOT NULL DEFAULT '',
  `City` VARCHAR(50) NOT NULL DEFAULT '',
  `Postal_Code` CHAR(7) NOT NULL DEFAULT '',
  `Date_Of_Join` DATE NOT NULL,
  `Date_Of_Birth` DATE NULL DEFAULT NULL,
  `Email` VARCHAR(255) CHARACTER SET 'utf8mb3' NOT NULL,
  `Phone_No` CHAR(14) NOT NULL,
  PRIMARY KEY (`Employee_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`offer` (
  `Offer_No` CHAR(10) NOT NULL,
  `Offer_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Offer_Description` VARCHAR(255) NOT NULL DEFAULT '',
  `Discount` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`Offer_No`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`supplier` (
  `Supplier_Id` SMALLINT NOT NULL,
  `Supplier_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Date_Added` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Supplier_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`product` (
  `Product_Id` CHAR(10) NOT NULL,
  `Supplier_Id` SMALLINT NULL DEFAULT NULL,
  `Product_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Listed_Price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `Quantity` TINYINT NOT NULL DEFAULT '0',
  `Product_Description` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Product_Id`),
  INDEX `Supplier_Id` (`Supplier_Id` ASC) VISIBLE,
  CONSTRAINT `product_ibfk_1`
    FOREIGN KEY (`Supplier_Id`)
    REFERENCES `miamirepair`.`supplier` (`Supplier_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`sales` (
  `Sales_Id` INT NOT NULL,
  `Customer_Id` INT NULL DEFAULT NULL,
  `Employee_Id` CHAR(10) NULL DEFAULT NULL,
  `Offer_No` CHAR(10) NULL DEFAULT NULL,
  `Sold_Status` BIT(1) NOT NULL DEFAULT b'0',
  `Sale_Date` DATETIME NOT NULL,
  `Payable_Amount` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`Sales_Id`),
  INDEX `Customer_Id` (`Customer_Id` ASC) VISIBLE,
  INDEX `Employee_Id` (`Employee_Id` ASC) VISIBLE,
  INDEX `Offer_No` (`Offer_No` ASC) VISIBLE,
  CONSTRAINT `sales_ibfk_1`
    FOREIGN KEY (`Customer_Id`)
    REFERENCES `miamirepair`.`customer` (`Customer_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2`
    FOREIGN KEY (`Employee_Id`)
    REFERENCES `miamirepair`.`employee` (`Employee_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_3`
    FOREIGN KEY (`Offer_No`)
    REFERENCES `miamirepair`.`offer` (`Offer_No`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`product_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`product_sales` (
  `Product_Sales_Id` INT NOT NULL,
  `Sales_Id` INT NULL DEFAULT NULL,
  `Product_Id` CHAR(10) NULL DEFAULT NULL,
  `Quantity` TINYINT NOT NULL DEFAULT '1',
  `Selling_Price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`Product_Sales_Id`),
  INDEX `Sales_Id` (`Sales_Id` ASC) VISIBLE,
  INDEX `Product_Id` (`Product_Id` ASC) VISIBLE,
  CONSTRAINT `product_sales_ibfk_1`
    FOREIGN KEY (`Sales_Id`)
    REFERENCES `miamirepair`.`sales` (`Sales_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `product_sales_ibfk_2`
    FOREIGN KEY (`Product_Id`)
    REFERENCES `miamirepair`.`product` (`Product_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`service` (
  `Service_No` SMALLINT NOT NULL,
  `Service_Name` VARCHAR(100) NOT NULL DEFAULT '',
  `Listed_Price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `Service_Description` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Service_No`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `miamirepair`.`service_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `miamirepair`.`service_sales` (
  `Service_Sales_Id` INT NOT NULL,
  `Sales_Id` INT NULL DEFAULT NULL,
  `Service_No` SMALLINT NULL DEFAULT NULL,
  `Date_Received` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Date_due` DATE NOT NULL,
  `Selling_Price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`Service_Sales_Id`),
  INDEX `Sales_Id` (`Sales_Id` ASC) VISIBLE,
  INDEX `Service_No` (`Service_No` ASC) VISIBLE,
  CONSTRAINT `service_sales_ibfk_1`
    FOREIGN KEY (`Sales_Id`)
    REFERENCES `miamirepair`.`sales` (`Sales_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `service_sales_ibfk_2`
    FOREIGN KEY (`Service_No`)
    REFERENCES `miamirepair`.`service` (`Service_No`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
