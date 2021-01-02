import psycopg2


# Login details for database user
dbname = ""
user = ""
pwd = "" 

# Gather all connection info into one string
connection = \
    "host='dbpg-ifi-kurs01.uio.no' " + \
    "dbname='" + dbname + "' " + \
    "user='" + user + "' " + \
    "port='5432' " + \
    "password='" + pwd + "'"

def administrator():
    conn = psycopg2.connect(connection)

    ch = 0
    while (ch != 3):
        print("-- ADMINISTRATOR --")
        print("Please choose an option:\n 1. Create bills\n 2. Insert new product\n 3. Exit")
        ch = get_int_from_user("Option: ", True)

        if (ch == 1):
            make_bills(conn)
        elif (ch == 2):
            insert_product(conn)

def make_bills(conn):
   print("-- BILLS --")
   input_username = input("Username: ")
   q = "select u.name, u.address, sum(p.price*o.num) " + \
	"from ws.users as u inner join ws.orders as o using(uid)" + \
	"inner join ws.products as p using(pid)" + \
	"where o.payed = 0 and u.username LIKE %(input_username)s "

   q += "group by u.name, u.address "
   q += ";"
   cur = conn.cursor()


   if(input_username != ""):
        cur.execute(q,{'input_username': "%"+input_username+"%"})
   else:
       cur.execute(q,{'input_username': "%"+""+"%"})


   rows = cur.fetchall()
   if (rows == []):
        print("No results.")
        return


   for row in rows:
        print( "\n" + \
		"---Bill--- \n" + \
                "Name:" + str(row[0]) + "\n" + \
                "Address: " + str(row[1]) + "\n" + \
                "Total due: " + str(row[2]) )
   exit()

def insert_product(conn):
    print("-- INSERT NEW PRODUCT --")
    p_name = input("Product name: ")
    price = input("Price: ")
    category = input("Category: ")
    description = input("Description: ")
    cur = conn.cursor()
    if(category != ""):
    	cur.execute(f"select cid from ws.categories where name like '%{category}%';")
    	cid = cur.fetchall()
    else:
        print("Error: select between these categories: food,electronics,clothing,games.")
        exit()
    cur.execute("INSERT INTO ws.products(name,price,cid,description) VALUES (%s, %s, %s,%s);",
		(p_name,price,cid[0],description))
    conn.commit()

    print(f"New product {p_name} inserted.")
    exit()


def get_int_from_user(msg, needed):
    # Utility method that gets an int from the user with the first argument as message
    # Second argument is boolean, and if false allows user to not give input, and will then
    # return None
    while True:
        numStr = input(msg)
        if (numStr == "" and not needed):
            return None;
        try:
            return int(numStr)
        except:
            print("Please provide an integer or leave blank.");


if __name__ == "__main__":
    administrator()
