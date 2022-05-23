
/* Creating order datatable */
CREATE TABLE orders(
    order_id varchar(50),
    customer_id varchar(50),
    order_status varchar(20),
    order_purchase timestamp,
    order_approved timestamp,
    order_delivered_carrier timestamp,
    order_delivered_customer timestamp,
    order_estimated_delivery timestamp,
    CONSTRAINT order_key PRIMARY KEY (order_id)
);

/* Creating order_payments datatable */
CREATE TABLE order_payments(
    order_id varchar(50) REFERENCES orders (order_id),
    payment_sequential smallint,
    payment_type varchar(20),
    payment_installments smallint,
    payment_value double precision
);

/* Creating order_review datatable */
CREATE TABLE order_reviews(
    review_id varchar(50),
    order_id varchar(50) REFERENCES orders (order_id), 
    review_score smallint,
    review_title text,
    review_comment text,
    review_create timestamp,
    review_answer timestamp
);

/* Creating customers datatable */
CREATE TABLE customers(
    customer_id varchar(50),
    customer_unique_id varchar(50),
    customer_zipcode char(5),
    customer_city varchar(25),
    customer_state char(2),
    CONSTRAINT customer_key PRIMARY KEY (customer_id)
    CONSTRAINT 
);

/* USE ALTER TABLE to add foreign key constrain to order table */
ALTER TABLE orders ADD CONSTRAINT customer_id FOREIGN KEY (customers) REFERENCES customers (customer_id);




















