CREATE TABLE caption_me.videos (
	video_id int(10) NOT NULL auto_increment,
	video_url_sha256 varchar(128),
	video_url varchar(4096),
	video_mime_type varchar(255),
	video_codec varchar(127),
	video_views int(10),
	video_name varchar(1024),
	video_year int(10),
	video_description varchar(1024),
	video_tags varchar(4096),
	video_thumbnail blob(65535),
	video_thumbnail_filename varchar(255),
	video_type enum('movie','show') NOT NULL,
	is_spam char(1) DEFAULT 'F' NOT NULL,
	status char(1) DEFAULT 'A' NOT NULL,
	last_updated timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (video_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
GO

CREATE TABLE caption_me.video_captions (
	video_caption_id int(10) NOT NULL auto_increment,
	video_id int(10) NOT NULL,
	video_caption_file varchar(4096),
	video_caption_text longblob,
	video_caption_type varchar(255),
	status char(1) DEFAULT 'A' NOT NULL,
	last_updated timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (video_caption_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
GO

ALTER TABLE caption_me.video_captions
	ADD FOREIGN KEY (video_id) 
	REFERENCES videos (video_id)
GO

CREATE INDEX FK_videos ON caption_me.video_captions (video_id)
GO

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_tags`()
BEGIN
		SET group_concat_max_len = 65533;
		SELECT GROUP_CONCAT(video_tags SEPARATOR ', ') as `tags` FROM `caption_me`.`videos`;
		
    END
GO

