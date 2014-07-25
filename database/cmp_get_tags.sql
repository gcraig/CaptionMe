DROP PROCEDURE IF EXISTS caption_me.cmp_get_tags;
CREATE PROCEDURE caption_me.`cmp_get_tags`()
BEGIN

  -- SET group_concat_max_len = 65533;
	-- SELECT GROUP_CONCAT(video_tags SEPARATOR ', ') 
  --  AS `tags` FROM `caption_me`.`tbl_videos`;
    
  SELECT tagname, qty FROM tbl_video_tags;
		
END;
