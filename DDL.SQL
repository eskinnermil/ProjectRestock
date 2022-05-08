SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLES IF EXISTS Households, Household_Members, Household_Inventories, Household_Items, Item_Types, Store_Inventories, Stores;
--
-- Table structure for table `Households`
--
CREATE TABLE IF NOT EXISTS `Households` (
  `id_household` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` varchar(145) NOT NULL,
  PRIMARY KEY (`id_household`)
);

--
-- Table structure for table `Household_Members`
--
CREATE TABLE IF NOT EXISTS `Household_Members` (
  `id_householdMember` int(11) NOT NULL AUTO_INCREMENT,
  `id_household` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `runner_status` TINYINT NOT NULL,
  PRIMARY KEY (`id_householdMember`),
  FOREIGN KEY (`id_household`) REFERENCES Households(`id_household`) ON DELETE NO ACTION
);

--
-- Table structure for table `Household_Inventories`
--
CREATE TABLE IF NOT EXISTS `Household_Inventories` (
  `id_householdInventory` int(11) NOT NULL AUTO_INCREMENT,
  `id_household` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `amount_left` varchar(45) NOT NULL,
  `restock_status` TINYINT NOT NULL,
  PRIMARY KEY (`id_householdInventory`),
  FOREIGN KEY (`id_household`) REFERENCES Households(`id_household`) ON DELETE NO ACTION,
  FOREIGN KEY (`id_item`) REFERENCES Household_Items(`id_item`) ON DELETE NO ACTION
);

--
-- Table structure for table `Household_Items`
--
CREATE TABLE IF NOT EXISTS `Household_Items` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `id_itemType` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `best_if_used_by` DATE NOT NULL,
  PRIMARY KEY (`id_item`),
  FOREIGN KEY (`id_itemType`) REFERENCES Item_Types(`id_itemType`) ON DELETE NO ACTION
);

--
-- Table structure for table `Item_Types`
--
CREATE TABLE IF NOT EXISTS `Item_Types` (
  `id_itemType` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_itemType`)
);

--
-- Table structure for table `Store_Inventories`
--
CREATE TABLE IF NOT EXISTS `Store_Inventories` (
  `id_itemType` int(11) NOT NULL,
  `id_store` int(11) NOT NULL,
  PRIMARY KEY (`id_itemType`, `id_store`)
);

