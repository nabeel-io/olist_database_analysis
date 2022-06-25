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



### **Average length of name and description**


```sql
%%sql
SELECT product_category,
       AVG(product_name_length)::int AS name_length,
       AVG(product_desc_length)::int AS desc_length
FROM products
WHERE product_category IS NOT NULL
GROUP BY product_category
ORDER BY name_length, desc_length;
```

     * postgresql://postgres:***@localhost/olist
    73 rows affected.





<table>
    <thead>
        <tr>
            <th>product_category</th>
            <th>name_length</th>
            <th>desc_length</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>fashion_roupa_masculina</td>
            <td>40</td>
            <td>627</td>
        </tr>
        <tr>
            <td>fashion_roupa_feminina</td>
            <td>40</td>
            <td>639</td>
        </tr>
        <tr>
            <td>livros_interesse_geral</td>
            <td>40</td>
            <td>989</td>
        </tr>
        <tr>
            <td>livros_tecnicos</td>
            <td>42</td>
            <td>1352</td>
        </tr>
        <tr>
            <td>moveis_colchao_e_estofado</td>
            <td>43</td>
            <td>1111</td>
        </tr>
        <tr>
            <td>artigos_de_natal</td>
            <td>44</td>
            <td>412</td>
        </tr>
        <tr>
            <td>artes_e_artesanato</td>
            <td>44</td>
            <td>620</td>
        </tr>
        <tr>
            <td>moveis_sala</td>
            <td>44</td>
            <td>625</td>
        </tr>
        <tr>
            <td>market_place</td>
            <td>44</td>
            <td>829</td>
        </tr>
        <tr>
            <td>consoles_games</td>
            <td>44</td>
            <td>850</td>
        </tr>
        <tr>
            <td>bebidas</td>
            <td>44</td>
            <td>1048</td>
        </tr>
        <tr>
            <td>fashion_roupa_infanto_juvenil</td>
            <td>45</td>
            <td>351</td>
        </tr>
        <tr>
            <td>fashion_bolsas_e_acessorios</td>
            <td>45</td>
            <td>513</td>
        </tr>
        <tr>
            <td>brinquedos</td>
            <td>45</td>
            <td>686</td>
        </tr>
        <tr>
            <td>perfumaria</td>
            <td>45</td>
            <td>694</td>
        </tr>
        <tr>
            <td>alimentos_bebidas</td>
            <td>45</td>
            <td>983</td>
        </tr>
        <tr>
            <td>fraldas_higiene</td>
            <td>46</td>
            <td>488</td>
        </tr>
        <tr>
            <td>fashion_esporte</td>
            <td>46</td>
            <td>556</td>
        </tr>
        <tr>
            <td>moveis_quarto</td>
            <td>46</td>
            <td>740</td>
        </tr>
        <tr>
            <td>bebes</td>
            <td>46</td>
            <td>824</td>
        </tr>
        <tr>
            <td>dvds_blu_ray</td>
            <td>46</td>
            <td>1071</td>
        </tr>
        <tr>
            <td>alimentos</td>
            <td>46</td>
            <td>1137</td>
        </tr>
        <tr>
            <td>moveis_escritorio</td>
            <td>46</td>
            <td>1353</td>
        </tr>
        <tr>
            <td>cds_dvds_musicais</td>
            <td>47</td>
            <td>117</td>
        </tr>
        <tr>
            <td>livros_importados</td>
            <td>47</td>
            <td>581</td>
        </tr>
        <tr>
            <td>malas_acessorios</td>
            <td>47</td>
            <td>633</td>
        </tr>
        <tr>
            <td>artes</td>
            <td>47</td>
            <td>678</td>
        </tr>
        <tr>
            <td>eletronicos</td>
            <td>47</td>
            <td>709</td>
        </tr>
        <tr>
            <td>moveis_cozinha_area_de_servico_jantar_e_jardim</td>
            <td>47</td>
            <td>726</td>
        </tr>
        <tr>
            <td>audio</td>
            <td>47</td>
            <td>782</td>
        </tr>
        <tr>
            <td>esporte_lazer</td>
            <td>47</td>
            <td>954</td>
        </tr>
        <tr>
            <td>musica</td>
            <td>47</td>
            <td>1060</td>
        </tr>
        <tr>
            <td>beleza_saude</td>
            <td>47</td>
            <td>1137</td>
        </tr>
        <tr>
            <td>utilidades_domesticas</td>
            <td>48</td>
            <td>674</td>
        </tr>
        <tr>
            <td>informatica_acessorios</td>
            <td>48</td>
            <td>774</td>
        </tr>
        <tr>
            <td>eletrodomesticos_2</td>
            <td>48</td>
            <td>798</td>
        </tr>
        <tr>
            <td>sinalizacao_e_seguranca</td>
            <td>48</td>
            <td>817</td>
        </tr>
        <tr>
            <td>cool_stuff</td>
            <td>48</td>
            <td>876</td>
        </tr>
        <tr>
            <td>telefonia_fixa</td>
            <td>48</td>
            <td>1017</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_jardim</td>
            <td>48</td>
            <td>1135</td>
        </tr>
        <tr>
            <td>artigos_de_festas</td>
            <td>49</td>
            <td>446</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_ferramentas</td>
            <td>49</td>
            <td>708</td>
        </tr>
        <tr>
            <td>agro_industria_e_comercio</td>
            <td>49</td>
            <td>808</td>
        </tr>
        <tr>
            <td>ferramentas_jardim</td>
            <td>49</td>
            <td>815</td>
        </tr>
        <tr>
            <td>pet_shop</td>
            <td>49</td>
            <td>866</td>
        </tr>
        <tr>
            <td>eletroportateis</td>
            <td>49</td>
            <td>934</td>
        </tr>
        <tr>
            <td>papelaria</td>
            <td>50</td>
            <td>439</td>
        </tr>
        <tr>
            <td>fashion_calcados</td>
            <td>50</td>
            <td>458</td>
        </tr>
        <tr>
            <td>relogios_presentes</td>
            <td>50</td>
            <td>612</td>
        </tr>
        <tr>
            <td>telefonia</td>
            <td>50</td>
            <td>755</td>
        </tr>
        <tr>
            <td>instrumentos_musicais</td>
            <td>50</td>
            <td>795</td>
        </tr>
        <tr>
            <td>moveis_decoracao</td>
            <td>50</td>
            <td>799</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_construcao</td>
            <td>51</td>
            <td>789</td>
        </tr>
        <tr>
            <td>casa_construcao</td>
            <td>51</td>
            <td>855</td>
        </tr>
        <tr>
            <td>cine_foto</td>
            <td>51</td>
            <td>939</td>
        </tr>
        <tr>
            <td>casa_conforto_2</td>
            <td>52</td>
            <td>394</td>
        </tr>
        <tr>
            <td>la_cuisine</td>
            <td>52</td>
            <td>422</td>
        </tr>
        <tr>
            <td>cama_mesa_banho</td>
            <td>52</td>
            <td>464</td>
        </tr>
        <tr>
            <td>flores</td>
            <td>52</td>
            <td>468</td>
        </tr>
        <tr>
            <td>seguros_e_servicos</td>
            <td>52</td>
            <td>484</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_iluminacao</td>
            <td>52</td>
            <td>788</td>
        </tr>
        <tr>
            <td>automotivo</td>
            <td>52</td>
            <td>814</td>
        </tr>
        <tr>
            <td>climatizacao</td>
            <td>52</td>
            <td>903</td>
        </tr>
        <tr>
            <td>fashion_underwear_e_moda_praia</td>
            <td>52</td>
            <td>1004</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_seguranca</td>
            <td>52</td>
            <td>1106</td>
        </tr>
        <tr>
            <td>casa_conforto</td>
            <td>53</td>
            <td>320</td>
        </tr>
        <tr>
            <td>portateis_casa_forno_e_cafe</td>
            <td>53</td>
            <td>1046</td>
        </tr>
        <tr>
            <td>industria_comercio_e_negocios</td>
            <td>53</td>
            <td>1103</td>
        </tr>
        <tr>
            <td>eletrodomesticos</td>
            <td>54</td>
            <td>405</td>
        </tr>
        <tr>
            <td>portateis_cozinha_e_preparadores_de_alimentos</td>
            <td>54</td>
            <td>623</td>
        </tr>
        <tr>
            <td>tablets_impressao_imagem</td>
            <td>54</td>
            <td>676</td>
        </tr>
        <tr>
            <td>pcs</td>
            <td>56</td>
            <td>2129</td>
        </tr>
        <tr>
            <td>pc_gamer</td>
            <td>60</td>
            <td>998</td>
        </tr>
    </tbody>
