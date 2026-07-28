with proportion_table as (SELECT 
    a.id AS a_id,
    a.input_fid,
    b.id AS b_id,
    b.length,
    (ST_Length(ST_Intersection(a.geom, b.geom))/5280)/b.length AS proportion, -- Intersect (clip) lines by hex polygons
    b.vol_tot,
    b.vmt_tot
FROM 
    test.eighth_mile_hexagon_14a a
INNER JOIN 
    test.tdm_2017e b 
ON 
    ST_Intersects(a.geom, b.geom)
    
WHERE 
    NOT ST_IsEmpty(ST_Intersection(a.geom, b.geom)
    )
)
select
	input_fid,
	avg(vol_tot * proportion) as vol_hexed,
	avg(vmt_tot * proportion) as vmt_hexed
from proportion_table
group by input_fid
;
