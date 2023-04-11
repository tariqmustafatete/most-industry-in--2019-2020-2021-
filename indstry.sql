
with top_industries as (
    SELECT  TOP(3) industry, 
        COUNT(industry) as top_industry
    FROM industries  AS i
    INNER JOIN date AS d
        ON i.company_id = d.company_id
    WHERE DATEPART(year , d.date_joined) in ('2019', '2020', '2021')
    GROUP BY industry
    ORDER BY top_industry DESC
    
	),

 yearly_rankings AS 
(
    SELECT  COUNT(i.industry) AS num_unicorns,
       i.industry,
       DATEPART(year, d.date_joined) AS dates,
       AVG(f.valuation) AS average_valuation
FROM industries AS i
INNER JOIN date AS d
    ON i.company_id = d.company_id
INNER JOIN funding AS f
    ON d.company_id = f.company_id
GROUP BY i.industry, DATEPART(year, d.date_joined)
) 

SELECT industry,
  dates,
num_unicorns,
    ROUND(AVG(average_valuation / 1000000000), 2) AS average_valuation_billions
FROM yearly_rankings
WHERE dates in ('2019', '2020', '2021')
    AND industry in (SELECT industry
                    FROM top_industries)
GROUP BY industry, num_unicorns, dates, average_valuation
ORDER BY industry, dates DESC














