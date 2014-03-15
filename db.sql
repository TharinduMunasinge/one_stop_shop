SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `One_Stop_Shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `One_Stop_Shop` ;

-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`Brand` (
  `BrandName` VARCHAR(45) NOT NULL,
  `BrandCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`BrandCode`),
  UNIQUE INDEX `BrandName_UNIQUE` (`BrandName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`ItemType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`ItemType` (
  `ItemTypeName` VARCHAR(45) NOT NULL,
  `ItemTypeCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`ItemTypeCode`),
  UNIQUE INDEX `BrandName_UNIQUE` (`ItemTypeName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`Item` (
  `BrandCode` VARCHAR(5) NOT NULL,
  `ItemTypeCode` VARCHAR(5) NOT NULL,
  `Description` VARCHAR(45) NULL,
  `BuyingPrice` FLOAT NOT NULL,
  `SellingPrice` FLOAT NOT NULL,
  `LastIntake` DATETIME NULL,
  `LastBuyingQty` INT NULL,
  `AvailableQty` INT NULL,
  PRIMARY KEY (`BrandCode`, `ItemTypeCode`),
  INDEX `ItemTypeName_ItemType_fk_idx` (`ItemTypeCode` ASC),
  CONSTRAINT `BrandCode_Brand_fk`
    FOREIGN KEY (`BrandCode`)
    REFERENCES `One_Stop_Shop`.`Brand` (`BrandCode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `ItemTypeName_ItemType_fk`
    FOREIGN KEY (`ItemTypeCode`)
    REFERENCES `One_Stop_Shop`.`ItemType` (`ItemTypeCode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`Customer` (
  `CustomerID` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `AddressCity` VARCHAR(45) NULL,
  `AddressStreet` VARCHAR(45) NULL,
  `AddressNumber` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `CustomerType` VARCHAR(1) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`Order` (
  `OrderNumber` VARCHAR(10) NOT NULL,
  `CustomerID` VARCHAR(10) NULL,
  `Proceesed` TINYINT(1) NULL,
  `Credited` TINYINT(1) NULL,
  `DateCreated` DATETIME NULL,
  PRIMARY KEY (`OrderNumber`),
  INDEX `CustomerID_idx` (`CustomerID` ASC),
  CONSTRAINT `CustomerID_Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`OrderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`OrderItem` (
  `BrandCode` VARCHAR(5) NOT NULL,
  `ItemTypeCode` VARCHAR(5) NOT NULL,
  `OrderedQty` INT NULL,
  `OrderNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`BrandCode`, `OrderNumber`, `ItemTypeCode`),
  INDEX `ItemNumber_idx` (`BrandCode` ASC),
  CONSTRAINT `ItemNumber_OrderItem_fk`
    FOREIGN KEY (`BrandCode`)
    REFERENCES `One_Stop_Shop`.`Item` (`BrandCode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `OrderNumber_OrderItem_fk`
    FOREIGN KEY (`OrderNumber`)
    REFERENCES `One_Stop_Shop`.`Order` (`OrderNumber`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`CustomerContact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`CustomerContact` (
  `TelephoneNumber` VARCHAR(10) NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`TelephoneNumber`, `ID`),
  INDEX `CustomerID_idx` (`ID` ASC),
  CONSTRAINT `CustomerID_Contact_fk`
    FOREIGN KEY (`ID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`SalesRepID`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`SalesRepID` (
  `SalesRepID` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `ContactNumber` VARCHAR(10) NULL,
  PRIMARY KEY (`SalesRepID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`LargeOrderCustomer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`LargeOrderCustomer` (
  `CustomerID` VARCHAR(10) NOT NULL,
  `CreditLimitAccpeted` TINYINT(1) NULL,
  `BRN` VARCHAR(10) NULL,
  `SalesRepID` VARCHAR(10) NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `SalesRepID_idx` (`SalesRepID` ASC),
  CONSTRAINT `CustomerID_LargeOrderCustomer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `SalesRepID_LargeOrderCustomer_fk`
    FOREIGN KEY (`SalesRepID`)
    REFERENCES `One_Stop_Shop`.`SalesRepID` (`SalesRepID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`CreditFacility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`CreditFacility` (
  `CustomerID` VARCHAR(10) NOT NULL,
  `CreditLimit` FLOAT NULL,
  `AvailableCredit` FLOAT NULL,
  `FirstIssue` DATETIME NULL,
  `DuePeriod` INT NOT NULL,
  `ClearCount` INT NULL,
  `TotalPoint` INT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `CustomerID_CreditFacility_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`WalkIngVIP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`WalkIngVIP` (
  `CustomerID` VARCHAR(10) NOT NULL,
  `TRN` VARCHAR(10) NOT NULL,
  `CreditFacilityAccepted` TINYINT(1) NOT NULL,
  INDEX `CustomerNumber_idx` (`CustomerID` ASC),
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `CustomerID_WalkInVip_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`MailOrderCustomer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`MailOrderCustomer` (
  `CustomerID` VARCHAR(10) NOT NULL,
  `TRN` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  CONSTRAINT `CustomerID_MailOrderCustomer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`UserAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`UserAccount` (
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `AccountType` VARCHAR(2) NOT NULL,
  `AccountNumber` VARCHAR(10) NOT NULL,
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC),
  PRIMARY KEY (`UserName`),
  CONSTRAINT `AccountNumber_SalesRepID_UserAccount_fk`
    FOREIGN KEY (`AccountNumber`)
    REFERENCES `One_Stop_Shop`.`SalesRepID` (`SalesRepID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `AccountNumber_CustomerID_UserAccount_fk`
    FOREIGN KEY (`AccountNumber`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`Supplier` (
  `SupplierID` VARCHAR(10) NOT NULL,
  `SupplierName` VARCHAR(45) NULL,
  `AddressCity` VARCHAR(45) NULL,
  `AddressStreet` VARCHAR(45) NULL,
  `AddressNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`SupplierID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`SupplierOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`SupplierOrder` (
  `Date` DATETIME NULL,
  `OrderID` VARCHAR(10) NOT NULL,
  `SupplierID` VARCHAR(10) NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `SupplierID_idx` (`SupplierID` ASC),
  CONSTRAINT `SupplierID_SupplierOrders_fk`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `One_Stop_Shop`.`Supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`SupplierOrderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`SupplierOrderItem` (
  `OrderID` VARCHAR(10) NOT NULL,
  `BrandCode` VARCHAR(5) NULL,
  `ItemTypeCode` VARCHAR(5) NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `ItemNumber_idx` (`BrandCode` ASC),
  CONSTRAINT `OrderID_SupplierOrderItem_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `One_Stop_Shop`.`SupplierOrder` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `ItemNumber_SupplierOrderItem_fk`
    FOREIGN KEY (`BrandCode`)
    REFERENCES `One_Stop_Shop`.`Item` (`BrandCode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`SupplierContact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`SupplierContact` (
  `TelephoneNumber` VARCHAR(10) NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`TelephoneNumber`, `ID`),
  INDEX `SupplierID_Contact_fk_idx` (`ID` ASC),
  CONSTRAINT `SupplierID_Contact_fk`
    FOREIGN KEY (`ID`)
    REFERENCES `One_Stop_Shop`.`Supplier` (`SupplierID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`EmployeeContact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`EmployeeContact` (
  `TelephoneNumber` VARCHAR(10) NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`TelephoneNumber`, `ID`),
  INDEX `EmployeeID_Contact_fk0_idx` (`ID` ASC),
  CONSTRAINT `EmployeeID_Contact_fk0`
    FOREIGN KEY (`ID`)
    REFERENCES `One_Stop_Shop`.`SalesRepID` (`SalesRepID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`ProcessedOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`ProcessedOrder` (
  `OrderNumber` VARCHAR(10) NOT NULL,
  `CustomerID` VARCHAR(10) NULL,
  `Credited` TINYINT(1) NULL,
  `DateCreated` DATETIME NULL,
  `DateProcessed` DATETIME NULL,
  PRIMARY KEY (`OrderNumber`),
  INDEX `CustomerID_ProcessedOrder_fk_idx` (`CustomerID` ASC),
  CONSTRAINT `CustomerID_ProcessedOrder_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `One_Stop_Shop`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `One_Stop_Shop`.`StockNotification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `One_Stop_Shop`.`StockNotification` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NULL,
  `processed` TINYINT(1) NULL,
  `itemCode` VARCHAR(5) NULL,
  `brandCode` VARCHAR(5) NULL,
  PRIMARY KEY (`Id`),
  INDEX `Item_BrandCode_fk_idx` (`brandCode` ASC),
  INDEX `Item_ItemTypeCode_fk_idx` (`itemCode` ASC),
  CONSTRAINT `Item_BrandCode_fk`
    FOREIGN KEY (`brandCode`)
    REFERENCES `One_Stop_Shop`.`Item` (`BrandCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Item_ItemTypeCode_fk`
    FOREIGN KEY (`itemCode`)
    REFERENCES `One_Stop_Shop`.`Item` (`ItemTypeCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT ALL ON `One_Stop_Shop`.* TO 'admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE `One_Stop_Shop`.* TO 'admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `One_Stop_Shop`.* TO 'admin';
GRANT EXECUTE ON ROUTINE `One_Stop_Shop`.* TO 'admin';
GRANT SELECT ON TABLE `One_Stop_Shop`.* TO 'admin';
CREATE USER 'user' IDENTIFIED BY 'user';

GRANT SELECT ON TABLE `One_Stop_Shop`.* TO 'user';
GRANT SELECT, INSERT, TRIGGER ON TABLE `One_Stop_Shop`.* TO 'user';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `One_Stop_Shop`.* TO 'user';
CREATE USER 'unregistered' IDENTIFIED BY 'unregistered';

GRANT SELECT ON TABLE `One_Stop_Shop`.* TO 'unregistered';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `One_Stop_Shop`;

DELIMITER $$
USE `One_Stop_Shop`$$
$$


DELIMITER ;
