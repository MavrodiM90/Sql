-- Задание 1
SELECT t.ID_client, AVG(t.Sum_payment) as avg_check, AVG(c.Total_amount) as avg_month, COUNT(*) as count_transactions
FROM transactions t 
JOIN customer c ON t.ID_client = c.ID_client
WHERE t.date_new >= '2015-06-01' AND t.date_new <= '2016-06-01' AND c.Tenure = 12
GROUP BY t.ID_client;

-- Задание 2
SELECT MONTH(t.date_new) AS month,AVG(t.Sum_payment) AS avg_payment_month, 
COUNT(t.Id_check) / COUNT(DISTINCT MONTH(t.date_new)) AS avg_count_transactions_month, 
COUNT(DISTINCT t.ID_client) / COUNT(DISTINCT MONTH(t.date_new)) AS avg_count_client_month
FROM transactions t
GROUP BY MONTH(t.date_new);

SELECT MONTH(t.date_new) AS month,
COUNT(t.Id_check) / (SELECT COUNT(Id_check) FROM transactions) * 100 AS transactions_share,
SUM(t.Sum_payment) / (SELECT SUM(Sum_payment) FROM transactions) * 100 AS payment_share
FROM transactions t
GROUP BY MONTH(t.date_new)
ORDER BY MONTH(t.date_new);

SELECT MONTH(t.date_new) AS month, c.Gender, 
COUNT(DISTINCT t.ID_client) AS count_clients, 
COUNT(DISTINCT t.ID_client) / (SELECT COUNT(DISTINCT t2.ID_client) FROM transactions t2) * 100 AS client_share, 
SUM(t.Sum_payment) / (SELECT SUM(t2.Sum_payment) FROM transactions t2) * 100 AS payment_share
FROM transactions t
JOIN customer c ON t.ID_client = c.ID_client
GROUP BY MONTH(t.date_new), c.Gender
ORDER BY MONTH(t.date_new);

-- Задание 3

SELECT 
    IF(c.Age IS NULL, 'Нет информации', 
        IF(c.Age BETWEEN 0 AND 9, '0-9', 
        IF(c.Age BETWEEN 10 AND 19, '10-19', 
        IF(c.Age BETWEEN 20 AND 29, '20-29', 
        IF(c.Age BETWEEN 30 AND 39, '30-39', 
        IF(c.Age BETWEEN 40 AND 49, '40-49', 
        IF(c.Age BETWEEN 50 AND 59, '50-59', 
        IF(c.Age BETWEEN 60 AND 69, '60-69', 
        IF(c.Age BETWEEN 70 AND 79, '70-79', '80+'))))))))) AS Age_Group, 
    COUNT(t.ID_check) AS total_operations,  
    SUM(t.Sum_payment) AS total_sum,  
    AVG(t.Sum_payment) AS avg_payment, 
    CONCAT(QUARTER(t.date_new), '-й квартал ', YEAR(t.date_new)) AS Quarter, 
    ROUND(SUM(t.Sum_payment) / (SELECT SUM(t2.Sum_payment) FROM transactions t2) * 100, 2) AS percentage_of_total
FROM customer c
JOIN transactions t ON c.ID_client = t.ID_client
GROUP BY Age_Group, Quarter 
ORDER BY Age_Group, Quarter;












