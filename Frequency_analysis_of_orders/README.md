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



### **Frequency of orders delivered every month**


```sql
%%sql
SELECT date_part('year', order_delivered_customer)::int AS "year",
       date_part('month', order_delivered_customer)::int AS "month",
       COUNT(*) AS "orders_delivered"
FROM orders
WHERE order_status = 'delivered'
GROUP BY year, month
ORDER BY year, month
```

     * postgresql://postgres:***@localhost/olist
    26 rows affected.





<table>
    <thead>
        <tr>
            <th>year</th>
            <th>month</th>
            <th>orders_delivered</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>2016</td>
            <td>10</td>
            <td>205</td>
        </tr>
        <tr>
            <td>2016</td>
            <td>11</td>
            <td>58</td>
        </tr>
        <tr>
            <td>2016</td>
            <td>12</td>
            <td>4</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>1</td>
            <td>283</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>2</td>
            <td>1351</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>3</td>
            <td>2382</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>4</td>
            <td>1849</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>5</td>
            <td>3751</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>6</td>
            <td>3223</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>7</td>
            <td>3455</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>8</td>
            <td>4302</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>9</td>
            <td>3965</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>10</td>
            <td>4494</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>11</td>
            <td>4670</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>12</td>
            <td>7205</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>1</td>
            <td>6597</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>2</td>
            <td>5850</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>3</td>
            <td>6824</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>4</td>
            <td>7850</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>5</td>
            <td>7111</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>6</td>
            <td>6829</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>7</td>
            <td>5839</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>8</td>
            <td>8314</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>9</td>
            <td>56</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>10</td>
            <td>3</td>
        </tr>
        <tr>
            <td>None</td>
            <td>None</td>
            <td>8</td>
        </tr>
    </tbody>
</table>



### **Top 5 cities with most number of orders**


```sql
%%sql
SELECT cu.customer_state,
       cu.customer_city,
       COUNT(oi.order_id)
FROM orders AS oi
JOIN customers AS cu ON oi.customer_id = cu.customer_id
GROUP BY cu.customer_city, cu.customer_state
ORDER BY count DESC
LIMIT 5
```

     * postgresql://postgres:***@localhost/olist
    5 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>customer_city</th>
            <th>count</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SP</td>
            <td>sao paulo</td>
            <td>15540</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>rio de janeiro</td>
            <td>6882</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>belo horizonte</td>
            <td>2773</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>brasilia</td>
            <td>2131</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>curitiba</td>
            <td>1521</td>
        </tr>
    </tbody>
</table>



### **Deliveries by hour**


```sql
%%sql
SELECT date_part('hour', order_delivered_customer)::int AS "hour",
       COUNT(*) AS "orders_delivered"
FROM orders
WHERE order_status = 'delivered'
GROUP BY hour
```

     * postgresql://postgres:***@localhost/olist
    25 rows affected.





<table>
    <thead>
        <tr>
            <th>hour</th>
            <th>orders_delivered</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>0</td>
            <td>2885</td>
        </tr>
        <tr>
            <td>1</td>
            <td>1515</td>
        </tr>
        <tr>
            <td>2</td>
            <td>649</td>
        </tr>
        <tr>
            <td>3</td>
            <td>260</td>
        </tr>
        <tr>
            <td>4</td>
            <td>187</td>
        </tr>
        <tr>
            <td>5</td>
            <td>198</td>
        </tr>
        <tr>
            <td>6</td>
            <td>269</td>
        </tr>
        <tr>
            <td>7</td>
            <td>396</td>
        </tr>
        <tr>
            <td>8</td>
            <td>779</td>
        </tr>
        <tr>
            <td>9</td>
            <td>1196</td>
        </tr>
        <tr>
            <td>10</td>
            <td>1798</td>
        </tr>
        <tr>
            <td>11</td>
            <td>2579</td>
        </tr>
        <tr>
            <td>12</td>
            <td>3651</td>
        </tr>
        <tr>
            <td>13</td>
            <td>4561</td>
        </tr>
        <tr>
            <td>14</td>
            <td>5644</td>
        </tr>
        <tr>
            <td>15</td>
            <td>6740</td>
        </tr>
        <tr>
            <td>16</td>
            <td>7901</td>
        </tr>
        <tr>
            <td>17</td>
            <td>8775</td>
        </tr>
        <tr>
            <td>18</td>
            <td>9639</td>
        </tr>
        <tr>
            <td>19</td>
            <td>9484</td>
        </tr>
        <tr>
            <td>20</td>
            <td>9157</td>
        </tr>
        <tr>
            <td>21</td>
            <td>7627</td>
        </tr>
        <tr>
            <td>22</td>
            <td>6142</td>
        </tr>
        <tr>
            <td>23</td>
            <td>4438</td>
        </tr>
        <tr>
            <td>None</td>
            <td>8</td>
        </tr>
    </tbody>
