TABLES scarr.

TYPES: BEGIN OF ty_alv,
         carrid     TYPE s_carr_id,
         carrname   TYPE s_carrname,
         currcode   TYPE s_currcode,
         connid     TYPE s_conn_id,
         countryfr  TYPE land1,
         cityfrom   TYPE s_from_cit,
         countryto  TYPE land1,
         cityto     TYPE s_to_city,
         fldate     TYPE s_date,
         price      TYPE s_price,
         planetype  TYPE s_planetye,
         seatsmax   TYPE s_seatsmax,
         seatsocc   TYPE s_seatsocc,
         bookid     TYPE s_book_id,
         customid   TYPE s_customer,
         custtype   TYPE s_custtype,
         smoker     TYPE s_smoker,
         luggweight TYPE s_lugweigh,
       END OF ty_alv.

TYPES: tt_alv  TYPE STANDARD TABLE OF ty_alv.

DATA gt_alv TYPE STANDARD TABLE OF ty_alv.