</table>



### **Average weight, length, height, width for a product category**


```sql
%%sql
SELECT product_category,
       (AVG(product_weight_grams)/1000)::real AS avg_weight,
        AVG(product_length_cm)::real AS avg_length,
        AVG(product_height_cm)::real AS avg_height,
        AVG(product_width_cm)::real AS avg_width
FROM products 
WHERE product_category IS NOT NULL
GROUP BY product_category
```

     * postgresql://postgres:***@localhost/olist
    73 rows affected.





<table>
    <thead>
        <tr>
            <th>product_category</th>
            <th>avg_weight</th>
            <th>avg_length</th>
            <th>avg_height</th>
            <th>avg_width</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>climatizacao</td>
            <td>4.4599595</td>
            <td>36.467743</td>
            <td>23.887096</td>
            <td>26.088709</td>
        </tr>
        <tr>
            <td>livros_importados</td>
            <td>0.5967742</td>
            <td>29.741936</td>
            <td>3.451613</td>
            <td>21.225807</td>
        </tr>
        <tr>
            <td>artigos_de_natal</td>
            <td>1.8498154</td>
            <td>28.23077</td>
            <td>16.215385</td>
            <td>22.830769</td>
        </tr>
        <tr>
            <td>livros_tecnicos</td>
            <td>1.1078455</td>
            <td>27.325203</td>
            <td>5.869919</td>
            <td>18.463415</td>
        </tr>
        <tr>
            <td>ferramentas_jardim</td>
            <td>3.103777</td>
            <td>30.936255</td>
            <td>19.204515</td>
            <td>23.504648</td>
        </tr>
        <tr>
            <td>cine_foto</td>
            <td>0.7957857</td>
            <td>27.642857</td>
            <td>11.571428</td>
            <td>18.178572</td>
        </tr>
        <tr>
            <td>dvds_blu_ray</td>
            <td>0.3815625</td>
            <td>21.270834</td>
            <td>4.4166665</td>
            <td>14.875</td>
        </tr>
        <tr>
            <td>fashion_roupa_feminina</td>
            <td>0.57222223</td>
            <td>23.296297</td>
            <td>11.481482</td>
            <td>18.333334</td>
        </tr>
        <tr>
            <td>beleza_saude</td>
            <td>1.4347938</td>
            <td>23.800737</td>
            <td>15.712357</td>
            <td>17.997545</td>
        </tr>
        <tr>
            <td>livros_interesse_geral</td>
            <td>0.7466111</td>
            <td>23.481482</td>
            <td>9.773149</td>
            <td>19.328703</td>
        </tr>
        <tr>
            <td>tablets_impressao_imagem</td>
            <td>0.38144445</td>
            <td>28.11111</td>
            <td>9.444445</td>
            <td>21.555555</td>
        </tr>
        <tr>
            <td>papelaria</td>
            <td>1.763113</td>
            <td>29.062426</td>
            <td>19.586573</td>
            <td>23.34629</td>
        </tr>
        <tr>
            <td>bebes</td>
            <td>3.6552014</td>
            <td>37.14706</td>
            <td>21.617647</td>
            <td>28.717865</td>
        </tr>
        <tr>
            <td>musica</td>
            <td>1.2135185</td>
            <td>27.148148</td>
            <td>9.925926</td>
            <td>18.222221</td>
        </tr>
        <tr>
            <td>consoles_games</td>
            <td>0.6366593</td>
            <td>21.791798</td>
            <td>12.640379</td>
            <td>18.473186</td>
        </tr>
        <tr>
            <td>eletrodomesticos</td>
            <td>1.9796541</td>
            <td>29.805405</td>
            <td>14.8918915</td>
            <td>21.859459</td>
        </tr>
        <tr>
            <td>cama_mesa_banho</td>
            <td>2.4564052</td>
            <td>36.77418</td>
            <td>14.091119</td>
            <td>30.589964</td>
        </tr>
        <tr>
            <td>la_cuisine</td>
            <td>4.35</td>
            <td>67.3</td>
            <td>13.8</td>
            <td>34.8</td>
        </tr>
        <tr>
            <td>seguros_e_servicos</td>
            <td>0.8125</td>
            <td>26.5</td>
            <td>28.5</td>
            <td>13.0</td>
        </tr>
        <tr>
            <td>artes_e_artesanato</td>
            <td>1.1645789</td>
            <td>28.368422</td>
            <td>9.789474</td>
            <td>21.052631</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_iluminacao</td>
            <td>2.2809615</td>
            <td>27.846153</td>
            <td>20.423077</td>
            <td>25.73077</td>
        </tr>
        <tr>
            <td>eletroportateis</td>
            <td>4.0123982</td>
            <td>29.47186</td>
            <td>27.038961</td>
            <td>27.30736</td>
        </tr>
        <tr>
            <td>malas_acessorios</td>
            <td>3.7232838</td>
            <td>35.74212</td>
            <td>29.584528</td>
            <td>30.707737</td>
        </tr>
        <tr>
            <td>flores</td>
            <td>1.4035715</td>
            <td>21.714285</td>
            <td>15.571428</td>
            <td>16.714285</td>
        </tr>
        <tr>
            <td>artigos_de_festas</td>
            <td>2.7057693</td>
            <td>32.307693</td>
            <td>16.5</td>
            <td>22.73077</td>
        </tr>
        <tr>
            <td>sinalizacao_e_seguranca</td>
            <td>2.9698172</td>
            <td>30.505377</td>
            <td>23.892473</td>
            <td>20.817204</td>
        </tr>
        <tr>
            <td>alimentos</td>
            <td>0.92341465</td>
            <td>21.292683</td>
            <td>14.682927</td>
            <td>17.719513</td>
        </tr>
        <tr>
            <td>casa_construcao</td>
            <td>3.3957155</td>
            <td>29.328888</td>
            <td>24.377777</td>
            <td>23.457777</td>
        </tr>
        <tr>
            <td>telefonia</td>
            <td>0.23650618</td>
            <td>18.432981</td>
            <td>6.8536153</td>
            <td>13.248677</td>
        </tr>
        <tr>
            <td>esporte_lazer</td>
            <td>2.0246708</td>
            <td>31.280085</td>
            <td>18.10987</td>
            <td>20.824207</td>
        </tr>
        <tr>
            <td>moveis_quarto</td>
            <td>9.997222</td>
            <td>59.933334</td>
            <td>30.8</td>
            <td>34.4</td>
        </tr>
        <tr>
            <td>moveis_sala</td>
            <td>8.934846</td>
            <td>50.73077</td>
            <td>22.365385</td>
            <td>44.429485</td>
        </tr>
        <tr>
            <td>moveis_colchao_e_estofado</td>
            <td>13.19</td>
            <td>46.3</td>
            <td>34.4</td>
            <td>41.3</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_construcao</td>
            <td>3.5500524</td>
            <td>29.795</td>
            <td>15.895</td>
            <td>24.2425</td>
        </tr>
        <tr>
            <td>fashion_underwear_e_moda_praia</td>
            <td>0.36226416</td>
            <td>25.509434</td>
            <td>8.849056</td>
            <td>18.90566</td>
        </tr>
        <tr>
            <td>moveis_decoracao</td>
            <td>3.008267</td>
            <td>43.894993</td>
            <td>17.438087</td>
            <td>28.663155</td>
        </tr>
        <tr>
            <td>portateis_cozinha_e_preparadores_de_alimentos</td>
            <td>2.5175</td>
            <td>28.5</td>
            <td>25.3</td>
            <td>24.6</td>
        </tr>
        <tr>
            <td>fashion_esporte</td>
            <td>0.34473684</td>
            <td>22.105263</td>
            <td>12.842105</td>
            <td>16.263159</td>
        </tr>
        <tr>
            <td>alimentos_bebidas</td>
            <td>1.3079327</td>
            <td>23.403847</td>
            <td>15.951923</td>
            <td>18.39423</td>
        </tr>
        <tr>
            <td>moveis_cozinha_area_de_servico_jantar_e_jardim</td>
            <td>11.598564</td>
            <td>47.340427</td>
            <td>40.47872</td>
            <td>38.68085</td>
        </tr>
        <tr>
            <td>pc_gamer</td>
            <td>1.4296666</td>
            <td>17.666666</td>
            <td>20.0</td>
            <td>20.0</td>
        </tr>
        <tr>
            <td>bebidas</td>
            <td>1.7361728</td>
            <td>23.91358</td>
            <td>22.37037</td>
            <td>19.395061</td>
        </tr>
        <tr>
            <td>market_place</td>
            <td>1.5441058</td>
            <td>26.759615</td>
            <td>17.625</td>
            <td>22.490385</td>
        </tr>
        <tr>
            <td>fashion_roupa_masculina</td>
            <td>0.55973685</td>
            <td>27.326315</td>
            <td>14.021052</td>
            <td>22.11579</td>
        </tr>
        <tr>
            <td>fashion_calcados</td>
            <td>1.0445087</td>
            <td>26.028902</td>
            <td>13.381503</td>
            <td>24.947977</td>
        </tr>
        <tr>
            <td>casa_conforto_2</td>
            <td>1.4676</td>
            <td>53.2</td>
            <td>15.2</td>
            <td>26.2</td>
        </tr>
        <tr>
            <td>eletronicos</td>
            <td>1.2750851</td>
            <td>25.237911</td>
            <td>11.736944</td>
            <td>18.468084</td>
        </tr>
        <tr>
            <td>audio</td>
            <td>0.6416379</td>
            <td>20.827587</td>
            <td>11.5</td>
            <td>17.344828</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_jardim</td>
            <td>2.401034</td>
            <td>28.693182</td>
            <td>16.65909</td>
            <td>20.511364</td>
        </tr>
        <tr>
            <td>artes</td>
            <td>1.6917636</td>
            <td>35.927273</td>
            <td>11.8</td>
            <td>23.363636</td>
        </tr>
        <tr>
            <td>automotivo</td>
            <td>2.6546504</td>
            <td>34.05</td>
            <td>16.24158</td>
            <td>23.382105</td>
        </tr>
        <tr>
            <td>cool_stuff</td>
            <td>2.566579</td>
            <td>33.752853</td>
            <td>22.988594</td>
            <td>24.491762</td>
        </tr>
        <tr>
            <td>industria_comercio_e_negocios</td>
            <td>5.929191</td>
            <td>39.058823</td>
            <td>32.514706</td>
            <td>29.220589</td>
        </tr>
        <tr>
            <td>pcs</td>
            <td>7.995333</td>
            <td>32.133335</td>
            <td>34.333332</td>
            <td>40.1</td>
        </tr>
        <tr>
            <td>agro_industria_e_comercio</td>
            <td>5.2634053</td>
            <td>36.527027</td>
            <td>28.945946</td>
            <td>25.81081</td>
        </tr>
        <tr>
            <td>casa_conforto</td>
            <td>3.8004506</td>
            <td>39.198196</td>
            <td>20.045046</td>
            <td>33.414413</td>
        </tr>
        <tr>
            <td>pet_shop</td>
            <td>3.0888567</td>
            <td>32.98053</td>
            <td>20.126564</td>
            <td>26.749653</td>
        </tr>
        <tr>
            <td>moveis_escritorio</td>
            <td>12.740868</td>
            <td>55.62783</td>
            <td>41.86408</td>
            <td>37.919094</td>
        </tr>
        <tr>
            <td>fashion_roupa_infanto_juvenil</td>
            <td>0.324</td>
            <td>27.4</td>
            <td>13.4</td>
            <td>20.6</td>
        </tr>
        <tr>
            <td>informatica_acessorios</td>
            <td>0.89837766</td>
            <td>25.039658</td>
            <td>12.461257</td>
            <td>18.14338</td>
        </tr>
        <tr>
            <td>portateis_casa_forno_e_cafe</td>
            <td>3.071516</td>
            <td>31.32258</td>
            <td>22.838709</td>
            <td>23.870968</td>
        </tr>
        <tr>
            <td>telefonia_fixa</td>
            <td>0.6608276</td>
            <td>20.646551</td>
            <td>10.74138</td>
            <td>16.5</td>
        </tr>
        <tr>
            <td>utilidades_domesticas</td>
            <td>3.0207937</td>
            <td>31.859957</td>
            <td>22.337902</td>
            <td>24.821413</td>
        </tr>
        <tr>
            <td>instrumentos_musicais</td>
            <td>3.361038</td>
            <td>36.276817</td>
            <td>16.854671</td>
            <td>29.84429</td>
        </tr>
        <tr>
            <td>relogios_presentes</td>
            <td>0.5092874</td>
            <td>19.222723</td>
            <td>10.292702</td>
            <td>15.268623</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_ferramentas</td>
            <td>1.0478206</td>
            <td>23.461538</td>
            <td>15.666667</td>
            <td>17.23077</td>
        </tr>
        <tr>
            <td>brinquedos</td>
            <td>1.8693565</td>
            <td>31.754784</td>
            <td>20.72289</td>
            <td>24.926294</td>
        </tr>
        <tr>
            <td>perfumaria</td>
            <td>0.52925694</td>
            <td>20.32258</td>
            <td>13.059908</td>
            <td>16.668203</td>
        </tr>
        <tr>
            <td>eletrodomesticos_2</td>
            <td>9.913333</td>
            <td>45.733334</td>
            <td>30.666666</td>
            <td>38.166668</td>
        </tr>
        <tr>
            <td>cds_dvds_musicais</td>
            <td>0.55</td>
            <td>35.0</td>
            <td>15.0</td>
            <td>25.0</td>
        </tr>
        <tr>
            <td>fashion_bolsas_e_acessorios</td>
            <td>0.42676443</td>
            <td>19.18139</td>
            <td>8.998822</td>
            <td>15.572438</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_seguranca</td>
            <td>0.95076925</td>
            <td>23.065933</td>
            <td>15.0</td>
            <td>18.989012</td>
        </tr>
        <tr>
            <td>fraldas_higiene</td>
            <td>1.0375</td>
            <td>25.0</td>
            <td>17.583334</td>
            <td>19.25</td>
        </tr>
    </tbody>
