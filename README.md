# bulkupdateinsertmssql
> Microsoft SQL Server project which utilizes a stored procedure to bulk update and bulk insert records

## Table of Contents
* [Version](#version)
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Usage](#usage)

### Version
* 0.0.1

### **Important Note**
* This project was written with SQL Server 2012 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Prerequisite Data Types
* nvarchar
* smallint
* datetime2
* float

### Prerequisite Functions
* nullif
* ltrim
* rtrim
* cast
* getdate
* error_number
* error_line
* error_message

### Prerequisite Conditions
* left join

### Usage
* `dbo.bulkUpdateInsert @optionMode = 'bulkUpdate'`
* `dbo.bulkUpdateInsert @optionMode = 'bulkInsert'`
