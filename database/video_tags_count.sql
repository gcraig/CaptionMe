SELECT TAG,COUNT(*) AS QTD_TAG
FROM TB_TAGS
GROUP BY TAG
ORDER BY COUNT(*) DESC


select video_tags, count(*) as qty FROM tmp_tags
group by video_tags order by count(*) desc