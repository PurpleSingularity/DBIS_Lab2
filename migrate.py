import psycopg2
import csv
import connect
import os
import upload
import time

querry = ("""SELECT AVG(ball100) as ball, regname, "year"
FROM 
(
	place JOIN znoresult 
	ON place.placeID = znoresult.placeid
)
WHERE SubjectID = 'Phys'
AND teststatus = 'Зараховано'
GROUP BY regname, "year"
ORDER BY regname, "year";""")

if __name__ == '__main__':



    conn = connect.connect()
    print(conn)
    upload.do_querry(querry,conn)


    connect.disconnect(conn)