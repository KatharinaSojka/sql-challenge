# sql-challenge

Hi, in the sql-challenge repository you will find a folder "STarter Code" that contains all the csv files.
Folder EmployeeSQL contains a ERD diagram of my DB, initial schema and the final sql Data_analysis_employee file. This one contains final script for database creation and Data Analysis query.

I have encountered a problem when importing employee file. Dates (Birth date and hire date, were given in a format not accepted by postgres) The only solution that I  have found was to import those colums into new columns (type varchar) and then convert them into proper data type.
My script reflects those steps.

Thanks 

Katharina
