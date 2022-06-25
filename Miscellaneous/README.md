## **Miscellaneous**

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



### **Numbers of orders where payment value is less than 10**


```sql
%%sql
SELECT COUNT(order_id) AS orders_payment_value_less_than_10
FROM orders
WHERE EXISTS(SELECT order_id
             FROM order_payments  
             WHERE orders.order_id= order_payments.order_id 
             AND payment_value < 10)
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>orders_payment_value_less_than_10</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>958</td>
        </tr>
    </tbody>
</table>



### **Payment method with there frequency**


```sql
%%sql
SELECT ROW_NUMBER() OVER(ORDER BY frequency DESC),
       payment_type,
       frequency
FROM(SELECT payment_type,
            COUNT(order_id) AS frequency
FROM order_payments
GROUP BY payment_type) AS freq
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    5 rows affected.





<table>
    <thead>
        <tr>
            <th>row_number</th>
            <th>payment_type</th>
            <th>frequency</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>credit_card</td>
            <td>76795</td>
        </tr>
        <tr>
            <td>2</td>
            <td>boleto</td>
            <td>19784</td>
        </tr>
        <tr>
            <td>3</td>
            <td>voucher</td>
            <td>5775</td>
        </tr>
        <tr>
            <td>4</td>
            <td>debit_card</td>
            <td>1529</td>
        </tr>
        <tr>
            <td>5</td>
            <td>not_defined</td>
            <td>3</td>
        </tr>
    </tbody>
</table>



### **Total number of  ids of customers and sellers**


```sql
%%sql
SELECT COUNT(*) AS total_ids
FROM (SELECT customer_unique_id AS idn FROM customers 
      UNION
      SELECT seller_id FROM sellers) AS ids 
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>total_ids</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>99191</td>
        </tr>
    </tbody>
</table>



### **Analysing freight value**


```sql
%%sql
WITH freight AS(SELECT order_id,
                       price,
                       freight_value,
                       CASE WHEN freight_value = 0.0 THEN 'FREE'
                            WHEN freight_value BETWEEN 0.1 AND 10.0 THEN 'VERY LOW'
                            WHEN freight_value BETWEEN 10.0 AND 100.0 THEN 'LOW'
                            WHEN freight_value BETWEEN 100.1 AND 200.0 THEN 'MEDIUM'
                            ELSE 'HIGH'
                       END AS freight_cost
                FROM order_items)
SELECT freight_cost,
       COUNT(freight_cost) AS freq
FROM freight
GROUP BY freight_cost
ORDER BY freq DESC
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    5 rows affected.





<table>
    <thead>
        <tr>
            <th>freight_cost</th>
            <th>freq</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>LOW</td>
            <td>96081</td>
        </tr>
        <tr>
            <td>VERY LOW</td>
            <td>15456</td>
        </tr>
        <tr>
            <td>MEDIUM</td>
            <td>601</td>
        </tr>
        <tr>
            <td>FREE</td>
            <td>383</td>
        </tr>
        <tr>
            <td>HIGH</td>
            <td>129</td>
        </tr>
    </tbody>
</table>



### **Product Translation**


```sql
%%sql
WITH prod_cat AS(SELECT DISTINCT(product_category)
                 FROM products)
SELECT product_category, category_translation
FROM prod_cat AS pc
LEFT JOIN product_translation AS pt
ON pc.product_category = pt.category
```

     * postgresql://postgres:***@localhost/olist
    74 rows affected.