</table>



### **Average Volume of Box for each Product Category**


```sql
%%sql
WITH avg_box_volume AS(SELECT product_category,
                              AVG(volume)::real AS avg_volume
                       FROM(SELECT product_category,
                                   (product_length_cm::real * product_height_cm::real * product_width_cm::real)::real AS volume
                            FROM products
                            WHERE product_category IS NOT NULL) AS box_volume
                       GROUP BY product_category)
SELECT product_category,
       avg_volume,
       RANK() OVER(ORDER BY avg_volume DESC)
FROM avg_box_volume
```

     * postgresql://postgres:***@localhost/olist
    73 rows affected.





<table>
    <thead>
        <tr>
            <th>product_category</th>
            <th>avg_volume</th>
            <th>rank</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>moveis_colchao_e_estofado</td>
            <td>77244.3</td>
            <td>1</td>
        </tr>
        <tr>
            <td>moveis_escritorio</td>
            <td>75468.47</td>
            <td>2</td>
        </tr>
        <tr>
            <td>moveis_cozinha_area_de_servico_jantar_e_jardim</td>
            <td>69406.09</td>
            <td>3</td>
        </tr>
        <tr>
            <td>eletrodomesticos_2</td>
            <td>55476.312</td>
            <td>4</td>
        </tr>
        <tr>
            <td>moveis_sala</td>
            <td>54486.13</td>
            <td>5</td>
        </tr>
        <tr>
            <td>moveis_quarto</td>
            <td>51038.844</td>
            <td>6</td>
        </tr>
        <tr>
            <td>pcs</td>
            <td>44635.168</td>
            <td>7</td>
        </tr>
        <tr>
            <td>agro_industria_e_comercio</td>
            <td>37604.23</td>
            <td>8</td>
        </tr>
        <tr>
            <td>industria_comercio_e_negocios</td>
            <td>37372.31</td>
            <td>9</td>
        </tr>
        <tr>
            <td>malas_acessorios</td>
            <td>32950.336</td>
            <td>10</td>
        </tr>
        <tr>
            <td>bebes</td>
            <td>30835.576</td>
            <td>11</td>
        </tr>
        <tr>
            <td>la_cuisine</td>
            <td>30483.4</td>
            <td>12</td>
        </tr>
        <tr>
            <td>casa_conforto</td>
            <td>28148.73</td>
            <td>13</td>
        </tr>
        <tr>
            <td>climatizacao</td>
            <td>27910.533</td>
            <td>14</td>
        </tr>
        <tr>
            <td>eletroportateis</td>
            <td>26913.238</td>
            <td>15</td>
        </tr>
        <tr>
            <td>instrumentos_musicais</td>
            <td>25089.021</td>
            <td>16</td>
        </tr>
        <tr>
            <td>portateis_casa_forno_e_cafe</td>
            <td>23911.613</td>
            <td>17</td>
        </tr>
        <tr>
            <td>cool_stuff</td>
            <td>23246.484</td>
            <td>18</td>
        </tr>
        <tr>
            <td>pet_shop</td>
            <td>22965.066</td>
            <td>19</td>
        </tr>
        <tr>
            <td>sinalizacao_e_seguranca</td>
            <td>22583.795</td>
            <td>20</td>
        </tr>
        <tr>
            <td>moveis_decoracao</td>
            <td>22481.225</td>
            <td>21</td>
        </tr>
        <tr>
            <td>utilidades_domesticas</td>
            <td>21904.168</td>
            <td>22</td>
        </tr>
        <tr>
            <td>casa_conforto_2</td>
            <td>20938.0</td>
            <td>23</td>
        </tr>
        <tr>
            <td>casa_construcao</td>
            <td>20800.236</td>
            <td>24</td>
        </tr>
        <tr>
            <td>brinquedos</td>
            <td>19625.812</td>
            <td>25</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_iluminacao</td>
            <td>18897.256</td>
            <td>26</td>
        </tr>
        <tr>
            <td>portateis_cozinha_e_preparadores_de_alimentos</td>
            <td>18872.7</td>
            <td>27</td>
        </tr>
        <tr>
            <td>ferramentas_jardim</td>
            <td>18615.406</td>
            <td>28</td>
        </tr>
        <tr>
            <td>cama_mesa_banho</td>
            <td>18594.576</td>
            <td>29</td>
        </tr>
        <tr>
            <td>artigos_de_festas</td>
            <td>16942.73</td>
            <td>30</td>
        </tr>
        <tr>
            <td>automotivo</td>
            <td>16603.586</td>
            <td>31</td>
        </tr>
        <tr>
            <td>papelaria</td>
            <td>16240.033</td>
            <td>32</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_construcao</td>
            <td>15455.385</td>
            <td>33</td>
        </tr>
        <tr>
            <td>esporte_lazer</td>
            <td>14725.349</td>
            <td>34</td>
        </tr>
        <tr>
            <td>artigos_de_natal</td>
            <td>13947.046</td>
            <td>35</td>
        </tr>
        <tr>
            <td>eletrodomesticos</td>
            <td>13451.751</td>
            <td>36</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_jardim</td>
            <td>13399.671</td>
            <td>37</td>
        </tr>
        <tr>
            <td>cds_dvds_musicais</td>
            <td>13125.0</td>
            <td>38</td>
        </tr>
        <tr>
            <td>market_place</td>
            <td>12973.48</td>
            <td>39</td>
        </tr>
        <tr>
            <td>bebidas</td>
            <td>11217.803</td>
            <td>40</td>
        </tr>
        <tr>
            <td>artes</td>
            <td>10668.491</td>
            <td>41</td>
        </tr>
        <tr>
            <td>beleza_saude</td>
            <td>10468.159</td>
            <td>42</td>
        </tr>
        <tr>
            <td>seguros_e_servicos</td>
            <td>10233.5</td>
            <td>43</td>
        </tr>
        <tr>
            <td>fashion_roupa_masculina</td>
            <td>8798.421</td>
            <td>44</td>
        </tr>
        <tr>
            <td>fashion_calcados</td>
            <td>8478.208</td>
            <td>45</td>
        </tr>
        <tr>
            <td>fraldas_higiene</td>
            <td>8468.417</td>
            <td>46</td>
        </tr>
        <tr>
            <td>eletronicos</td>
            <td>7962.507</td>
            <td>47</td>
        </tr>
        <tr>
            <td>alimentos_bebidas</td>
            <td>7947.1636</td>
            <td>48</td>
        </tr>
        <tr>
            <td>fashion_roupa_infanto_juvenil</td>
            <td>7590.2</td>
            <td>49</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_seguranca</td>
            <td>7472.055</td>
            <td>50</td>
        </tr>
        <tr>
            <td>construcao_ferramentas_ferramentas</td>
            <td>7357.6665</td>
            <td>51</td>
        </tr>
        <tr>
            <td>tablets_impressao_imagem</td>
            <td>7182.222</td>
            <td>52</td>
        </tr>
        <tr>
            <td>fashion_roupa_feminina</td>
            <td>7165.2593</td>
            <td>53</td>
        </tr>
        <tr>
            <td>pc_gamer</td>
            <td>7074.6665</td>
            <td>54</td>
        </tr>
        <tr>
            <td>cine_foto</td>
            <td>6952.393</td>
            <td>55</td>
        </tr>
        <tr>
            <td>consoles_games</td>
            <td>6898.9053</td>
            <td>56</td>
        </tr>
        <tr>
            <td>artes_e_artesanato</td>
            <td>6895.9473</td>
            <td>57</td>
        </tr>
        <tr>
            <td>fashion_esporte</td>
            <td>6789.8945</td>
            <td>58</td>
        </tr>
        <tr>
            <td>musica</td>
            <td>6727.4814</td>
            <td>59</td>
        </tr>
        <tr>
            <td>alimentos</td>
            <td>6634.122</td>
            <td>60</td>
        </tr>
        <tr>
            <td>informatica_acessorios</td>
            <td>6483.912</td>
            <td>61</td>
        </tr>
        <tr>
            <td>flores</td>
            <td>6334.857</td>
            <td>62</td>
        </tr>
        <tr>
            <td>perfumaria</td>
            <td>5136.2188</td>
            <td>63</td>
        </tr>
        <tr>
            <td>telefonia_fixa</td>
            <td>5018.681</td>
            <td>64</td>
        </tr>
        <tr>
            <td>audio</td>
            <td>4970.1724</td>
            <td>65</td>
        </tr>
        <tr>
            <td>fashion_underwear_e_moda_praia</td>
            <td>4584.132</td>
            <td>66</td>
        </tr>
        <tr>
            <td>fashion_bolsas_e_acessorios</td>
            <td>4480.635</td>
            <td>67</td>
        </tr>
        <tr>
            <td>livros_interesse_geral</td>
            <td>3900.0464</td>
            <td>68</td>
        </tr>
        <tr>
            <td>relogios_presentes</td>
            <td>3470.398</td>
            <td>69</td>
        </tr>
        <tr>
            <td>livros_tecnicos</td>
            <td>2758.992</td>
            <td>70</td>
        </tr>
        <tr>
            <td>livros_importados</td>
            <td>1935.3871</td>
            <td>71</td>
        </tr>
        <tr>
            <td>telefonia</td>
            <td>1865.8413</td>
            <td>72</td>
        </tr>
        <tr>
            <td>dvds_blu_ray</td>
            <td>1746.8541</td>
            <td>73</td>
        </tr>
    </tbody>
