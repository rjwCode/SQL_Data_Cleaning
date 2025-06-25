# SQL_Data_Cleaning
Cleaning Data Within a Housing Information Dataset Using SQL
Data Cleaning with SQL -- GitHub
In this project, I utilized an Excel dataset with information about various properties. In the image below, you can see what the original uncleaned dataset looked like.


original dataset before cleaning
Fig. 1. Original Dataset

The initial step of my data cleaning process was to observe the data to find what adjustments needed to be made. Various qualities of the data jumped out to me, such as the PropertyAddress field, which could be better analyzed if separated into multiple columns. Other observations included the presence of various NULL values, the formatting for DATE fields, formatting for the SoldAsVacant field, and duplicate data.

Step 1: Modify DATE Formatting


In this step, the SaleDate column was modified to be a DATE field, rather than a DATETIME. The SQL Code for this step is displayed in figure 2.
Modifying the SaleDate column to a DATE field
Fig. 2. Setting SaleData as a DATE Field


Step 2: Populate NULL Values in PropertyAddress


In addition to NULL values, I observed that this column contained consecutive rows for the same property. Thus, to solve the presence of NULL values, I utilized the address value from the next row for the same property to replace them. This can be observed in the SQL code shown in figure 3.
Replacing NULL PropertyAddress values
Fig. 3. Replacing NULL PropertyAddress Values


Step 3: Splitting PropertyAddress Into Address and City


After handling NULL values for the PropertyAddress field, the data now should be modified further for ease of analysis. In order to do this, PropertyAddress was split into two new columns, PropertySplitAddress and PropertyCity. This process is demonstrated in figure 4.
Splitting PropertyAddress into PropertySplitAddress and PropertyCity
Fig. 4. Splitting PropertyAddress into Address and City


Step 4: Splitting OwnerAddress into the Address, City, and State


The OwnerAddress column is also in need of some refactoring. In this case, the OwnerAddress column was split into three columns: OwnerSplitAddress, OwnerCity, and OwnerState. The SQL code used for this is displayed in figure 5.
Splitting OwnerAddress into OwnerSplitAddress, OwnerCity, and OwnerState
Fig. 5. Splitting OwnerAddress into Address, City, and State


Step 5: Reformat SoldAsVacant Values


Moving on from splitting columns, I observed that the values for SoldAsVacant initially had four variants: 'Y', 'Yes', 'N', and 'No'. To make the values for this column more neatly organized, the values 'Y' and 'N' will be reformatted to 'Yes' and 'No' respectively. This process is displayed in figure 6.
Reformatting SoldAsVacant values to 'Yes' and 'No'
Fig. 6. Reormatting SoldAsVacant Values


Step 6: Removing Duplicate Values


In this step, duplicate values in the dataset will be handled. The method chosen for this process was to utilize ROW_NUMBER() and partitions to find rows with duplicate values for specific fields. This process is demonstrated in figure 7
Removing Duplicates
Fig. 7. Removing Duplicate Values


Step 7: Whitespace Removal


After handling duplicate values, the next step taken was to handle possible whitespace in various fields. As shown in figure 8, the chosen method to handle whitespcae was TRIM().
Removing Whitespace
Fig. 8. Removing Whitespace


Step 8: Value Formatting


Next, to ensure that the formatting is clear and consistent for the OwnerCity and PropertyCity fields, they will be set to upper case. This was done using the UPPER() function, with the SQL code displayed in figure 9.
Upper Case Formatting
Fig. 9. Upper Case Formatting


Step 9: Handling Rows with Many NULL Values


Within the dataset, it was also observed that various records had NULL values for the same columns. In order to make the data easier to analyze, rows that met this criterion were removed. The original rows with many NULL values are shown in figure 10, and the process used to remove them is displayed in figure 11.
Rows with Many NULLs
Fig. 10. Rows with Many NULL Values

Removing Rows with Many NULLs
Fig. 11. Removing Rows with Many NULL Values


Step 10: Removing Non-essential Columns


Additionally, some columns within this dataset were deemed to be non-essential for any analysis processes. These columns (OwnerAddress, TaxDistrict, and PropertyAddress) were removed, as displayed in figure 12.
Removing Non-essential Columns
Fig. 12. Removing Non-essential Columns


Step 11: Creating a Backup Table for Cleaned Data


Creating a Backup Table for Cleaned Data
Fig. 13. Creating a Table for Cleaned Data

Finally, after completing all of the previous data cleaning processes, a backup table was created to store the now cleaned data. This was accomplished through the use of the INTO clause in SQL, as demonstrated in figure 13.
