-- cmp = Caption Me Procedure
DELIMITER $$  
CREATE PROCEDURE cmp_create_tag_cloud()
-- (fullstr varchar(200))
BEGIN
  DECLARE ctr INT Default 0 ;
  DECLARE fullstr VARCHAR(255);
  DECLARE str VARCHAR(255);

  -- Create video tags table to hold descending tag occurences
  -- and tag count (in below select)
  DROP TABLE IF EXISTS video_tags;
  CREATE TABLE video_tags (
   tagname VARCHAR(200)
  );

  -- Select all tags into comma delimited string
  SET group_concat_max_len = 65533;
  SET fullstr = (SELECT GROUP_CONCAT(video_tags SEPARATOR ', ')
    AS `tags` FROM `caption_me`.`videos`);

  -- Split each tag into column for insertion into
  -- video tags table, break out at ctr
  -- for performance, and because only the top
  -- tags are visible anyways
  simple_loop: LOOP
    
    SET ctr=ctr+1;
    SET str = TRIM(SPLIT_STR(fullstr,",",ctr));
    IF ((str='') or (ctr=30)) THEN
      LEAVE simple_loop;
    END IF;
     
    -- Do Inserts into table here with str going into the row
    INSERT INTO video_tags (tagname) VALUES (str);
     
  END LOOP simple_loop;

  -- Select tags and its quantity with limit
  SELECT tagname, count(*) AS qty FROM video_tags
    GROUP BY tagname ORDER BY count(*) DESC LIMIT 30;
   
END $$