```python
%load_ext sql
import os
```


```python
host = "localhost"
database = "olist"
user = "postgres"
password = "sql123"
connection_string = f"postgresql://{user}:{password}@{host}/{database}"
%sql $connection_string
```




    'Connected: postgres@olist'



### **Sellers by state**


```sql
%%sql
SELECT seller_state,
       number_of_sellers,
       RANK() OVER(ORDER BY number_of_sellers DESC)
FROM  (SELECT seller_state,
              COUNT(seller_id) AS number_of_sellers
       FROM sellers
       GROUP BY seller_state) AS nos
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    10 rows affected.





<table>
    <thead>
        <tr>
            <th>seller_state</th>
            <th>number_of_sellers</th>
            <th>rank</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SP</td>
            <td>1849</td>
            <td>1</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>349</td>
            <td>2</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>244</td>
            <td>3</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>190</td>
            <td>4</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>171</td>
            <td>5</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>129</td>
            <td>6</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>40</td>
            <td>7</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>30</td>
            <td>8</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>23</td>
            <td>9</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>19</td>
            <td>10</td>
        </tr>
    </tbody>
</table>



### **Top 5 sellers by average shipping time**


```sql
%%sql
WITH ship_interval AS(SELECT seller_id,
                          order_id,
                          EXTRACT(EPOCH FROM (order_delivered_carrier - order_purchase)::interval)/3600 AS delivery_interval,
                          EXTRACT(EPOCH FROM (shipping_limit_date - order_purchase)::interval)/3600 AS shipping_limit_interval
                      FROM(SELECT order_id,
                                  seller_id,
                                  order_purchase,
                                  order_delivered_carrier,
                                  shipping_limit_date
                           FROM order_items
                           JOIN orders USING(order_id)
                           JOIN sellers USING(seller_id)
                           WHERE order_status IN('delivered')) AS ship_time)
SELECT seller_id,
       AVG(delivery_interval)::real AS avg_del_time,
       AVG(shipping_limit_interval)::real AS ship_limit_time
FROM ship_interval
GROUP BY seller_id
ORDER BY avg_del_time 
LIMIT 5
```

     * postgresql://postgres:***@localhost/olist
    5 rows affected.





<table>
    <thead>
        <tr>
            <th>seller_id</th>
            <th>avg_del_time</th>
            <th>ship_limit_time</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>89de2d6f23e9746ff309705b23581faa</td>
            <td>-413.78876</td>
            <td>148.53955</td>
        </tr>
        <tr>
            <td>1fa2d3def6adfa70e58c276bb64fe5bb</td>
            <td>-1.0680555</td>
            <td>144.33945</td>
        </tr>
        <tr>
            <td>1927cdb9fa74f5270097f6250e8e8f34</td>
            <td>-0.6963889</td>
            <td>96.12444</td>
        </tr>
        <tr>
            <td>b19c48688808720822399ffa9f2dbe2f</td>
            <td>-0.48055556</td>
            <td>144.17473</td>
        </tr>
        <tr>
            <td>0f94588695d71662beec8d883ffacf09</td>
            <td>1.2702777</td>
            <td>144.14223</td>
        </tr>
    </tbody>
</table>



### **Categories per seller**


```sql
%%sql
WITH seller_category AS(SELECT seller_id,
                               COUNT(product_category) AS num_of_cat
                        FROM sellers
                        JOIN order_items USING(seller_id)
                        JOIN products USING(product_id)
                        GROUP BY seller_id)
SELECT AVG(num_of_cat) AS avg_categories,
       percentile_cont(.5)
       WITHIN GROUP (ORDER BY num_of_cat) AS median_categories
FROM seller_category
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>avg_categories</th>
            <th>median_categories</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>35.8794830371567044</td>
            <td>7.0</td>
        </tr>
    </tbody>
</table>



### **Average sales per order by seller**


