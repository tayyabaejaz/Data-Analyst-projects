-- CLEANING DATA IN SQL  

SELECT * FROM portfolio.`nashville housing data`;

-- STANDARDIZE The sale date Column:

SELECT SaleDate,CONVERT(SaleDate,date) FROM portfolio.`nashville housing data`;

-- POPULATE property address

SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM portfolio.`nashville housing data` a
JOIN portfolio.`nashville housing data` b
 on a.ParcelID=b.ParcelID
 and a.UniqueID <> b.UniqueID
 where a.PropertyAddress ='';
 
update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM portfolio.`nashville housing data` a
JOIN portfolio.`nashville housing data` b
 on a.ParcelID=b.ParcelID
 and a.UniqueID <> b.UniqueID
 where a.PropertyAddress ='';
 
-- Breaking the address into individual columns
SELECT substring(PropertyAddress,1,LOCATE(',',PropertyAddress)-1)as Address,
substring(PropertyAddress,LOCATE(',',PropertyAddress)+1,length(PropertyAddress)) as Address
FROM portfolio.`nashville housing data` ;

ALTER TABLE portfolio.`nashville housing data`
add propertySplitAddress varchar(255) ;

update portfolio.`nashville housing data`
set propertySplitAddress=substring(PropertyAddress,1,LOCATE(',',PropertyAddress)-1);

ALTER TABLE portfolio.`nashville housing data`
add propertySplitCity  varchar(255);

update portfolio.`nashville housing data`
set propertySplitCity=substring(PropertyAddress,LOCATE(',',PropertyAddress)+1,length(PropertyAddress));

-- For owner Address(using different method)
SELECT OwnerAddress FROM portfolio.`nashville housing data`;

SELECT
	TRIM(SUBSTRING_INDEX(OwnerAddress , ',', 1)) AS street_address,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress , ',', -2), ',', 1)) AS city,
    TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1)) AS state
FROM portfolio.`nashville housing data`;


ALTER TABLE portfolio.`nashville housing data`
add OwnerAddressSplit  varchar(255);

update portfolio.`nashville housing data`
set OwnerAddressSplit  =TRIM(SUBSTRING_INDEX(OwnerAddress , ',', 1));

ALTER TABLE portfolio.`nashville housing data`
add OwnerAddressSplitCity  varchar(255);

update portfolio.`nashville housing data`
set OwnerAddressSplitCity   = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress , ',', -2), ',', 1));

ALTER TABLE portfolio.`nashville housing data`
add OwnerAddressSplitState  varchar(255);

update portfolio.`nashville housing data`
set OwnerAddressSplitState   = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));

-- changing Y and N to Yes and No in soldasVacant
SELECT SoldAsVacant FROM portfolio.`nashville housing data`;
SELECT distinct(SoldAsVacant),Count(SoldAsVacant)
FROM portfolio.`nashville housing data`
group by SoldAsVacant;


select SoldAsVacant 
,CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'no'
else SoldAsVacant
end
FROM portfolio.`nashville housing data`;

update portfolio.`nashville housing data`
set SoldAsVacant =CASE when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'no'
else SoldAsVacant
end;

-- Removing unused data columns
select *
 from portfolio.`nashville housing data`;
 
ALTER TABLE portfolio.`nashville housing data`
DROP COLUMN OwnerAddress;
 
ALTER TABLE portfolio.`nashville housing data`
DROP COLUMN TaxDistrict;

ALTER TABLE portfolio.`nashville housing data`
DROP COLUMN PropertyAddress;
