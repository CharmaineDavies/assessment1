import psycopg2

print("Welcome to the contacts, the following commands are available:")
print("LIST, INSERT, DELETE, SAVE")

conn = psycopg2.connect(
   host="localhost",
   port="5432",
   database="assessmentdb",
   user="postgres",
   password="Philip1986??"
)
# functions to list, add and delete contacts made
def read_dict(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM contacts;")
    rows = cur.fetchall()
    cur.close()
    return rows
# two contacts added
def add_word(conn, id, first_name, last_name, title, organization):
    cur = conn.cursor()
    cur.execute(f"INSERT INTO contacts (id, first_name, last_name, title, organization) VALUES ('{id}', '{first_name}', '{last_name}', '{title}', '{organization}');")
    cur.close()
    print(f"{first_name} added!")
# contact deleted
def delete_word(conn, first_name):
    cur = conn.cursor()
    cur.execute(f"DELETE FROM contacts WHERE first_name = ('{first_name}');")
    cur.close()
    print(f"{first_name} deleted!")
# loop made
def save_dict(conn):
    cur = conn.cursor()
    cur.execute("COMMIT;")
    cur.close()
while True: 
    cmd = input("Command: ")
    if cmd == "LIST":
        print(read_dict(conn))
    elif cmd == "INSERT":
        id = int(input("  Id: "))
        first_name = input("  First name: ")
        last_name = input("  Last name: ")
        title = input("  Title: ")
        organization = input("  Organization: ")
        add_word(conn, id, first_name, last_name, title, organization)
    elif cmd == "DELETE":
        first_name = input("  First name: ")
        delete_word(conn, first_name)
    elif cmd == "SAVE":
        save_dict(conn)
        exit()