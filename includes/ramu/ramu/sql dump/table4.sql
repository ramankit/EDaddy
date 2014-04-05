SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`userType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userType` (
  `typeID` INT NOT NULL COMMENT 'This field serves as primary key to the table',
  `userTypeName` VARCHAR(64) NOT NULL COMMENT 'This field keeps the value of the type of user i.e seller, buyer, admin, visitor',
  `userTypeDescription` VARCHAR(256) NULL COMMENT 'This is an additional field for some description regarding each user type ',
  PRIMARY KEY (`typeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is a primary key for the table  Users',
  `userFirstName` VARCHAR(256) NOT NULL COMMENT 'This field will store the first name of the user',
  `userMiddleName` VARCHAR(45) NULL COMMENT 'This field will store the middle name of the user',
  `userLastName` VARCHAR(128) NOT NULL COMMENT 'This field will store the last name of the user',
  `userDateOfBirth` DATE NOT NULL COMMENT 'This field will store the date of birth of the user',
  `userEmail` VARCHAR(256) NOT NULL COMMENT 'This field will store the email of the user',
  `userPassword` VARCHAR(32) NOT NULL COMMENT 'this field will store the password hash',
  `userRegistered` DATETIME NOT NULL COMMENT 'This field will store date and time when user registered on site.',
  `usertypeID` INT NULL COMMENT 'This field contains foreign key declaring type of user ie seller or buyer or admin',
  `userAlternateEmail` VARCHAR(128) NULL COMMENT 'This field contains the alternate email address of the user in case of password recovery',
  `userSecurityQuestion` VARCHAR(128) NOT NULL COMMENT 'This field contains the security question provided by the user',
  `userSecurityAnswer` VARCHAR(48) NOT NULL COMMENT 'This field contains the answer to the security question selected by the user',
  PRIMARY KEY (`userID`),
  INDEX `fk_User_userType_idx` (`usertypeID` ASC),
  CONSTRAINT `fk_User_userType`
    FOREIGN KEY (`usertypeID`)
    REFERENCES `mydb`.`userType` (`typeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `categoryID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field will store categoryID  as a primary number.',
  `categoryName` VARCHAR(128) NOT NULL COMMENT 'This field contains name of the category',
  `parentCategoryID` INT NULL COMMENT 'This field contains id of the parent category',
  PRIMARY KEY (`categoryID`),
  INDEX `fk_Category_Category1_idx` (`parentCategoryID` ASC),
  CONSTRAINT `fk_Category_Category1`
    FOREIGN KEY (`parentCategoryID`)
    REFERENCES `mydb`.`Category` (`categoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Manufacturer` (
  `manufacturerID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field name contains ID of the manufacturer.',
  `manufacturerName` VARCHAR(64) NOT NULL COMMENT 'This field contains name of the manufacturer',
  `manufacturerDescription` VARCHAR(512) NULL COMMENT 'This field contains description of the manufacturer',
  PRIMARY KEY (`manufacturerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `productID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field contains the primary key to a given product',
  `User_userID` INT NOT NULL COMMENT 'This field is a foreign key which contains info about the user(seller) who posted the listing.',
  `Category_categoryID` INT NOT NULL COMMENT 'This field contains  foreign key from category table for recognizing/assigning item\'s category',
  `Manufacturer_manufacturerID` INT NOT NULL COMMENT 'This field contains foreign key representing the manufacturer of the product',
  `productnName` VARCHAR(128) NOT NULL COMMENT 'This field contains the name of the product',
  `productDescription` VARCHAR(1024) NULL COMMENT 'This field contains additional information about the product',
  `productPrice` INT NOT NULL COMMENT 'This field contains the price of the product',
  `productPostDate` DATETIME NOT NULL COMMENT 'This field contains Date and time of the item listing.',
  `productExpiryDate` DATETIME NOT NULL COMMENT 'This field contains product listings end time.',
  `productCount` INT NOT NULL COMMENT 'This field contains amount of product being listed',
  `productWarranty` INT NULL DEFAULT 0 COMMENT 'This field contains product warranty in months',
  PRIMARY KEY (`productID`),
  INDEX `fk_products_User1_idx` (`User_userID` ASC),
  INDEX `fk_products_Category1_idx` (`Category_categoryID` ASC),
  INDEX `fk_products_Manufacturer1_idx` (`Manufacturer_manufacturerID` ASC),
  CONSTRAINT `fk_products_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_Category1`
    FOREIGN KEY (`Category_categoryID`)
    REFERENCES `mydb`.`Category` (`categoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_Manufacturer1`
    FOREIGN KEY (`Manufacturer_manufacturerID`)
    REFERENCES `mydb`.`Manufacturer` (`manufacturerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`image` (
  `imageID` INT NOT NULL COMMENT 'This field contains primary key for image table.',
  `products_productID` INT NOT NULL COMMENT 'This field contains ID of the product for which the image is being put',
  `imagePath` VARCHAR(512) NOT NULL COMMENT 'This field contains the path of the image on server',
  `imageUploadDate` DATETIME NOT NULL COMMENT 'This field contains date and time of upload of image.',
  `primaryImage` TINYINT(1) NOT NULL COMMENT 'This feature tells if the image is the first one to load',
  PRIMARY KEY (`imageID`),
  INDEX `fk_image_products1_idx` (`products_productID` ASC),
  CONSTRAINT `fk_image_products1`
    FOREIGN KEY (`products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Features` (
  `featureId` INT NOT NULL AUTO_INCREMENT COMMENT 'This field is the primary key for the features table',
  `featureName` VARCHAR(256) NOT NULL COMMENT 'This field contains the name of the feature of a product',
  `Category_categoryID` INT NOT NULL COMMENT 'This field contains foreign key for the category the feature belongs to.t',
  PRIMARY KEY (`featureId`),
  INDEX `fk_Features_Category1_idx` (`Category_categoryID` ASC),
  CONSTRAINT `fk_Features_Category1`
    FOREIGN KEY (`Category_categoryID`)
    REFERENCES `mydb`.`Category` (`categoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductFeature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductFeature` (
  `products_productID` INT NOT NULL COMMENT 'This field contains foreign key as product id on which the feature is available',
  `Features_featureId` INT NOT NULL COMMENT 'this field contains foreign key which tells what feature are available on a certain feature',
  INDEX `fk_ProductFeature_Features1_idx` (`Features_featureId` ASC),
  CONSTRAINT `fk_ProductFeature_products1`
    FOREIGN KEY (`products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductFeature_Features1`
    FOREIGN KEY (`Features_featureId`)
    REFERENCES `mydb`.`Features` (`featureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `User_userID` INT NOT NULL COMMENT 'This field contains a foreign key which will act as a conjugate primary key. Contains information about the user whi bought the product.',
  `Products_productID` INT NOT NULL COMMENT 'This is a foreign key field. Identifies the product being reviewd.',
  `rating` INT NULL COMMENT 'This field contains rating of a product by the shopper',
  `reviewDescription` VARCHAR(512) NULL COMMENT 'This field contains the detailed review of the product',
  `reviewDate` DATETIME NULL COMMENT 'This field contains date and time for the comment made.\n',
  INDEX `fk_Review_Products1_idx` (`Products_productID` ASC),
  CONSTRAINT `fk_Review_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_Products1`
    FOREIGN KEY (`Products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`States`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`States` (
  `stateID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field contains the id of the state as primary key',
  `stateName` VARCHAR(128) NULL COMMENT 'This field contains the value as the name of the state',
  PRIMARY KEY (`stateID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Addressbook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Addressbook` (
  `AddressID` INT NOT NULL COMMENT 'This field serves as primary key for addresses',
  `User_userID` INT NOT NULL COMMENT 'This field serves a foreign key to identify addresses associated with a perticular user',
  `Name` VARCHAR(128) NOT NULL COMMENT 'This field contains name of the person',
  `Address` VARCHAR(512) NOT NULL COMMENT 'This field contains address of the person\n',
  `District` VARCHAR(64) NOT NULL COMMENT 'This field contains district for the given address',
  `pinCode` INT NOT NULL COMMENT 'This field contains  pin code for the given address',
  `mobileNumber` INT NOT NULL COMMENT 'This field contains mobile number for the given address',
  `phoneNumber` VARCHAR(45) NULL COMMENT 'This field contains optional phone number for the given address',
  `States_stateID` INT NOT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `fk_Addressbook_User1_idx` (`User_userID` ASC),
  INDEX `fk_Addressbook_States1_idx` (`States_stateID` ASC),
  CONSTRAINT `fk_Addressbook_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Addressbook_States1`
    FOREIGN KEY (`States_stateID`)
    REFERENCES `mydb`.`States` (`stateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userAddress` (
  `isPrimary` TINYINT(1) NOT NULL COMMENT 'This field contains id of the address which is the default shipping address for a given user',
  `User_userID` INT NOT NULL COMMENT 'This field contains  the user to whom perticular address is related to',
  `Addressbook_AddressID` INT NOT NULL COMMENT 'This field contains ID of the address as a foreign key\n',
  INDEX `fk_userAddress_User1_idx` (`User_userID` ASC),
  INDEX `fk_userAddress_Addressbook1_idx` (`Addressbook_AddressID` ASC),
  CONSTRAINT `fk_userAddress_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userAddress_Addressbook1`
    FOREIGN KEY (`Addressbook_AddressID`)
    REFERENCES `mydb`.`Addressbook` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CouponType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CouponType` (
  `couponTypeID` INT NOT NULL COMMENT 'This field serves as primary key as an integer for this table',
  `typeName` VARCHAR(48) NULL COMMENT 'This field contains the name of the coupon type .ie type of coupon like  flat off or % off',
  PRIMARY KEY (`couponTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CouponGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CouponGroup` (
  `couponGroupID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field contains primary key for the table',
  `CouponMetaName` VARCHAR(48) NOT NULL COMMENT 'This field contains the name of the group on which coupon will be applied. group could be category,sub-category, manufacturer, seller or an individual product',
  PRIMARY KEY (`couponGroupID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coupons` (
  `couponCode` VARCHAR(64) NOT NULL COMMENT 'This field contains the primary key. It is a randomly generated unique string to be used as the coupon.',
  `CouponType_couponTypeID` INT NOT NULL COMMENT 'This field contains type of coupon as a foreign key indicating what form of coupon is beling applied ie flat discount or % based discount',
  `CouponGroup_couponGroupID` INT NOT NULL COMMENT 'This field contains  the foreign key indicating exactly on what object coupon will be applied. Object could be a category, seller, manufacturer or an individual product.',
  `couponGroupMetaValue` INT NOT NULL COMMENT 'This field contains the value as ID of the field on which the coupon is to be applied(manufacturer id, seller id, product id etc etc)',
  `couponStartDate` DATETIME NOT NULL COMMENT 'This field contains  the value from which the coupon will become available to the customer.',
  `couponExpiryDate` DATETIME NOT NULL COMMENT 'This field contains the date on which the coupon will expire.',
  `minAmount` INT NOT NULL DEFAULT 0 COMMENT 'This field contains value of minimum purchase amount if any on the product for a coupon to become eligible',
  `maxDiscount` INT NOT NULL DEFAULT 1500 COMMENT 'This field contains the maximum amount which can be availed under a given discount',
  `couponMaxUsage` INT NOT NULL DEFAULT 1 COMMENT 'This field contains the number of times a coupon can be availed by a single user',
  PRIMARY KEY (`couponCode`),
  INDEX `fk_Coupons_CouponType1_idx` (`CouponType_couponTypeID` ASC),
  INDEX `fk_Coupons_CouponGroup1_idx` (`CouponGroup_couponGroupID` ASC),
  CONSTRAINT `fk_Coupons_CouponType1`
    FOREIGN KEY (`CouponType_couponTypeID`)
    REFERENCES `mydb`.`CouponType` (`couponTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Coupons_CouponGroup1`
    FOREIGN KEY (`CouponGroup_couponGroupID`)
    REFERENCES `mydb`.`CouponGroup` (`couponGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field serves as primary key for the orders received by the consumer',
  `orderDate` DATETIME NOT NULL COMMENT 'This field contains  the date on which the order was made\n',
  `User_userID` INT NOT NULL COMMENT 'this field serves as foreign key with information to the user who ordered the product',
  `Addressbook_AddressID` INT NOT NULL COMMENT 'This field contains the address on which the given item has to be delivered.',
  `Coupons_couponCode` VARCHAR(64) NULL COMMENT 'This field contains the id of the coupon if applied on the product',
  PRIMARY KEY (`orderID`),
  INDEX `fk_Orders_User1_idx` (`User_userID` ASC),
  INDEX `fk_Orders_Addressbook1_idx` (`Addressbook_AddressID` ASC),
  INDEX `fk_Orders_Coupons1_idx` (`Coupons_couponCode` ASC),
  CONSTRAINT `fk_Orders_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Addressbook1`
    FOREIGN KEY (`Addressbook_AddressID`)
    REFERENCES `mydb`.`Addressbook` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Coupons1`
    FOREIGN KEY (`Coupons_couponCode`)
    REFERENCES `mydb`.`Coupons` (`couponCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderDetails` (
  `Orders_orderID` INT NOT NULL COMMENT 'This field contains the order id so as to get all the items related to the given order',
  `Products_productID` INT NOT NULL COMMENT 'this field contains product in an order',
  `quantity` INT NOT NULL COMMENT 'this field contains the number of items for a given product to be bought',
  INDEX `fk_OrderDetails_Orders1_idx` (`Orders_orderID` ASC),
  INDEX `fk_OrderDetails_Products1_idx` (`Products_productID` ASC),
  CONSTRAINT `fk_OrderDetails_Orders1`
    FOREIGN KEY (`Orders_orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderDetails_Products1`
    FOREIGN KEY (`Products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shippingCompany`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shippingCompany` (
  `shippingCompanyID` INT NOT NULL COMMENT 'This field contains the primary key for the tracking company',
  `shippingCompanyName` VARCHAR(45) NOT NULL COMMENT 'This field contains nam of the shipping company',
  `trackURL` VARCHAR(256) NOT NULL COMMENT 'this field contains the web url of th compnay for tracking an item',
  PRIMARY KEY (`shippingCompanyID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shipping` (
  `Orders_orderID` INT NOT NULL COMMENT 'this field contains the order for which transaction details are to be obtained',
  `trackingID` VARCHAR(48) NULL COMMENT 'This field contains the tracking id of the product',
  `shippingCompany_shippingCompanyID` INT NOT NULL COMMENT 'This field contains the id of the shipping company as a foreign key',
  `deliveryDate` DATE NULL COMMENT 'This field contains the date on which the product was delivered',
  INDEX `fk_shipping_Orders1_idx` (`Orders_orderID` ASC),
  INDEX `fk_shipping_shippingCompany1_idx` (`shippingCompany_shippingCompanyID` ASC),
  CONSTRAINT `fk_shipping_Orders1`
    FOREIGN KEY (`Orders_orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_shippingCompany1`
    FOREIGN KEY (`shippingCompany_shippingCompanyID`)
    REFERENCES `mydb`.`shippingCompany` (`shippingCompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transactions` (
  `idtransactions` VARCHAR(64) NOT NULL COMMENT 'this field contains the transactionID for the given transfer',
  `Orders_orderID` INT NOT NULL COMMENT 'this field contains the orderID for which transaction will take place',
  `status` TINYINT(1) NULL COMMENT 'this field checks if the transaction have been succesfully conducted or not',
  `transactionTime` DATETIME NULL COMMENT 'This field contains information regarding date and time of transaction',
  PRIMARY KEY (`idtransactions`),
  INDEX `fk_transactions_Orders1_idx` (`Orders_orderID` ASC),
  CONSTRAINT `fk_transactions_Orders1`
    FOREIGN KEY (`Orders_orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Wishlist` (
  `User_userID` INT NOT NULL COMMENT 'This field contains the id of the user who is adding item to the wishlist',
  `Products_productID` INT NOT NULL COMMENT 'This field contains id of the product which is being added to the wishlist',
  INDEX `fk_Wishlist_User1_idx` (`User_userID` ASC),
  INDEX `fk_Wishlist_Products1_idx` (`Products_productID` ASC),
  CONSTRAINT `fk_Wishlist_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wishlist_Products1`
    FOREIGN KEY (`Products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sellerPayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sellerPayment` (
  `paypalID` VARCHAR(48) NOT NULL COMMENT 'This field contains the paypal ID  of the user in which amount for the item sold will be transferred',
  `User_userID` INT NOT NULL COMMENT 'This field contains foreign key which relates to user id in whch amount is to be credited',
  PRIMARY KEY (`User_userID`),
  CONSTRAINT `fk_sellerPayment_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sellerPaymentHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sellerPaymentHistory` (
  `Orders_orderID` INT NOT NULL COMMENT 'This field contains the order id as a foreign key to identify for what order the payment is being made.',
  `sellerPaymentDate` DATETIME NOT NULL COMMENT 'This field contains  the date on which the transaction of money transfer takes place',
  `amount` INT NOT NULL COMMENT 'This field contains  the amount of money to be transferred into user\'s paypal account',
  `User_userID` INT NOT NULL COMMENT 'This field acts as a primary key for the user for whom the payment is being made',
  CONSTRAINT `fk_sellerPaymentHistory_Orders1`
    FOREIGN KEY (`Orders_orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sellerPaymentHistory_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Messages` (
  `messageID` INT NOT NULL COMMENT 'This field serves as primary key for the messages table',
  `User_userIDFrom` INT NOT NULL COMMENT 'This field contains ID of the user who will send the message',
  `User_userIDTo` INT NOT NULL COMMENT 'This field contains ID of the user to whom message is being sent',
  `messageSubject` VARCHAR(48) NULL COMMENT 'This field contains the subject of the message to be delivered',
  `messsageContent` VARCHAR(512) NOT NULL COMMENT 'This field contains the text of the message',
  `messageTime` DATETIME NOT NULL COMMENT 'This field contains date and time on which the message was sent',
  PRIMARY KEY (`messageID`),
  INDEX `fk_Messages_User1_idx` (`User_userIDFrom` ASC),
  INDEX `fk_Messages_User2_idx` (`User_userIDTo` ASC),
  CONSTRAINT `fk_Messages_User1`
    FOREIGN KEY (`User_userIDFrom`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Messages_User2`
    FOREIGN KEY (`User_userIDTo`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RefundStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RefundStatus` (
  `statusID` INT NOT NULL COMMENT 'This field contains the id of the refund status',
  `statusValue` VARCHAR(48) NULL COMMENT 'This field contains the value of the refund status',
  PRIMARY KEY (`statusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Refund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Refund` (
  `refundID` INT NOT NULL COMMENT 'This field contains primary key for the  refund table',
  `RefundStatus_statusID` INT NOT NULL COMMENT 'This field contains the refund status as a foreign key',
  `Orders_orderID` INT NOT NULL COMMENT 'This field contains id of the order for which  refund has been ordered',
  `refundReason` VARCHAR(128) NULL COMMENT 'This field contains the reason for the refund',
  PRIMARY KEY (`refundID`),
  INDEX `fk_Refund_Orders1_idx` (`Orders_orderID` ASC),
  INDEX `fk_Refund_RefundStatus1_idx` (`RefundStatus_statusID` ASC),
  CONSTRAINT `fk_Refund_Orders1`
    FOREIGN KEY (`Orders_orderID`)
    REFERENCES `mydb`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Refund_RefundStatus1`
    FOREIGN KEY (`RefundStatus_statusID`)
    REFERENCES `mydb`.`RefundStatus` (`statusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Abuse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Abuse` (
  `abuseID` INT NOT NULL AUTO_INCREMENT COMMENT 'This field contains the ID of the abuse',
  `Products_productID` INT NOT NULL COMMENT 'This field contains produt id for which the complaint has been filed',
  `User_userID` INT NOT NULL COMMENT 'This field contains the id of the user who filed the report',
  `abuseDescription` VARCHAR(128) NULL COMMENT 'This field contains the description of the abuse by the user\n',
  PRIMARY KEY (`abuseID`),
  INDEX `fk_Abuse_Products1_idx` (`Products_productID` ASC),
  INDEX `fk_Abuse_User1_idx` (`User_userID` ASC),
  CONSTRAINT `fk_Abuse_Products1`
    FOREIGN KEY (`Products_productID`)
    REFERENCES `mydb`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Abuse_User1`
    FOREIGN KEY (`User_userID`)
    REFERENCES `mydb`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Feedback` (
  `feedbackID` INT NOT NULL COMMENT 'This field acts as the primary key for the table',
  `feedbackEmaiil` VARCHAR(128) NOT NULL COMMENT 'This field contains email address of the person providing the feedback',
  `feedbackSubject` VARCHAR(256) NULL COMMENT 'This field contains the subject of the feedback',
  `feedbackContent` VARCHAR(1024) NOT NULL COMMENT 'This field contains the  content of feedback',
  PRIMARY KEY (`feedbackID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`userType`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`userType` (`typeID`, `userTypeName`, `userTypeDescription`) VALUES (0, 'Admin', 'This id is associted with the role of Administrator');
INSERT INTO `mydb`.`userType` (`typeID`, `userTypeName`, `userTypeDescription`) VALUES (1, 'User', 'This id is associated with the role of Buyer');
INSERT INTO `mydb`.`userType` (`typeID`, `userTypeName`, `userTypeDescription`) VALUES (2, 'Seller', 'This id is associated with the role of Seller');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`User` (`userID`, `userFirstName`, `userMiddleName`, `userLastName`, `userDateOfBirth`, `userEmail`, `userPassword`, `userRegistered`, `usertypeID`, `userAlternateEmail`, `userSecurityQuestion`, `userSecurityAnswer`) VALUES (1, 'Ramankit', NULL, 'Singh', '1991-04-30', 'ramankit.singh@gmail.com', 'krait', '2013-27-10', 1, 'demo@demo.com', 'first pet\'s name', 'rosi');
INSERT INTO `mydb`.`User` (`userID`, `userFirstName`, `userMiddleName`, `userLastName`, `userDateOfBirth`, `userEmail`, `userPassword`, `userRegistered`, `usertypeID`, `userAlternateEmail`, `userSecurityQuestion`, `userSecurityAnswer`) VALUES (2, 'Narayan', 'Singh', 'Tomar', '1992-02-10', 'tomar.narayan@gmail.com', 'ramram', '2013-27-10', 1, 'test@test.com', 'marks in 1st class', '90');
INSERT INTO `mydb`.`User` (`userID`, `userFirstName`, `userMiddleName`, `userLastName`, `userDateOfBirth`, `userEmail`, `userPassword`, `userRegistered`, `usertypeID`, `userAlternateEmail`, `userSecurityQuestion`, `userSecurityAnswer`) VALUES (3, 'Kuldeep', 'Singh', 'Bhadauriya', '1990-02-25', 'kuldeepbhadauriya06@gmail.com', 'ak47', '2013-28-10', 2, 'op@blackops.com', 'maiden name ', 'singh');
INSERT INTO `mydb`.`User` (`userID`, `userFirstName`, `userMiddleName`, `userLastName`, `userDateOfBirth`, `userEmail`, `userPassword`, `userRegistered`, `usertypeID`, `userAlternateEmail`, `userSecurityQuestion`, `userSecurityAnswer`) VALUES (4, 'Jonathan', 'Sudeep', 'Saldanha', '1991-04-29', 'jsaldanha100@gmail.com', 'sudeep', '2013-28-10', 0, 'admin@opcart.com', 'crazy admin', 'ramu');
INSERT INTO `mydb`.`User` (`userID`, `userFirstName`, `userMiddleName`, `userLastName`, `userDateOfBirth`, `userEmail`, `userPassword`, `userRegistered`, `usertypeID`, `userAlternateEmail`, `userSecurityQuestion`, `userSecurityAnswer`) VALUES (5, 'Dushyant', NULL, 'Kumar', '1988-06-23', 'dushyantk59@gmail.com', 'oreo', '2013-28-10', 1, 'food@fat.com', 'what i need the most', 'food ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Category`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (1, 'All', NULL);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (2, 'Electronics', 1);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (3, 'Clothing', 1);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (4, 'Mobiles', 2);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (5, 'Sony Mobiles', 4);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (6, 'Samsung Mobiles', 4);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (7, 'Men\'s Clothing', 3);
INSERT INTO `mydb`.`Category` (`categoryID`, `categoryName`, `parentCategoryID`) VALUES (8, 'Peter England', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Manufacturer`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Manufacturer` (`manufacturerID`, `manufacturerName`, `manufacturerDescription`) VALUES (1, 'Dell', 'Dell is world leader is making computer devices. Founded by Michael Dell, it has just smoked its competitiors.');
INSERT INTO `mydb`.`Manufacturer` (`manufacturerID`, `manufacturerName`, `manufacturerDescription`) VALUES (2, 'Samsung', 'Samsung is world leader in making consumer electronics. Based in Korea,it dominates the smartphone market.');
INSERT INTO `mydb`.`Manufacturer` (`manufacturerID`, `manufacturerName`, `manufacturerDescription`) VALUES (3, 'Sony', 'Sony  makes premium consumer electronics.');
INSERT INTO `mydb`.`Manufacturer` (`manufacturerID`, `manufacturerName`, `manufacturerDescription`) VALUES (4, 'Peter England', 'Makes world class clothing material for men all over the world');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Products`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Products` (`productID`, `User_userID`, `Category_categoryID`, `Manufacturer_manufacturerID`, `productnName`, `productDescription`, `productPrice`, `productPostDate`, `productExpiryDate`, `productCount`, `productWarranty`) VALUES (1, 3, 5, 3, 'Xperia SP', 'Codenamed Huashan, it is obne of the best mid range android phone out in the market', 20000, '2013-10-28', '2013-11-10', 15, 12);
INSERT INTO `mydb`.`Products` (`productID`, `User_userID`, `Category_categoryID`, `Manufacturer_manufacturerID`, `productnName`, `productDescription`, `productPrice`, `productPostDate`, `productExpiryDate`, `productCount`, `productWarranty`) VALUES (2, 3, 5, 3, 'Xperia Z', 'Aren\'t you amazed to see a premium phone with waterproofing. This Phone delivers on all your expectations.', 35000, '2013-10-28', '2013-11-10', 10, 12);
INSERT INTO `mydb`.`Products` (`productID`, `User_userID`, `Category_categoryID`, `Manufacturer_manufacturerID`, `productnName`, `productDescription`, `productPrice`, `productPostDate`, `productExpiryDate`, `productCount`, `productWarranty`) VALUES (3, 3, 6, 2, 'Galaxy S4', 'Best android smartphone out in the market', 41000, '2013-10-28', '2013-11-10', 50, 12);
INSERT INTO `mydb`.`Products` (`productID`, `User_userID`, `Category_categoryID`, `Manufacturer_manufacturerID`, `productnName`, `productDescription`, `productPrice`, `productPostDate`, `productExpiryDate`, `productCount`, `productWarranty`) VALUES (4, 3, 6, 2, 'Galaxy S3', 'Best value for money phone in the market.', 23500, '2013-10-28', '2013-11-10', 30, 12);
INSERT INTO `mydb`.`Products` (`productID`, `User_userID`, `Category_categoryID`, `Manufacturer_manufacturerID`, `productnName`, `productDescription`, `productPrice`, `productPostDate`, `productExpiryDate`, `productCount`, `productWarranty`) VALUES (5, 3, 8, 4, 'Red Shirt', 'Fine material and fabrics. Attractive shirt.', 1200, '2013-10-28', '2013-11-10', 100, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Features`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Features` (`featureId`, `featureName`, `Category_categoryID`) VALUES (1, 'Touchscreen', 4);
INSERT INTO `mydb`.`Features` (`featureId`, `featureName`, `Category_categoryID`) VALUES (2, 'Android', 4);
INSERT INTO `mydb`.`Features` (`featureId`, `featureName`, `Category_categoryID`) VALUES (3, 'GorillaGlass', 4);
INSERT INTO `mydb`.`Features` (`featureId`, `featureName`, `Category_categoryID`) VALUES (4, 'Shirt', 3);
INSERT INTO `mydb`.`Features` (`featureId`, `featureName`, `Category_categoryID`) VALUES (5, 'TShirt', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ProductFeature`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (1, 1);
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (1, 2);
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (1, 3);
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (2, 1);
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (2, 2);
INSERT INTO `mydb`.`ProductFeature` (`products_productID`, `Features_featureId`) VALUES (2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Review` (`User_userID`, `Products_productID`, `rating`, `reviewDescription`, `reviewDate`) VALUES (5, 3, 4, 'One of the best phones I have ever used', '2013-28-10');
INSERT INTO `mydb`.`Review` (`User_userID`, `Products_productID`, `rating`, `reviewDescription`, `reviewDate`) VALUES (2, 3, 5, 'Awesome phone. Authentic seller', '2013-29-10');
INSERT INTO `mydb`.`Review` (`User_userID`, `Products_productID`, `rating`, `reviewDescription`, `reviewDate`) VALUES (4, 1, 5, 'Best Mid range phone ever', '2013-29-10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`States`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`States` (`stateID`, `stateName`) VALUES (1, 'Uttar Pradesh');
INSERT INTO `mydb`.`States` (`stateID`, `stateName`) VALUES (2, 'Uttarkhand');
INSERT INTO `mydb`.`States` (`stateID`, `stateName`) VALUES (3, 'Madhya Pradesh');
INSERT INTO `mydb`.`States` (`stateID`, `stateName`) VALUES (4, 'Andhra Pradesh');
INSERT INTO `mydb`.`States` (`stateID`, `stateName`) VALUES (5, 'Rajasthan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Addressbook`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Addressbook` (`AddressID`, `User_userID`, `Name`, `Address`, `District`, `pinCode`, `mobileNumber`, `phoneNumber`, `States_stateID`) VALUES (1, 1, 'T P singh', 'demo address', 'Jaunpur', 222002, 9876543210, NULL, 1);
INSERT INTO `mydb`.`Addressbook` (`AddressID`, `User_userID`, `Name`, `Address`, `District`, `pinCode`, `mobileNumber`, `phoneNumber`, `States_stateID`) VALUES (2, 1, 'H p Singh', 'demo address', 'Lucknow', 221003, 9123456789, NULL, 1);
INSERT INTO `mydb`.`Addressbook` (`AddressID`, `User_userID`, `Name`, `Address`, `District`, `pinCode`, `mobileNumber`, `phoneNumber`, `States_stateID`) VALUES (3, 2, 'S P Singh', 'demo address', 'Varanasi', 212345, 9567891234, NULL, 1);
INSERT INTO `mydb`.`Addressbook` (`AddressID`, `User_userID`, `Name`, `Address`, `District`, `pinCode`, `mobileNumber`, `phoneNumber`, `States_stateID`) VALUES (4, 4, 'L P Singh', 'demo address', 'Ghazipur', 234789, 9543216789, NULL, 1);
INSERT INTO `mydb`.`Addressbook` (`AddressID`, `User_userID`, `Name`, `Address`, `District`, `pinCode`, `mobileNumber`, `phoneNumber`, `States_stateID`) VALUES (5, 5, 'Krait', 'demo address', 'Bhopal', 423325, 9123455432, NULL, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Orders` (`orderID`, `orderDate`, `User_userID`, `Addressbook_AddressID`, `Coupons_couponCode`) VALUES (1, '2013-10-28', 1, 2, NULL);
INSERT INTO `mydb`.`Orders` (`orderID`, `orderDate`, `User_userID`, `Addressbook_AddressID`, `Coupons_couponCode`) VALUES (2, '2013-10-28', 4, 4, NULL);
INSERT INTO `mydb`.`Orders` (`orderID`, `orderDate`, `User_userID`, `Addressbook_AddressID`, `Coupons_couponCode`) VALUES (3, '2013-10-28', 5, 5, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`OrderDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`OrderDetails` (`Orders_orderID`, `Products_productID`, `quantity`) VALUES (1, 1, 2);
INSERT INTO `mydb`.`OrderDetails` (`Orders_orderID`, `Products_productID`, `quantity`) VALUES (1, 3, 1);
INSERT INTO `mydb`.`OrderDetails` (`Orders_orderID`, `Products_productID`, `quantity`) VALUES (2, 4, 1);
INSERT INTO `mydb`.`OrderDetails` (`Orders_orderID`, `Products_productID`, `quantity`) VALUES (3, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`shippingCompany`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`shippingCompany` (`shippingCompanyID`, `shippingCompanyName`, `trackURL`) VALUES (1, 'BlueDart', 'http://www.bluedart.com/track?id=');
INSERT INTO `mydb`.`shippingCompany` (`shippingCompanyID`, `shippingCompanyName`, `trackURL`) VALUES (2, 'First Flight', 'http://www.firstflight.com/tracking/');
INSERT INTO `mydb`.`shippingCompany` (`shippingCompanyID`, `shippingCompanyName`, `trackURL`) VALUES (3, 'Aramex', 'http://www.aramex.com/pages/trackshipment/?track=');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`transactions`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`transactions` (`idtransactions`, `Orders_orderID`, `status`, `transactionTime`) VALUES ('1', 1, 1, '2013-10-28');
INSERT INTO `mydb`.`transactions` (`idtransactions`, `Orders_orderID`, `status`, `transactionTime`) VALUES ('2', 2, 1, '2013-10-28');
INSERT INTO `mydb`.`transactions` (`idtransactions`, `Orders_orderID`, `status`, `transactionTime`) VALUES ('3', 3, 0, '2013-10-28');
INSERT INTO `mydb`.`transactions` (`idtransactions`, `Orders_orderID`, `status`, `transactionTime`) VALUES ('4', 3, 1, '2013-10-28');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Wishlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Wishlist` (`User_userID`, `Products_productID`) VALUES (1, 2);
INSERT INTO `mydb`.`Wishlist` (`User_userID`, `Products_productID`) VALUES (1, 4);
INSERT INTO `mydb`.`Wishlist` (`User_userID`, `Products_productID`) VALUES (2, 1);
INSERT INTO `mydb`.`Wishlist` (`User_userID`, `Products_productID`) VALUES (2, 3);
INSERT INTO `mydb`.`Wishlist` (`User_userID`, `Products_productID`) VALUES (2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Messages`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Messages` (`messageID`, `User_userIDFrom`, `User_userIDTo`, `messageSubject`, `messsageContent`, `messageTime`) VALUES (1, 1, 3, 'product enquiry', 'How many days will it take to deliver the xperia SP to Jaunpur', '2013-11-10');
INSERT INTO `mydb`.`Messages` (`messageID`, `User_userIDFrom`, `User_userIDTo`, `messageSubject`, `messsageContent`, `messageTime`) VALUES (2, 3, 1, 're: product enquiry', 'Thx for checking our product. It might take us 10 days to deliver to your city.', '2013-11-10');

COMMIT;

