census = LOAD '/data_file_directory' AS (uidcompress:chararray, seconds_since_2000:long, mobilepopid:int, c1:int, timeId:chararray, identifier:chararray);
population = GROUP census BY mobilepopid;
device = GROUP census BY c1;
B = FOREACH population GENERATE 1234, 1, 5567, 0, CONCAT('mobilepopid=',(chararray)group), (chararray)COUNT(census), null, null;
C = FOREACH device GENERATE 1234, 1, 5567, 0, CONCAT('c1=',(chararray)group), (chararray)COUNT(census), null, null;
 
--provider_id time_type time_id hour_id name value external_id external_desc
 
STORE B INTO '/output_file_directory.bcp'
STORE C INTO '/output_file_directory.bcp'
