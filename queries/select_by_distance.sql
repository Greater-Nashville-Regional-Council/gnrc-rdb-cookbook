-- select * from test.parcel_counts_2017 mdr limit 5;
-- select parcels within x distance of the midpoint of a road segment

--	select ST_LineInterpolatePoint(ST_LineMerge(te.geom), 0.5) from test.tdm_2017e te limit 1

SELECT 
* 
FROM test.parcel_counts_2017 pc 
WHERE ST_DWithin(pc.geom,'SRID=2274;POINT (1853248.9293143959 535941.9852132384)',1609.344)
;