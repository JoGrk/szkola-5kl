CREATE TABLE clients(
    name varchar(25),
    address varchar(25),
    city varchar(25),
    zip varchar(10),
    client_type varchar(4)
);
1. Przekopiuj kod tworzący tabelę clients. Zakładamy, że tabela zawiera dane, dlatego zanim zaczniemy modyfikację, należy zrobić kopię zapasową tej tabeli. Zrób ją z poziomu wiersza poleceń.
mysqldump -u root 4e_2_clients clients > clients_kopie.sql

2. Sprawdź działanie kopii zapasowej. Usuń tabelę i odtwórz korzystając z wiersza poleceń i przekierowania. 
 DROP TABLE clients;
 mysql -u root 4e_2_clients < clients_kopie.sql

3. Dodaj do tabeli pole status - dwuznakowy tekst o stałej długości oraz pole state tego samego typu, oba pola nie mogą być puste.
ALTER TABLE clients
ADD status char(2) NOT NULL,
ADD state char(2) NOT NULL;

4. Za polem address dodaj address2 (255 znaków)
ALTER TABLE clients
ADD address2 varchar(255) AFTER address;

5. Przesuń pole state tak, aby było za polem city 
ALTER TABLE clients
MODIFY state char(2) AFTER city;

6. Dodaj na początku pole cust_id, całkowite, klucz podstawowy
ALTER TABLE clients
ADD cust_id int PRIMARY KEY FIRST;

7. Zmień nazwę pola address na address1 jednocześnie zwiększając ilość znaków do 50
ALTER TABLE clients
CHANGE address address1 varchar(50);

8. Zmień nazwę pola status na active jednocześnie zmieniając jego typ: powinien być to typ wyliczeniowy (enum) o dwóch wartościach 'AC' oraz 'IA'
 ALTER TABLE clients
 CHANGE status active enum('AC','IA');

9. Zakładamy, że w tabeli mamy (dużo) danych. Decydujemy zmienić typ pola activ i wartości na 'yes' dla 'AC' oraz 'no' dla 'IA'. (najpierw zmień typ poszerzając wartości enum, potem zmień dane w tabeli, potem zmień typu enum zawężając wartości)
ALTER TABLE clients
MODIFY active enum('AC','IA','YES','NO');

UPDATE clients
SET active = 'YES'
WHERE active = 'AC';

UPDATE clients
SET active = 'NO'
WHERE active = 'IA';

ALTER TABLE clients
MODIFY active enum('YES','NO');

10. Usuń pole client_type
ALTER TABLE clients
DROP client_type;

11.Ustaw domyślną wartość state na 'LA' oraz domyślną wartość city na 'New Orleans'
ALTER TABLE clients
ALTER state SET DEFAULT 'LA',
ALTER city SET DEFAULT 'New Orleans';

12. dodaj więzy: dopuszczalne wartości pola state to LA, CO, KY,CA
ALTER TABLE clients
ADD CONSTRAINT chk_state CHECK(state in ('LA', 'CO', 'KY', 'CA'));

13. Dodaj więzy: wartości w polu zip nie mogą się powtarzać.
ALTER TABLE clients
ADD CONSTRAINT u_zip UNIQUE(zip);

14. Jednak chcemy, aby wartosci w polu zip się powtarzały.
ALTER TABLE clients
DROP CONSTRAINT u_zip;

15. usuń domyślną wartość dla city
ALTER TABLE clients
ALTER city 

16. Zmień nazwę pola cust_id na client_id.


17. Czy mamy jakieś indeksy w tabeli? 


18. Dodaj index na polu city


19. Dodaj unikatowy index na polu name


20. Utwórz index na polach address1 i address2


21. Zmień nazwę tabeli clients na client_addresses


22. Usuń index z pól address1 i address2


23. Przenieś tabelę client_addresses do dowolnej innej bazy danych
