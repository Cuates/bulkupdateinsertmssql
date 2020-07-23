use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- =======================
--        File: TableName
--     Created: 07/23/2020
--     Updated: 07/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Table name
-- =======================
create table [dbo].[TableName](
  [columnOne] [nvarchar](50) not null,
  [columnTwo] [nvarchar](50) not null,
  [columnThree] [nvarchar](50) not null,
  [columnFour] [nvarchar](50) not null,
  [columnFive] [nvarchar](50) null,
  [columnSix] [datetime2](7) not null,
  [columnSeven] [nvarchar](50) not null,
  [columnEight] [nvarchar](50) not null,
  [columnNine] [nvarchar](50) not null,
  [columnTen] [float] not null,
  [columnEleven] [float] null,
  [created_date] [datetime2](7) null,
  [modified_date] [datetime2](7) null
) on [PRIMARY]
go

alter table [dbo].[TableName] add  default (getdate()) for [created_date]
go

alter table [dbo].[TableName] add  default (getdate()) for [modified_date]
go