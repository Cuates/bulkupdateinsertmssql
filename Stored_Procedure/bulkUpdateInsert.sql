use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- ===============================
--        File: bulkUpdateInsert
--     Created: 07/23/2020
--     Updated: 07/29/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Bulk update insert
-- ===============================
create procedure [dbo].[bulkUpdateInsert]
  -- Parameters
  @optionMode nvarchar(255)
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @attempts as smallint

  -- Set variables
  set @attempts = 1

  -- Omit characters
  set @optionMode = ltrim(rtrim(dbo.OmitCharacters(@optionMode, '65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')))

  -- Check if empty string
  if @optionMode = ''
    begin
      -- Set parameter to null if empty string
      set @optionMode = nullif(@optionMode, '')
    end

  -- Check if option mode is update records
  else if @optionMode = 'updateRecords'
    begin
      ---- Set XAct Abort On
      --set xact_abort on

      -- Loop until condition is met
      while @attempts <= 5
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Update records
              update tn
              set
              tn.columnOne = ltrim(rtrim(tnt.columnOne)),
              tn.columnTwo = ltrim(rtrim(tnt.columnTwo)),
              tn.columnThree = ltrim(rtrim(tnt.columnThree)),
              tn.columnFour = ltrim(rtrim(tnt.columnFour)),
              tn.columnFive = iif(ltrim(rtrim(tnt.columnFive)) = '', null, ltrim(rtrim(tnt.columnFive))),
              tn.columnSix = cast(tnt.columnSix as datetime2(7)),
              tn.columnSeven = ltrim(rtrim(tnt.columnSeven)),
              tn.columnEight = ltrim(rtrim(tnt.columnEight)),
              tn.columnNine = ltrim(rtrim(tnt.columnNine)),
              tn.columnTen = cast(tnt.columnTen as float),
              tn.columnEleven = iif(ltrim(rtrim(tnt.columnEleven)) = '', null, cast(tnt.columnEleven as float)),
              tn.modified_date = getdate()
              from dbo.TableNameTemp tnt
              left join dbo.TableName tn on tn.columnOne = tnt.columnOne
              where
              (
                ltrim(rtrim(tnt.columnOne)) <> '' and
                ltrim(rtrim(tnt.columnTwo)) <> '' and
                ltrim(rtrim(tnt.columnThree)) <> '' and
                ltrim(rtrim(tnt.columnFour)) <> '' and
                ltrim(rtrim(tnt.columnSix)) <> '' and
                ltrim(rtrim(tnt.columnSeven)) <> '' and
                ltrim(rtrim(tnt.columnEight)) <> '' and
                ltrim(rtrim(tnt.columnNine)) <> '' and
                ltrim(rtrim(tnt.columnTen)) <> ''
              ) and
              tn.columnOne is not null

              -- Select message
              select
              'Success~Record(s) updated' as [Status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end

              -- Break out of the loop
              break
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Only display an error message if it is on the final attempt of the execution
              if @attempts = 5
                begin
                  -- Select error number, line, and message
                  select 'Error~updateRecords: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                end

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end

              -- Increments the loop control for attempts
              set @attempts = @attempts + 1

              -- Wait for delay for x amount of time
              waitfor delay '00:00:04'

              -- Continue the loop
              continue
            end catch
            -- End catch block
        end

      ---- Set XAct Abort Off
      --set xact_abort off
    end

  -- Else check if option mode is insert records
  else if @optionMode = 'insertRecords'
    begin
      ---- Set XAct Abort On
      --set xact_abort on

      -- Loop until condition is met
      while @attempts <= 5
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Insert records
              insert into dbo.TableName (columnOne, columnTwo, columnThree, columnFour, columnFive, columnSix, columnSeven, columnEight, columnNine, columnTen, columnEleven, created_date, modified_date)
              select
              distinct
              ltrim(rtrim(tnt.columnOne)),
              ltrim(rtrim(tnt.columnTwo)),
              ltrim(rtrim(tnt.columnThree)),
              ltrim(rtrim(tnt.columnFour)),
              iif(ltrim(rtrim(tnt.columnFive)) = '', null, ltrim(rtrim(tnt.columnFive))),
              cast(tnt.columnSix as datetime2(7)),
              ltrim(rtrim(tnt.columnSeven)),
              ltrim(rtrim(tnt.columnEight)),
              ltrim(rtrim(tnt.columnNine)),
              cast(tnt.columnTen as float),
              iif(ltrim(rtrim(tnt.columnEleven)) = '', null, cast(tnt.columnEleven as float)),
              getdate(),
              getdate()
              from dbo.TableNameTemp tnt
              left join dbo.TableName tn on tn.columnOne = tnt.columnOne
              where
              (
                ltrim(rtrim(tnt.columnOne)) <> '' and
                ltrim(rtrim(tnt.columnTwo)) <> '' and
                ltrim(rtrim(tnt.columnThree)) <> '' and
                ltrim(rtrim(tnt.columnFour)) <> '' and
                ltrim(rtrim(tnt.columnSix)) <> '' and
                ltrim(rtrim(tnt.columnSeven)) <> '' and
                ltrim(rtrim(tnt.columnEight)) <> '' and
                ltrim(rtrim(tnt.columnNine)) <> '' and
                ltrim(rtrim(tnt.columnTen)) <> ''
              ) and
              tn.columnOne is null

              -- Select message
              select
              'Success~Record(s) inserted' as [Status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end

              -- Break out of the loop
              break
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Only display an error message if it is on the final attempt of the execution
              if @attempts = 5
                begin
                  -- Select error number, line, and message
                  select
                  'Error~insertRecords: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                end

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end

              -- Increments the loop control for attempts
              set @attempts = @attempts + 1

              -- Wait for delay for x amount of time
              waitfor delay '00:00:04'

              -- Continue the loop
              continue
            end catch
            -- End catch block
        end

      ---- Set XAct Abort Off
      --set xact_abort off
    end
end