</table>



### **Correlation between freight value and product weight, length, height, volume and price**


```sql
%%sql
WITH product_freight 
       AS(SELECT oi.freight_value,
       pr.product_weight_grams,
       pr.product_length_cm,
       pr.product_height_cm,
       pr.product_width_cm,
       pr.product_length_cm::real * pr.product_height_cm::real * pr.product_width_cm::real AS volume,
       oi.price
FROM products pr
JOIN order_items oi USING(product_id))
SELECT CORR(freight_value, product_length_cm)::real AS corr_length,
       CORR(freight_value, product_height_cm)::real AS corr_height,
       CORR(freight_value, product_width_cm)::real AS corr_width,
       CORR(freight_value, volume)::real AS corr_volume,
       CORR(freight_value,product_weight_grams)::real AS corr_weight,
       CORR(freight_value, price)::real AS corr_price
FROM product_freight
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>corr_length</th>
            <th>corr_height</th>
            <th>corr_width</th>
            <th>corr_volume</th>
            <th>corr_weight</th>
            <th>corr_price</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>0.30908597</td>
            <td>0.39183104</td>
            <td>0.32377744</td>
            <td>0.5872701</td>
            <td>0.6104202</td>
            <td>0.4142043</td>
        </tr>
    </tbody>
</table>



**Correlation between unit sold and photo quantity** 


```sql
%%sql
WITH unit_photos AS(SELECT product_id,
                           unit_sold,
                           product_photos_qty
                    FROM (SELECT *
                          FROM (SELECT product_id,
                                       SUM(order_item_id) as unit_sold    
                                FROM orders
                                JOIN order_items USING(order_id)
                                WHERE order_status='delivered'
                                GROUP BY product_id) AS unit_sold
                                ORDER BY unit_sold DESC) AS product_units
                          JOIN products USING(product_id))
SELECT CORR(unit_sold, product_photos_qty)::real
FROM unit_photos
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>corr</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>-0.006174032</td>
        </tr>
    </tbody>
</table>



### **Linear Relationship between freight value and product weight**


```sql
%%sql
WITH price_freight AS (SELECT product_category, 
                       freight_value,
                       (product_weight_grams/1000)::real AS weight
                       FROM order_items
                       JOIN products using(product_id))
SELECT regr_slope(freight_value,weight)::real AS slope,
       regr_intercept(freight_value,weight)::real AS intercept
FROM price_freight
LIMIT 10
```

     * postgresql://postgres:***@localhost/olist
    1 rows affected.





<table>
    <thead>
        <tr>
            <th>slope</th>
            <th>intercept</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>2.575215</td>
            <td>15.649705</td>
        </tr>
    </tbody>
</table>




```python

```
