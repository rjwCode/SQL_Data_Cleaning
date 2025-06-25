--================================================
--Queries to Clean Data in the HousingData Dataset
--================================================


--============================
--STEP ONE: Modify Date Format
--============================
ALTER TABLE HousingData
ALTER COLUMN SaleDate DATE

SELECT 
	SaleDate --SaleDate is now a DATE, not DATETIME
FROM 
	HousingData



--============================================================
--STEP TWO: Populate Previously Null Values in PropertyAddress
--============================================================
SELECT
	hd1.ParcelID,
	hd1.PropertyAddress,
	hd2.ParcelID,
	hd2.PropertyAddress,
	ISNULL(hd1.PropertyAddress, hd2.PropertyAddress) --Populates NULL value with address from previous record
FROM
	HousingData AS hd1
JOIN
	HousingData AS hd2
	ON hd1.ParcelID = hd2.ParcelID
	AND hd1.[UniqueID ]  <> hd2.[UniqueID ]
WHERE hd1.PropertyAddress IS NULL

UPDATE hd1
SET PropertyAddress = ISNULL(hd1.PropertyAddress, hd2.PropertyAddress)
FROM HousingData AS hd1
JOIN HousingData AS hd2
	ON hd1.ParcelID = hd2.ParcelID
	AND hd1.[UniqueID ] <> hd2.[UniqueID ]
WHERE hd1.PropertyAddress IS NULL

SELECT PropertyAddress --NULL values are now properly transformed
FROM HousingData



--===============================================================
--STEP THREE: Splitting PropertyAddress into the Address and City
--===============================================================
SELECT
	SUBSTRING(PropertyAddress, 0, CHARINDEX(',', PropertyAddress)) AS PropertySplitAddress,
	TRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))) AS PropertyCity
FROM
	HousingData

ALTER TABLE HousingData --Adding new column for the address
ADD PropertySplitAddress Nvarchar(255);

UPDATE HousingData --Setting new address column to be a substring from PropertyAddress
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 0, CHARINDEX(',', PropertyAddress))

ALTER TABLE HousingData --Adding new column for the city of the property
ADD PropertyCity Nvarchar(255);

UPDATE HousingData --Setting new city column to be another substring from PropertyAddress
SET PropertyCity = TRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)))

SELECT --Display the newly added columns
	PropertySplitAddress,
	PropertyCity
FROM
	HousingData



--===================================================================
--STEP FOUR: Splitting OwnerAddress into the Address, City, and State
--===================================================================
SELECT
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress, --Parse out the address
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerCity, --Parse out the city
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerState --Parse out the state
FROM
	HousingData

ALTER TABLE HousingData --Creating New Columns for address, city, and state of the owner
ADD OwnerSplitAddress Nvarchar(255)

ALTER TABLE HousingData
ADD OwnerCity Nvarchar(255)

ALTER TABLE HousingData
ADD OwnerState Nvarchar(255)

UPDATE HousingData --Updating each new column to the appropriate values
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

UPDATE HousingData
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE HousingData
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT --Display new columns from the original OwnerAddress column
	OwnerSplitAddress,
	OwnerCity,
	OwnerState
FROM
	HousingData



--============================================================================================================
--STEP FIVE: Modify SoldAsVacant to format values as either "Yes" or "No"; Some values were originally Y and N
--============================================================================================================
UPDATE HousingData
SET SoldAsVacant =
	CASE 
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END

SELECT DISTINCT SoldAsVacant --Shows that the only values are now 'Yes' and 'No'
FROM HousingData



--===========================
--STEP SIX: Remove Duplicates
--===========================
WITH RowNumCTE AS(
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
						  ORDER BY UniqueID) row_num
	FROM
		HousingData
)
DELETE --Remove duplicates from the table
FROM
	RowNumCTE
WHERE 
	row_num > 1



--==========================================================================
--STEP SEVEN: Using TRIM() to remove potential whitespaces in certain fields
--==========================================================================
UPDATE HousingData
SET PropertySplitAddress = TRIM(PropertySplitAddress),
	PropertyCity = TRIM(PropertyCity),
	OwnerSplitAddress = TRIM(OwnerSplitAddress),
	OwnerCity = TRIM(OwnerCity),
	OwnerState = TRIM(OwnerState);



--==================================================================================
--STEP EIGHT: Enfore upper case formatting for the OwnerCity and PropertyCity fields
--==================================================================================
UPDATE HousingData
SET OwnerCity = UPPER(OwnerCity),
	PropertyCity = UPPER(PropertyCity);



--===============================================
--STEP NINE: Removing rows with many NULL columns
--===============================================
DELETE FROM HousingData
WHERE
	OwnerName IS NULL AND
	Acreage is NULL AND
	LandValue IS NULL AND
	BuildingValue IS NULL AND
	TotalValue IS NULL AND
	YearBuilt IS NULL AND
	Bedrooms IS NULL AND
	FullBath IS NULL AND 
	HalfBath IS NULL;




--================================================
--STEP TEN: Removing Columns that are not needed
--================================================
ALTER TABLE HousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress



--=====================================================
--STEP ELEVEN: Creating a backup table for cleaned data
--=====================================================
SELECT *
INTO HousingData_Cleaned
FROM HousingData;


