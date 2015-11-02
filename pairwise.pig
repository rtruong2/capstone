census = LOAD '/data_file_directory' AS (uidcompress:chararray, seconds_since_2000:long, mobilepopid:int, c1:int, timeId:chararray, identifier:chararray);

--load the data using the input schema provided

population = GROUP census BY mobilepopid;

--group the data by population

device = GROUP census BY c1;

--group the data by c1 type

B = FOREACH population GENERATE 1234, 1, 5567, 0, CONCAT('mobilepopid=',(chararray)group), (chararray)COUNT(census), null, null;

--create the output schema for each group by population
--output schema is: provider_id time_type time_id hour_id name value external_id external_desc
--most of these fields besides name and value are dummy inputs that are just meant to fit the schema

C = FOREACH device GENERATE 1234, 1, 5567, 0, CONCAT('c1=',(chararray)group), (chararray)COUNT(census), null, null;
 
--ditto with groups by c1
 
STORE B INTO '/output_file_directory.bcp'
STORE C INTO '/output_file_directory.bcp'

--output into files
