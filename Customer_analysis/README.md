```python
%load_ext sql
import os
```

    The sql extension is already loaded. To reload it, use:
      %reload_ext sql



```python
host = "localhost"
database = "olist"
user = "postgres"
password = "sql123"
connection_string = f"postgresql://{user}:{password}@{host}/{database}"
%sql $connection_string
```




    'Connected: postgres@olist'



### **Number of unique customer by state**


```sql
%%sql
SELECT customer_state,
       COUNT(customer_unique_id) AS no_of_customers
FROM customers
GROUP BY customer_state
ORDER BY no_of_customers DESC
```

     * postgresql://postgres:***@localhost/olist
    27 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>no_of_customers</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SP</td>
            <td>41746</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>12852</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>11635</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>5466</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>5045</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>3637</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>3380</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>2140</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>2033</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>2020</td>
        </tr>
        <tr>
            <td>PE</td>
            <td>1652</td>
        </tr>
        <tr>
            <td>CE</td>
            <td>1336</td>
        </tr>
        <tr>
            <td>PA</td>
            <td>975</td>
        </tr>
        <tr>
            <td>MT</td>
            <td>907</td>
        </tr>
        <tr>
            <td>MA</td>
            <td>747</td>
        </tr>
        <tr>
            <td>MS</td>
            <td>715</td>
        </tr>
        <tr>
            <td>PB</td>
            <td>536</td>
        </tr>
        <tr>
            <td>PI</td>
            <td>495</td>
        </tr>
        <tr>
            <td>RN</td>
            <td>485</td>
        </tr>
        <tr>
            <td>AL</td>
            <td>413</td>
        </tr>
        <tr>
            <td>SE</td>
            <td>350</td>
        </tr>
        <tr>
            <td>TO</td>
            <td>280</td>
        </tr>
        <tr>
            <td>RO</td>
            <td>253</td>
        </tr>
        <tr>
            <td>AM</td>
            <td>148</td>
        </tr>
        <tr>
            <td>AC</td>
            <td>81</td>
        </tr>
        <tr>
            <td>AP</td>
            <td>68</td>
        </tr>
        <tr>
            <td>RR</td>
            <td>46</td>
        </tr>
    </tbody>
</table>



### **Top 10 product categories most ordered by customers**


```sql
%%sql
WITH customer_items AS (SELECT *
                        FROM customers
                        JOIN orders USING(customer_id)
                        JOIN order_items USING(order_id)
                        JOIN products USING(product_id))
SELECT product_category,
       SUM(order_item_id) AS units
FROM customer_items
GROUP BY product_category
ORDER BY units DESC
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    10 rows affected.





<table>
    <thead>
        <tr>
            <th>product_category</th>
            <th>units</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>cama_mesa_banho</td>
            <td>13665</td>
        </tr>
        <tr>
            <td>moveis_decoracao</td>
            <td>11540</td>
        </tr>
        <tr>
            <td>beleza_saude</td>
            <td>11081</td>
        </tr>
        <tr>
            <td>esporte_lazer</td>
            <td>9932</td>
        </tr>
        <tr>
            <td>informatica_acessorios</td>
            <td>9874</td>
        </tr>
        <tr>
            <td>utilidades_domesticas</td>
            <td>9051</td>
        </tr>
        <tr>
            <td>relogios_presentes</td>
            <td>6594</td>
        </tr>
        <tr>
            <td>ferramentas_jardim</td>
            <td>5874</td>
        </tr>
        <tr>
            <td>telefonia</td>
            <td>5161</td>
        </tr>
        <tr>
            <td>automotivo</td>
            <td>4881</td>
        </tr>
    </tbody>
</table>



### **Average customer order price by state**


```sql
%%sql
WITH order_price AS(SELECT customer_id,
                           customer_state,
                           (order_item_id*price + freight_value)::real AS total_price
                    FROM customers
                    JOIN orders USING(customer_id)
                    JOIN order_items USING(order_id)
                    JOIN products USING(product_id))
SELECT customer_state,
       AVG(total_price)::real
FROM order_price
GROUP BY customer_state
ORDER BY avg DESC
```

     * postgresql://postgres:***@localhost/olist
    27 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>avg</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>PB</td>
            <td>254.92203</td>
        </tr>
        <tr>
            <td>AC</td>
            <td>235.44011</td>
        </tr>
        <tr>
            <td>AL</td>
            <td>230.23581</td>
        </tr>
        <tr>
            <td>AP</td>
            <td>224.04231</td>
        </tr>
        <tr>
            <td>PI</td>
            <td>219.86848</td>
        </tr>
        <tr>
            <td>RO</td>
            <td>216.66422</td>
        </tr>
        <tr>
            <td>PA</td>
            <td>216.15749</td>
        </tr>
        <tr>
            <td>RR</td>
            <td>210.93135</td>
        </tr>
        <tr>
            <td>TO</td>
            <td>207.69473</td>
        </tr>
        <tr>
            <td>CE</td>
            <td>206.16673</td>
        </tr>
        <tr>
            <td>SE</td>
            <td>205.05421</td>
        </tr>
        <tr>
            <td>MT</td>
            <td>203.74744</td>
        </tr>
        <tr>
            <td>RN</td>
            <td>202.12102</td>
        </tr>
        <tr>
            <td>MA</td>
            <td>198.72446</td>
        </tr>
        <tr>
            <td>PE</td>
            <td>188.99063</td>
        </tr>
        <tr>
            <td>AM</td>
            <td>183.80533</td>
        </tr>
        <tr>
            <td>MS</td>
            <td>180.0531</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>179.83725</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>178.20496</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>164.28613</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>162.26056</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>160.20909</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>159.0866</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>158.83072</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>157.74991</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>155.7808</td>
        </tr>
        <tr>
            <td>SP</td>
            <td>139.50151</td>
        </tr>
    </tbody>
</table>



### **Frequency credit card payment by state**


```sql
%%sql
WITH payment AS(SELECT customer_state,
                       payment_type
                FROM orders AS od
                JOIN customers AS cu USING(customer_id)
                JOIN order_payments AS pay USING(order_id))
