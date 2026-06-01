 
with demographic_variables as(
	select
		split_part(wpas."NAME",' ',1) as "NAMELSAD", -- create join id
		wp_emp.*,
		wpas."2023" as "2023_pop",
		wpas."2024" as "2024_pop",
		wpas."2025" as "2025_pop"
		from (select 
			"NAME", 
			sum("2023") as "2023_emp", 
			sum("2024") as "2024_emp",
			sum("2025") as "2025_emp"
			from demographics.wp_employment_smoothed wes
			where wes."NAME" like '%County, Tennessee%' -- county only
			group by "NAME" -- sum industries by grouping on name and placing variables of interest in aggregration function sum()
		) wp_emp
		inner join demographics.wp_pop_all_smoothed wpas on wpas."NAME" = wp_emp."NAME" -- join with population table, this doesn't need aggregation
)
select 
dv.*,
gcb.* 
from demographic_variables dv 
join test.gnrc_county_boundary gcb on dv."NAMELSAD" = gcb."NAMELSAD"
;