```sql
%%sql
SELECT seller_id,
       avg_order_rev,
       RANK() OVER(ORDER BY avg_order_rev DESC) AS rank
FROM(WITH order_unit AS(SELECT seller_id,
                               price,
                               COUNT(order_id) AS total_orders,
                               SUM(order_item_id) AS total_units
                        FROM sellers
                        JOIN order_items USING(seller_id)
                        GROUP BY seller_id, price),
    seller_unique AS(SELECT seller_id,
                            (price*total_units)::real AS revenue,
                            total_orders
                     FROM order_unit)

    SELECT seller_id,
           (revenue/total_orders)::real AS avg_order_rev
    FROM seller_unique) AS seller_avg
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    10 rows affected.





<table>
    <thead>
        <tr>
            <th>seller_id</th>
            <th>avg_order_rev</th>
            <th>rank</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>b37c4c02bda3161a7546a4e6d222d5b2</td>
            <td>7560.0</td>
            <td>1</td>
        </tr>
        <tr>
            <td>e3b4998c7a498169dc7bce44e6bb6277</td>
            <td>6735.0</td>
            <td>2</td>
        </tr>
        <tr>
            <td>80ceebb4ee9b31afb6c6a916a574a1e2</td>
            <td>6729.0</td>
            <td>3</td>
        </tr>
        <tr>
            <td>ee27a8f15b1dded4d213a468ba4eb391</td>
            <td>6499.0</td>
            <td>4</td>
        </tr>
        <tr>
            <td>59417c56835dd8e2e72f91f809cd4092</td>
            <td>4799.0</td>
            <td>5</td>
        </tr>
        <tr>
            <td>59417c56835dd8e2e72f91f809cd4092</td>
            <td>4690.0</td>
            <td>6</td>
        </tr>
        <tr>
            <td>c72de06d72748d1a0dfb2125be43ba63</td>
            <td>4590.0</td>
            <td>7</td>
        </tr>
        <tr>
            <td>b37c4c02bda3161a7546a4e6d222d5b2</td>
            <td>4475.0</td>
            <td>8</td>
        </tr>
        <tr>
            <td>512d298ac2a96d1931b6bd30aa21f61d</td>
            <td>4399.87</td>
            <td>9</td>
        </tr>
        <tr>
            <td>0873d9f8f36123f8d910f4760e788cfb</td>
            <td>4170.0</td>
            <td>10</td>
        </tr>
    </tbody>
</table>



### **Top 5 sellers top 3 markets**


```sql
%%sql
SELECT *
FROM(WITH seller_market AS(SELECT seller_id,
                             customer_state,
                             SUM(revenue) AS state_revenue
                      FROM(SELECT seller_id, 
                                  (price * order_item_id)::real AS revenue,
                                  customer_state
                           FROM sellers
                           JOIN order_items USING(seller_id)
                           JOIN orders USING(order_id)
                           JOIN customers USING(customer_id)) AS revenue_per_state
                           GROUP BY seller_id, customer_state)
SELECT seller_id, 
       customer_state,
       state_revenue,
       RANK() OVER(PARTITION BY seller_id ORDER BY state_revenue DESC)
FROM seller_market
WHERE seller_id IN(SELECT seller_id
                   FROM(SELECT seller_id,
                               SUM(revenue) AS total_rev
                        FROM(SELECT seller_id, 
                                    (order_item_id * price)::real AS revenue
                              FROM sellers
                              JOIN order_items USING(seller_id)) AS rev
                              GROUP BY seller_id
                              ORDER BY total_rev DESC) AS seller_rev
                              LIMIT 5)) AS rank_market_revenue
WHERE rank < 4
```

     * postgresql://postgres:***@localhost/olist
    15 rows affected.





<table>
    <thead>
        <tr>
            <th>seller_id</th>
            <th>customer_state</th>
            <th>state_revenue</th>
            <th>rank</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>4869f7a5dfa277a7dca6462dcf3b52b2</td>
            <td>SP</td>
            <td>91269.52</td>
            <td>1</td>
        </tr>
        <tr>
            <td>4869f7a5dfa277a7dca6462dcf3b52b2</td>
            <td>RJ</td>
            <td>39960.938</td>
            <td>2</td>
        </tr>
        <tr>
            <td>4869f7a5dfa277a7dca6462dcf3b52b2</td>
            <td>MG</td>
            <td>24398.865</td>
            <td>3</td>
        </tr>
        <tr>
            <td>4a3ca9315b744ce9f8e9374361493884</td>
            <td>SP</td>
            <td>97923.86</td>
            <td>1</td>
        </tr>
        <tr>
            <td>4a3ca9315b744ce9f8e9374361493884</td>
            <td>RJ</td>
            <td>34929.03</td>
            <td>2</td>
        </tr>
        <tr>
            <td>4a3ca9315b744ce9f8e9374361493884</td>
            <td>MG</td>
            <td>28982.508</td>
            <td>3</td>
        </tr>
        <tr>
            <td>53243585a1d6dc2643021fd1853d8905</td>
            <td>SP</td>
            <td>58100.15</td>
            <td>1</td>
        </tr>
        <tr>
            <td>53243585a1d6dc2643021fd1853d8905</td>
            <td>RJ</td>
            <td>30554.172</td>
            <td>2</td>
        </tr>
        <tr>
            <td>53243585a1d6dc2643021fd1853d8905</td>
            <td>BA</td>
            <td>26564.33</td>
            <td>3</td>
        </tr>
        <tr>
            <td>7c67e1448b00f6e969d365cea6b010ab</td>
            <td>SP</td>
            <td>115870.59</td>
            <td>1</td>
        </tr>
        <tr>
            <td>7c67e1448b00f6e969d365cea6b010ab</td>
            <td>RJ</td>
            <td>61318.992</td>
            <td>2</td>
        </tr>
        <tr>
            <td>7c67e1448b00f6e969d365cea6b010ab</td>
            <td>BA</td>
            <td>20978.963</td>
            <td>3</td>
        </tr>
        <tr>
            <td>da8622b14eb17ae2831f4ac5b9dab84a</td>
            <td>SP</td>
            <td>93375.36</td>
            <td>1</td>
        </tr>
        <tr>
            <td>da8622b14eb17ae2831f4ac5b9dab84a</td>
            <td>MG</td>
            <td>28836.824</td>
            <td>2</td>
        </tr>
        <tr>
            <td>da8622b14eb17ae2831f4ac5b9dab84a</td>
            <td>RJ</td>
            <td>28352.11</td>
            <td>3</td>
        </tr>
    </tbody>
</table>




```python

```
