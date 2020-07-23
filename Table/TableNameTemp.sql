use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- ============================
--        File: TableNameTemp
--     Created: 07/23/2020
--     Updated: 07/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Table name temp
-- ============================
create table [dbo].[TableNameTemp](
  [columnOne] [nvarchar](2000) null,
  [columnTwo] [nvarchar](2000) null,
  [columnThree] [nvarchar](2000) null,
  [columnFour] [nvarchar](2000) null,
  [columnFive] [nvarchar](2000) null,
  [columnSix] [nvarchar](2000) null,
  [columnSeven] [nvarchar](2000) null,
  [columnEight] [nvarchar](2000) null,
  [columnNine] [nvarchar](2000) null,
  [columnTen] [nvarchar](2000) null,
  [columnEleven] [nvarchar](2000) null,
  [created_date] [datetime2](7) null
) on [PRIMARY]
go

alter table [dbo].[TableNameTemp] add  default (getdate()) for [created_date]
go