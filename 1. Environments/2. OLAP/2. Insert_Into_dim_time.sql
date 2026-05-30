INSERT INTO Dimensional.dim_time(time_date, time_day, time_month, time_year, time_weekday, time_quarter)
SELECT datum AS time_date,
       EXTRACT(DAY FROM datum) AS time_day,
       EXTRACT(MONTH FROM datum) AS time_month,
       EXTRACT(year FROM datum) AS time_year,
       EXTRACT(dow FROM datum) AS time_weekday,
       EXTRACT(quarter FROM datum) AS time_quarter
FROM (SELECT '1970-01-01'::DATE + SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES(0, 29219) AS SEQUENCE(DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1