<table>
    <thead>
        <tr>
            <th>product_category</th>
            <th>category_translation</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>beleza_saude</td>
            <td>health_beauty</td>
        </tr>
        <tr>
            <td>informatica_acessorios</td>
            <td>computers_accessories</td>
        </tr>
        <tr>
            <td>automotivo</td>
            <td>auto</td>
        </tr>
        <tr>
            <td>cama_mesa_banho</td>
            <td>bed_bath_table</td>
        </tr>
        <tr>
            <td>moveis_decoracao</td>
            <td>furniture_decor</td>
        </tr>
        <tr>
            <td>esporte_lazer</td>
            <td>sports_leisure</td>
        </tr>
        <tr>
            <td>perfumaria</td>
            <td>perfumery</td>
        </tr>
        <tr>
            <td>utilidades_domesticas</td>
            <td>housewares</td>
        </tr>
        <tr>
            <td>telefonia</td>
            <td>telephony</td>
        </tr>
        <tr>
            <td>relogios_presentes</td>
            <td>watches_gifts</td>
        </tr>
        <tr>
            <td>alimentos_bebidas</td>
            <td>food_drink</td>
        </tr>
        <tr>
            <td>bebes</td>
            <td>baby</td>
        </tr>
        <tr>
            <td>papelaria</td>
            <td>stationery</td>
        </tr>
        <tr>
            <td>tablets_impressao_imagem</td>
            <td>tablets_printing_image</td>
        </tr>
        <tr>
            <td>brinquedos</td>
            <td>toys</td>
        </tr>
        <tr>
            <td>telefonia_fixa</td>
            <td>fixed_telephony</td>
        </tr>
        <tr>
            <td>ferramentas_jardim</td>
            <td>garden_tools</td>
        </tr>
        <tr>
            <td>fashion_bolsas_e_acessorios</td>
            <td>fashion_bags_accessories</td>
        </tr>
        <tr>
            <td>eletroportateis</td>
            <td>small_appliances</td>
        </tr>
        <tr>
            <td>consoles_games</td>
            <td>consoles_games</td>
        </tr>
        <tr>
            <td>audio</td>
            <td>audio</td>
        </tr>
        <tr>
            <td>fashion_calcados</td>
            <td>fashion_shoes</td>
        </tr>
        <tr>
            <td>cool_stuff</td>
            <td>cool_stuff</td>
        </tr>
        <tr>
            <td>malas_acessorios</td>
            <td>luggage_accessories</td>
        </tr>
        <tr>
            <td>climatizacao</td>
            <td>air_conditioning</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_construcao</td>
            <td>construction_tools_construction</td>
        </tr>
        <tr>
            <td>moveis_cozinha_area_de_servico_jantar_e_jardim</td>
            <td>kitchen_dining_laundry_garden_furniture</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_jardim</td>
            <td>costruction_tools_garden</td>
        </tr>
        <tr>
            <td>fashion_roupa_masculina</td>
            <td>fashion_male_clothing</td>
        </tr>
        <tr>
            <td>pet_shop</td>
            <td>pet_shop</td>
        </tr>
        <tr>
            <td>moveis_escritorio</td>
            <td>office_furniture</td>
        </tr>
        <tr>
            <td>market_place</td>
            <td>market_place</td>
        </tr>
        <tr>
            <td>eletronicos</td>
            <td>electronics</td>
        </tr>
        <tr>
            <td>eletrodomesticos</td>
            <td>home_appliances</td>
        </tr>
        <tr>
            <td>artigos_de_festas</td>
            <td>party_supplies</td>
        </tr>
        <tr>
            <td>casa_conforto</td>
            <td>home_confort</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_ferramentas</td>
            <td>costruction_tools_tools</td>
        </tr>
        <tr>
            <td>agro_industria_e_comercio</td>
            <td>agro_industry_and_commerce</td>
        </tr>
        <tr>
            <td>moveis_colchao_e_estofado</td>
            <td>furniture_mattress_and_upholstery</td>
        </tr>
        <tr>
            <td>livros_tecnicos</td>
            <td>books_technical</td>
        </tr>
        <tr>
            <td>casa_construcao</td>
            <td>home_construction</td>
        </tr>
        <tr>
            <td>instrumentos_musicais</td>
            <td>musical_instruments</td>
        </tr>
        <tr>
            <td>moveis_sala</td>
            <td>furniture_living_room</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_iluminacao</td>
            <td>construction_tools_lights</td>
        </tr>
        <tr>
            <td>industria_comercio_e_negocios</td>
            <td>industry_commerce_and_business</td>
        </tr>
        <tr>
            <td>alimentos</td>
            <td>food</td>
        </tr>
        <tr>
            <td>artes</td>
            <td>art</td>
        </tr>
        <tr>
            <td>moveis_quarto</td>
            <td>furniture_bedroom</td>
        </tr>
        <tr>
            <td>livros_interesse_geral</td>
            <td>books_general_interest</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_seguranca</td>
            <td>construction_tools_safety</td>
        </tr>
        <tr>
            <td>fashion_underwear_e_moda_praia</td>
            <td>fashion_underwear_beach</td>
        </tr>
        <tr>
            <td>fashion_esporte</td>
            <td>fashion_sport</td>
        </tr>
        <tr>
            <td>sinalizacao_e_seguranca</td>
            <td>signaling_and_security</td>
        </tr>
        <tr>
            <td>pcs</td>
            <td>computers</td>
        </tr>
        <tr>
            <td>artigos_de_natal</td>
            <td>christmas_supplies</td>
        </tr>
        <tr>
            <td>fashion_roupa_feminina</td>
            <td>fashio_female_clothing</td>
        </tr>
        <tr>
            <td>eletrodomesticos_2</td>
            <td>home_appliances_2</td>
        </tr>
        <tr>
            <td>livros_importados</td>
            <td>books_imported</td>
        </tr>
        <tr>
            <td>bebidas</td>
            <td>drinks</td>
        </tr>
        <tr>
            <td>cine_foto</td>
            <td>cine_photo</td>
        </tr>
        <tr>
            <td>la_cuisine</td>
            <td>la_cuisine</td>
        </tr>
        <tr>
            <td>musica</td>
            <td>music</td>
        </tr>
        <tr>
            <td>casa_conforto_2</td>
            <td>home_comfort_2</td>
        </tr>
        <tr>
            <td>portateis_casa_forno_e_cafe</td>
            <td>small_appliances_home_oven_and_coffee</td>
        </tr>
        <tr>
            <td>cds_dvds_musicais</td>
            <td>cds_dvds_musicals</td>
        </tr>
        <tr>
            <td>dvds_blu_ray</td>
            <td>dvds_blu_ray</td>
        </tr>
        <tr>
            <td>flores</td>
            <td>flowers</td>
        </tr>
        <tr>
            <td>artes_e_artesanato</td>
            <td>arts_and_craftmanship</td>
        </tr>
        <tr>
            <td>fraldas_higiene</td>
            <td>diapers_and_hygiene</td>
        </tr>
        <tr>
            <td>fashion_roupa_infanto_juvenil</td>
            <td>fashion_childrens_clothes</td>
        </tr>
        <tr>
            <td>seguros_e_servicos</td>
            <td>security_and_services</td>
        </tr>
        <tr>
            <td>pc_gamer</td>
            <td> pc_gamer</td>
        </tr>
        <tr>
            <td>None</td>
            <td>None</td>
        </tr>
        <tr>
            <td>portateis_cozinha_e_preparadores_de_alimentos</td>
            <td>None</td>
        </tr>
    </tbody>
</table>


