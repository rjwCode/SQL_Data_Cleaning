# SQL_Data_Cleaning: Cleaning Data Within a Housing Information Dataset Using SQL

***
#### Tools Used: SQL, Excel, SQL Server Management Studio, SQL Server
***

In this project, I utilized an Excel dataset with information about various properties. In the image below, you can see what the original uncleaned dataset looked like.
<br><br>
![original_dataset](https://github.com/user-attachments/assets/1754f132-9511-4059-8577-f649b13c3d59)
Fig. 1. Original Dataset
<br><br>
The initial step of my data cleaning process was to observe the data to find what adjustments needed to be made. Various qualities of the data jumped out to me, such as the PropertyAddress field, which could be better analyzed if separated into multiple columns. Other observations included the presence of various NULL values, the formatting for DATE fields, formatting for the SoldAsVacant field, and duplicate data.


## Step 1: Modify DATE Formatting


In this step, the SaleDate column was modified to be a DATE field, rather than a DATETIME. The SQL Code for this step is displayed in figure 2.

<br><br>
![data_cleaning_sql_step_1](https://github.com/user-attachments/assets/de1bedfd-1fd2-4953-ba0b-66a6d25a1edd)

Fig. 2. Setting SaleData as a DATE Field
<br><br>
## Step 2: Populate NULL Values in PropertyAddress


In addition to NULL values, I observed that this column contained consecutive rows for the same property. Thus, to solve the presence of NULL values, I utilized the address value from the next row for the same property to replace them. This can be observed in the SQL code shown in figure 3.

<br><br>
![data_cleaning_sql_step_2](https://github.com/user-attachments/assets/23f8ba86-dbdc-4da6-a2e7-575fee7617af)

Fig. 3. Replacing NULL PropertyAddress Values
<br><br>
## Step 3: Splitting PropertyAddress Into Address and City


After handling NULL values for the PropertyAddress field, the data now should be modified further for ease of analysis. In order to do this, PropertyAddress was split into two new columns, PropertySplitAddress and PropertyCity. This process is demonstrated in figure 4.

<br><br>
![data_cleaning_sql_step_3](https://github.com/user-attachments/assets/6e3ad532-4bb1-4945-b3dc-838e4a1298de)

Fig. 4. Splitting PropertyAddress into Address and City
<br><br>

## Step 4: Splitting OwnerAddress into the Address, City, and State


The OwnerAddress column is also in need of some refactoring. In this case, the OwnerAddress column was split into three columns: OwnerSplitAddress, OwnerCity, and OwnerState. The SQL code used for this is displayed in figure 5.

<br><br>
![data_cleaning_sql_step_4](https://github.com/user-attachments/assets/6eace568-7c82-4a42-b8a7-5ba87c84116f)

Fig. 5. Splitting OwnerAddress into Address, City, and State
<br><br>

## Step 5: Reformat SoldAsVacant Values


Moving on from splitting columns, I observed that the values for SoldAsVacant initially had four variants: 'Y', 'Yes', 'N', and 'No'. To make the values for this column more neatly organized, the values 'Y' and 'N' will be reformatted to 'Yes' and 'No' respectively. This process is displayed in figure 6.
<br><br>
![data_cleaning_sql_step_5](https://github.com/user-attachments/assets/965864a7-a48c-497d-84ff-07f18d7078a3)

Fig. 6. Reformatting SoldAsVacant Values
<br><br>

## Step 6: Removing Duplicate Values


In this step, duplicate values in the dataset will be handled. The method chosen for this process was to utilize ROW_NUMBER() and partitions to find rows with duplicate values for specific fields. This process is demonstrated in figure 7
<br><br>
![data_cleaning_sql_step_6](https://github.com/user-attachments/assets/003ee498-4a40-4c31-b5e1-841d225b6d73)

Fig. 7. Removing Duplicate Values
<br><br>

## Step 7: Whitespace Removal


After handling duplicate values, the next step taken was to handle possible whitespace in various fields. As shown in figure 8, the chosen method to handle whitespcae was TRIM().
<br><br>
![data_cleaning_sql_step_7](https://github.com/user-attachments/assets/e511a306-d753-404f-ae36-8fb49f2f38d0)

Fig. 8. Removing Whitespace
<br><br>

## Step 8: Value Formatting



Next, to ensure that the formatting is clear and consistent for the OwnerCity and PropertyCity fields, they will be set to upper case. This was done using the UPPER() function, with the SQL code displayed in figure 9.
<br><br>
![data_cleaning_sql_step_8](https://github.com/user-attachments/assets/45993b10-0227-41aa-a6d1-49aeaddabcdc)

Fig. 9. Upper Case Formatting
<br><br>

## Step 9: Handling Rows with Many NULL Values


Within the dataset, it was also observed that various records had NULL values for the same columns. In order to make the data easier to analyze, rows that met this criterion were removed. The original rows with many NULL values are shown in figure 10, and the process used to remove them is displayed in figure 11.
<br><br>
![data_cleaning_sql_step_9_1](https://github.com/user-attachments/assets/ecad599c-1cfa-4d71-98f8-8b398df701b7)

Fig. 10. Rows with Many NULL Values
<br><br>
![data_cleaning_sql_step_9_2](https://github.com/user-attachments/assets/ef4b9478-d167-491c-a618-a27c1fc4e489)

Fig. 11. Removing Rows with Many NULL Values
<br><br>

## Step 10: Removing Non-essential Columns


Additionally, some columns within this dataset were deemed to be non-essential for any analysis processes. These columns (OwnerAddress, TaxDistrict, and PropertyAddress) were removed, as displayed in figure 12.
<br><br>
![data_cleaning_sql_step_10](https://github.com/user-attachments/assets/3e10f207-bb61-4fa2-972e-0976804adbdc)

Fig. 12. Removing Non-essential Columns
<br><br>

## Step 11: Creating a Backup Table for Cleaned Data

Finally, after completing all of the previous data cleaning processes, a backup table was created to store the now cleaned data. This was accomplished through the use of the INTO clause in SQL, as demonstrated in figure 13.
<br><br>
![data_cleaning_sql_step_11](https://github.com/user-attachments/assets/2d6de1b0-ddff-42e7-8619-aecdabae3fde)

Fig. 13. Creating a Table for Cleaned Data
<br><br>