SELECT customer_state,
       payment_type,
       COUNT(*)
FROM payment
WHERE payment_type = 'credit_card'
GROUP BY customer_state, payment_type
ORDER BY count DESC
```

     * postgresql://postgres:***@localhost/olist
    27 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>payment_type</th>
            <th>count</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SP</td>
            <td>credit_card</td>
            <td>32168</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>credit_card</td>
            <td>10288</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>credit_card</td>
            <td>9070</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>credit_card</td>
            <td>3985</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>credit_card</td>
            <td>3786</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>credit_card</td>
            <td>2713</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>credit_card</td>
            <td>2662</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>credit_card</td>
            <td>1700</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>credit_card</td>
            <td>1573</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>credit_card</td>
            <td>1520</td>
        </tr>
        <tr>
            <td>PE</td>
            <td>credit_card</td>
            <td>1334</td>
        </tr>
        <tr>
            <td>CE</td>
            <td>credit_card</td>
            <td>1091</td>
        </tr>
        <tr>
            <td>PA</td>
            <td>credit_card</td>
            <td>728</td>
        </tr>
        <tr>
            <td>MT</td>
            <td>credit_card</td>
            <td>659</td>
        </tr>
        <tr>
            <td>MA</td>
            <td>credit_card</td>
            <td>535</td>
        </tr>
        <tr>
            <td>MS</td>
            <td>credit_card</td>
            <td>519</td>
        </tr>
        <tr>
            <td>PB</td>
            <td>credit_card</td>
            <td>428</td>
        </tr>
        <tr>
            <td>RN</td>
            <td>credit_card</td>
            <td>394</td>
        </tr>
        <tr>
            <td>PI</td>
            <td>credit_card</td>
            <td>389</td>
        </tr>
        <tr>
            <td>AL</td>
            <td>credit_card</td>
            <td>341</td>
        </tr>
        <tr>
            <td>SE</td>
            <td>credit_card</td>
            <td>264</td>
        </tr>
        <tr>
            <td>TO</td>
            <td>credit_card</td>
            <td>197</td>
        </tr>
        <tr>
            <td>RO</td>
            <td>credit_card</td>
            <td>186</td>
        </tr>
        <tr>
            <td>AM</td>
            <td>credit_card</td>
            <td>124</td>
        </tr>
        <tr>
            <td>AC</td>
            <td>credit_card</td>
            <td>61</td>
        </tr>
        <tr>
            <td>AP</td>
            <td>credit_card</td>
            <td>47</td>
        </tr>
        <tr>
            <td>RR</td>
            <td>credit_card</td>
            <td>33</td>
        </tr>
    </tbody>
</table>



### **Proportion of customers paying in more than one installment by state**


```sql
%%sql
SELECT customer_state,
       count,
       (count/total_order) AS proportion
FROM(WITH payment AS(SELECT customer_state,
                            payment_installments
                     FROM orders AS od
                     JOIN customers AS cu USING(customer_id)
                     JOIN order_payments AS pay USING(order_id)
                     WHERE payment_installments > 1)
    SELECT customer_state,
           COUNT(payment_installments)::real AS count,
           (SELECT COUNT(order_id) FROM orders)::real AS total_order
    FROM payment
    GROUP BY customer_state
    ORDER BY count DESC) AS g2
WHERE count > 1000
ORDER BY proportion DESC
```

     * postgresql://postgres:***@localhost/olist
    11 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>count</th>
            <th>proportion</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SP</td>
            <td>19970.0</td>
            <td>0.20082259</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>7055.0</td>
            <td>0.07094659</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>6315.0</td>
            <td>0.063504994</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>2777.0</td>
            <td>0.027926108</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>2500.0</td>
            <td>0.025140535</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>1977.0</td>
            <td>0.019881135</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>1816.0</td>
            <td>0.018262085</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>1110.0</td>
            <td>0.011162397</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>1094.0</td>
            <td>0.011001498</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>1062.0</td>
            <td>0.0106796995</td>
        </tr>
        <tr>
            <td>PE</td>
            <td>1042.0</td>
            <td>0.010478575</td>
        </tr>
    </tbody>
</table>




```python

```
