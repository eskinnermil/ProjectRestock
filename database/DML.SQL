--
-- Households Queries
--

-- READ/SELECT
SELECT Households.id_household AS id, name, address
FROM Households;

-- READ/SELECT for update household form
SELECT Households.id_household AS id, name, address
FROM Households
WHERE id_household = 
:id_household_selected_from_browse_households_page;

-- CREATE/INSERT
INSERT INTO Households (id, name, address)
VALUES (:idInput, :nameInput, :addressInput);

-- UPDATE
UPDATE Households
SET id = :idInput, name = :nameInput, address = :addressInput
WHERE id_household = 
:id_household_selected_from_browse_households_page;

-- DELETE
DELETE FROM Households
WHERE name = :nameInput;


--
-- Household Members Queries
--

-- READ/SELECT
SELECT Households_Members.id_household_member AS id, Households_Members.name AS name, Households_Members.runner_status AS 'runner status', Households.name AS household
FROM Households_Members
INNER JOIN Households ON Households_Members.id_household = Households.id_household;

-- READ/SELECT for update household form
SELECT Households_Members.name AS name, Households_Members.runner_status AS runner_status, Households.name AS household
FROM Households_Members
INNER JOIN Households ON Households_Members.id_household = Households.id_household
WHERE id_household_member = :id_household_member_selected_from_browse_Households_Members_page;

-- CREATE/INSERT
INSERT INTO Households_Members (name, runner_status, household)
VALUES (:nameInput, :runner_statusInput, :householdInput);

-- UPDATE
UPDATE Households_Members
SET name = :nameInput, runner_status = :runner_statusInput, household = :householdInput
WHERE id_household_member = :id_household_member_selected_from_browse_Households_Members_page;

-- DELETE
DELETE FROM Households_Members
WHERE name = :nameInput;


--
-- Household Inventories Queries
--

-- READ/SELECT
SELECT Households_Inventories.id_household_inventory AS id, Households.name AS household, Households_Items.name AS items, Households_Inventories.amount_left AS 'amount left', Households_Inventories.restock_status AS 'restock status'
FROM Households_Inventories
INNER JOIN Households ON Households.id_household = Households_Inventories.id_household
INNER JOIN Households_Items ON Households_Items.id_item = Households_Inventories.id_item
ORDER BY Households_Inventories.id_household_inventory ASC;

-- READ/SELECT for update household form
SELECT Households.name AS household, Households_Items.id_item AS items, amount_left, restock_status
FROM Households_Inventories
INNER JOIN Households ON Households.id_household = Households_Inventories.id_household
INNER JOIN Households_Items ON Households_Items.id_item = Households_Inventories.id_item
WHERE id_household_inventory = :id_household_inventory_selected_from_browse_household_inventory_page;

-- CREATE/INSERT
INSERT INTO Households_Inventories (household, items, amount_left, restock_status)
VALUES (:householdInput, :itemsInput, :amount_leftInput, :restock_statusInput);

-- UPDATE
UPDATE Households_Inventories
SET household = :householdInput, items = :itemsInput, amount_left = :amount_leftInput, restock_status = :restock_statusInput)
WHERE id_household_inventory = :id_household_inventory_selected_from_browse_household_inventory_page;

-- DELETE
DELETE FROM Households_Inventories
WHERE id_household_inventory = :householdInput;


--
-- Household Items Queries
--

-- READ/SELECT
SELECT Households_Items.id_item AS id, Items_Types.name AS type, Households_Items.name AS name, Households_Items.best_if_used_by AS "best if used by"
FROM Households_Items
INNER JOIN Items_Types ON Items_Types.id_item_type = Households_Items.id_item_type;

-- CREATE/INSERT
INSERT INTO Households_Items (id, type, name, best_if_used_by)
VALUES (:idInput, :typeInput, :nameInput, :best_if_used_byInput);


--
-- Item Types Queries
--

-- READ/SELECT
SELECT Items_Types.id_item_type AS id, Items_Types.name AS name FROM Items_Types;

-- CREATE/INSERT
INSERT INTO Items_Types (id_item_type, name)
VALUES (:id_item_typeInput, :nameInput);


--
-- Store Inventories Queries
--

-- READ/SELECT
SELECT Items_Types.name AS 'item types', Stores.name AS stores
FROM Stores_Inventories
INNER JOIN Items_Types ON Items_Types.id_item_type = Stores_Inventories.id_item_type
INNER JOIN Stores ON Stores.id_store = Stores_Inventories.id_store;

-- CREATE/INSERT
INSERT INTO Stores_Inventories (types, stores)
VALUES (:typesInput, :storesInput);


--
-- Stores Queries
--

-- READ/SELECT
SELECT Stores.id_store AS id, Stores.name AS name, Stores.address AS address, Stores.hours_open AS 'hours open' FROM Stores;

-- READ/SELECT for update household form
SELECT name, address, hours_open
FROM Stores
WHERE id_store = :id_store_selected_from_browse_stores_page;

-- CREATE/INSERT
INSERT INTO Stores (name, address, hours_open)
VALUES (:nameInput,:addressInput, :hours_openInput);

-- UPDATE
UPDATE Stores
SET name = :nameInput, address = :addressInput, hours_open = :hours_openInput)
WHERE id_store = :id_store_selected_from_browse_stores_page;

-- DELETE
DELETE FROM Stores
WHERE id_store = :id_store_selected_from_browse_stores_page;