</table>



### **Average difference between estimated and actual delivery by month**


```sql
%%sql
SELECT month,
       AVG(deviation_from_estimated)::real AS difference
FROM(SELECT EXTRACT(MONTH FROM order_purchase)::int AS month,
            EXTRACT('days' FROM order_estimated_delivery - order_delivered_customer)::int AS deviation_from_estimated
FROM orders
WHERE order_status = 'delivered') AS diff
GROUP BY month
```

     * postgresql://postgres:***@localhost/olist
    12 rows affected.





<table>
    <thead>
        <tr>
            <th>month</th>
            <th>difference</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>13.38496</td>
        </tr>
        <tr>
            <td>2</td>
            <td>9.620979</td>
        </tr>
        <tr>
            <td>3</td>
            <td>7.1721644</td>
        </tr>
        <tr>
            <td>4</td>
            <td>11.974069</td>
        </tr>
        <tr>
            <td>5</td>
            <td>11.7074995</td>
        </tr>
        <tr>
            <td>6</td>
            <td>16.024807</td>
        </tr>
        <tr>
            <td>7</td>
            <td>10.879737</td>
        </tr>
        <tr>
            <td>8</td>
            <td>9.200588</td>
        </tr>
        <tr>
            <td>9</td>
            <td>10.389063</td>
        </tr>
        <tr>
            <td>10</td>
            <td>12.356947</td>
        </tr>
        <tr>
            <td>11</td>
            <td>7.2666025</td>
        </tr>
        <tr>
            <td>12</td>
            <td>12.093943</td>
        </tr>
    </tbody>
</table>



### **Average difference between order and delivery time by state** 


```sql
%%sql
SELECT delivery_time.customer_state,
       AVG(delivery_time.delivery_in_days)::real AS avg_delivery_time_days
FROM(SELECT cu.customer_state,
            EXTRACT('days' FROM od.order_delivered_customer - od.order_purchase)::int AS delivery_in_days
     FROM ORDERS AS od
     JOIN customers AS cu ON od.customer_id = cu.customer_id
     WHERE order_status = 'delivered') AS delivery_time
GROUP BY customer_state
ORDER BY avg_delivery_time_days DESC
```

     * postgresql://postgres:***@localhost/olist
    27 rows affected.





<table>
    <thead>
        <tr>
            <th>customer_state</th>
            <th>avg_delivery_time_days</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>RR</td>
            <td>28.975609</td>
        </tr>
        <tr>
            <td>AP</td>
            <td>26.731344</td>
        </tr>
        <tr>
            <td>AM</td>
            <td>25.986206</td>
        </tr>
        <tr>
            <td>AL</td>
            <td>24.040302</td>
        </tr>
        <tr>
            <td>PA</td>
            <td>23.316067</td>
        </tr>
        <tr>
            <td>MA</td>
            <td>21.117155</td>
        </tr>
        <tr>
            <td>SE</td>
            <td>21.02985</td>
        </tr>
        <tr>
            <td>CE</td>
            <td>20.817827</td>
        </tr>
        <tr>
            <td>AC</td>
            <td>20.6375</td>
        </tr>
        <tr>
            <td>PB</td>
            <td>19.953579</td>
        </tr>
        <tr>
            <td>PI</td>
            <td>18.993698</td>
        </tr>
        <tr>
            <td>RO</td>
            <td>18.91358</td>
        </tr>
        <tr>
            <td>BA</td>
            <td>18.8664</td>
        </tr>
        <tr>
            <td>RN</td>
            <td>18.824894</td>
        </tr>
        <tr>
            <td>PE</td>
            <td>17.965473</td>
        </tr>
        <tr>
            <td>MT</td>
            <td>17.59368</td>
        </tr>
        <tr>
            <td>TO</td>
            <td>17.226278</td>
        </tr>
        <tr>
            <td>ES</td>
            <td>15.33183</td>
        </tr>
        <tr>
            <td>MS</td>
            <td>15.191155</td>
        </tr>
        <tr>
            <td>GO</td>
            <td>15.150741</td>
        </tr>
        <tr>
            <td>RJ</td>
            <td>14.848583</td>
        </tr>
        <tr>
            <td>RS</td>
            <td>14.819237</td>
        </tr>
        <tr>
            <td>SC</td>
            <td>14.4751835</td>
        </tr>
        <tr>
            <td>DF</td>
            <td>12.509134</td>
        </tr>
        <tr>
            <td>MG</td>
            <td>11.542188</td>
        </tr>
        <tr>
            <td>PR</td>
            <td>11.526711</td>
        </tr>
        <tr>
            <td>SP</td>
            <td>8.298094</td>
        </tr>
    </tbody>
</table>




```python

```
