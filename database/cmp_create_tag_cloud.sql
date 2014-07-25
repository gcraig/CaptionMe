DROP PROCEDURE IF EXISTS caption_me.cmp_create_tag_cloud;
CREATE PROCEDURE caption_me.`cmp_create_tag_cloud`()
BEGIN
  DECLARE ctr INT Default 0 ;
  DECLARE fullstr VARCHAR(255);
  DECLARE str VARCHAR(255);

  -- Create video tags table to hold descending tag occurences
  -- and tag count (in below select)
  DROP TABLE IF EXISTS tbl_video_tags_tmp;
  CREATE TEMPORARY TABLE tbl_video_tags_tmp (
   tagname VARCHAR(200)
  );

  -- Select all tags into comma delimited string
  SET group_concat_max_len = 65533;
  SET fullstr = (SELECT GROUP_CONCAT(video_tags SEPARATOR ', ')
    AS `tags` FROM `caption_me`.`tbl_videos` WHERE status = 'A');

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
    INSERT INTO tbl_video_tags_tmp (tagname) VALUES (str);
     
  END LOOP simple_loop;
    
  -- Select tags into table for display 
  -- Recreate periodically as needed
  DROP TABLE IF EXISTS tbl_video_tags;
  CREATE TABLE tbl_video_tags (
    SELECT tagname, count(*) AS qty FROM tbl_video_tags_tmp
      GROUP BY tagname ORDER BY count(*) DESC LIMIT 30);
   
END;