--
-- Table structure for table `Stores`
--
CREATE TABLE IF NOT EXISTS `Stores` (
  `id_store` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` varchar(145) NOT NULL,
  `hours_open` varchar(45) NOT NULL,
  PRIMARY KEY (`id_store`)
);


--
-- Data Insert into table `Households`
--
INSERT INTO Households(name, address)
VALUES ('Family', '101 Zip Blvd, New York City, New York, USA, 10010'),
    ('Couple', '102 Zip Blvd, Los Angeles, California, USA, 90210'),
    ('Roommates', '103 Zip Blvd, Chicago, Illinois, USA, 60018');
--
-- Data Insert into table `Item_Types`
--
INSERT INTO Item_Types(name)
VALUES ('Toiletries'),
    ('Cleaning Supplies'),
    ('Groceries'),
    ('Pharmacy'),
    ('Pet Supplies'),
    ('Gardening');
--
-- Data Insert into table `Stores`
--
INSERT INTO Stores(name, address, hours_open)
VALUES ('Amazonian', '101 Tesla Drive, Richland Hills, Texas, USA, 75890', '12am to 3am'),
    ('Home Depot', '123 Alphabet Rd, Someplace City, Texas, USA, 75891', '6am to 10am'),
    ('Get Tar', '10101 TopDown Ave, Psuedocode Woods, Texas, USA, 75892', '9am to 5pm'),
    ('Wallys Greens', '01010 BottomUp Blvd, Arrayville, Texas, USA, 75893', '2pm to 8pm; 10pm to 2am'),
    ('Costing Cocos', '2222 Dynamic St, Planning Valley, Texas, USA, 75894', 'Closed permanently'),
    ('Smartest Pets', '678 Backtracking Ln, Recursionton, Texas, USA, 75895', 'Open 24 hours');
--
-- Data Insert into table `Household_Members`
--
INSERT INTO Household_Members(id_household, name, runner_status)
VALUES ((select id_Household from Households where name="Family"), 'Jane Doe', 1),
    ((select id_Household from Households where name="Family"), 'John Doe', 0),
    ((select id_Household from Households where name="Family"), 'Son Doe', 0),
    ((select id_Household from Households where name="Family"), 'Daughter Doe', 0),
    ((select id_Household from Households where name="Couple"), 'Maureen Lady', 1),
    ((select id_Household from Households where name="Couple"), 'Barbara Waddingham', 0),
    ((select id_Household from Households where name="Roommates"), 'Nathaniel Archibald', 1),
    ((select id_Household from Households where name="Roommates"), 'Alex Lyndell', 0),
    ((select id_Household from Households where name="Roommates"), 'Sasha Grace', 0);
--
-- Data Insert into table `Household_Items`
--
INSERT INTO Household_Items(name, id_itemType, best_if_used_by)
VALUES ('Toilet Paper', (select id_itemType from Item_Types where name="Toiletries"), "2022-11-26"),
    ('Toothpaste', (select id_itemType from Item_Types where name="Toiletries"), "2022-12-31"),
    ('Shampoo', (select id_itemType from Item_Types where name="Toiletries"), "2024-04-11"),
    ('Milk', (select id_itemType from Item_Types where name="Groceries"), "2022-05-07"),
    ('Coffee Beans', (select id_itemType from Item_Types where name="Groceries"), "2028-10-10"),
    ('Bananas', (select id_itemType from Item_Types where name="Groceries"), "2022-05-02"),
    ('Yogurt', (select id_itemType from Item_Types where name="Groceries"), "2022-05-12"),
    ('Dog Food', (select id_itemType from Item_Types where name="Pet Supplies"), "2022-07-15"),
    ('Doggy Bags', (select id_itemType from Item_Types where name="Pet Supplies"), "2029-02-25"),
    ('Paw Wipes', (select id_itemType from Item_Types where name="Pet Supplies"), "2021-08-17"),
    ('Chlorox', (select id_itemType from Item_Types where name="Cleaning Supplies"), "2014-06-05"),
    ('Windex', (select id_itemType from Item_Types where name="Cleaning Supplies"), "2018-12-12"),
    ('Laundry Detergent', (select id_itemType from Item_Types where name="Cleaning Supplies"), "2022-03-15"),
    ('Advil', (select id_itemType from Item_Types where name="Pharmacy"), "2023-01-30"),
    ('Bandaids', (select id_itemType from Item_Types where name="Pharmacy"), "2026-11-09"),
    ('Fertilizer', (select id_itemType from Item_Types where name="Gardening"), "2027-07-01"),
    ('Pesticide', (select id_itemType from Item_Types where name="Gardening"), "2022-03-30");
--
-- Data Insert into table `Household_Inventories`
--
INSERT INTO Household_Inventories(id_household, id_item, amount_left, restock_status)
VALUES ((select id_Household from Households where name="Family"), (select id_item from Household_Items where name="Fertilizer"), 'Empty', 1),
    ((select id_Household from Households where name="Family"), (select id_item from Household_Items where name="Toothpaste"), 'Fully Stocked', 0),
    ((select id_Household from Households where name="Family"), (select id_item from Household_Items where name="Windex"), 'Empty', 1),
    ((select id_Household from Households where name="Family"), (select id_item from Household_Items where name="Bandaids"), 'Empty', 1),
    ((select id_Household from Households where name="Family"), (select id_item from Household_Items where name="Paw Wipes"), 'Running Low', 1),
    ((select id_Household from Households where name="Couple"), (select id_item from Household_Items where name="Shampoo"), 'Still Plenty', 0),
    ((select id_Household from Households where name="Couple"), (select id_item from Household_Items where name="Yogurt"), 'Running Low', 1),
    ((select id_Household from Households where name="Couple"), (select id_item from Household_Items where name="Dog Food"), 'Empty', 1),
    ((select id_Household from Households where name="Roommates"), (select id_item from Household_Items where name="Milk"), 'Still Plenty', 0),
    ((select id_Household from Households where name="Roommates"), (select id_item from Household_Items where name="Detergent"), 'Running Low', 1),
    ((select id_Household from Households where name="Roommates"), (select id_item from Household_Items where name="Coffee Beans"), 'Empty', 1),
    ((select id_Household from Households where name="Roommates"), (select id_item from Household_Items where name="Toilet Paper"), 'Empty', 1);
--
-- Data Insert into table `Store_Inventories`
--
INSERT INTO Store_Inventories(id_itemType, id_store)
VALUES ((select id_itemType from Item_Types where name="Toiletries"), (select id_store from Stores where name="Amazonian")),
    ((select id_itemType from Item_Types where name="Toiletries"), (select id_store from Stores where name="Get Tar")),
    ((select id_itemType from Item_Types where name="Cleaning Supplies"), (select id_store from Stores where name="Get Tar")),
    ((select id_itemType from Item_Types where name="Groceries"), (select id_store from Stores where name="Get Tar")),
    ((select id_itemType from Item_Types where name="Groceries"), (select id_store from Stores where name="Costing Cocos")),
    ((select id_itemType from Item_Types where name="Pharmacy"), (select id_store from Stores where name="Wallys Greens")),
    ((select id_itemType from Item_Types where name="Pet Supplies"), (select id_store from Stores where name="Smartest Pets")),
    ((select id_itemType from Item_Types where name="Gardening"), (select id_store from Stores where name="Home Depot"));

SET FOREIGN_KEY_CHECKS=1;
COMMIT;