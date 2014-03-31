DELIMITER $$  
CREATE PROCEDURE sp_create_tag_cloud (fullstr varchar(200))
BEGIN     
      DECLARE a INT Default 0 ;
      DECLARE str VARCHAR(255);
      
      drop table if exists tmp_tags;
      
      create table tmp_tags (
       tagname varchar(200)
      );
      
      simple_loop: LOOP
         SET a=a+1;
         SET str = TRIM(SPLIT_STR(fullstr,",",a));
         IF str='' THEN
            LEAVE simple_loop;
         END IF;
         
         #Do Inserts into temp table here with str going into the row
         insert into tmp_tags (tagname) values (str);
         
   END LOOP simple_loop;
   
    -- select * From tmp_tags;
    select tagname, count(*) as qty FROM tmp_tags
    group by tagname order by count(*) desc;
   
END $$