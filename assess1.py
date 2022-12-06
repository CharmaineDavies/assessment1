import psycopg2

print("Welcome to the phone list, the following commands are available:")
print("LIST, ADD, DELETE, QUIT")

conn = psycopg2.connect(
   host="localhost",
   port="5432",
   database="assessmentdb",
   user="postgres",
   password="Philip1986??"
)

def read_dict(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM contacts;")
    rows = cur.fetchall()
    cur.close()
    return rows
def add_word(conn, id, first_name, last_name, title, organization):
    cur = conn.cursor()
    cur.execute(f"INSERT INTO contacts (id, first_name, last_name, title, organization) VALUES ('{id}', '{first_name}', '{last_name}', '{title}', '{organization}');")
    cur.close()
    print(f"{first_name} added!")
def delete_word(conn, first_name):
    cur = conn.cursor()
    cur.execute(f"DELETE FROM contacts WHERE id = '{first_name}';")
    cur.close()
def save_dict(C):
    cur = conn.cursor()
    cur.execute("COMMIT;")
    cur.close()

while True: 
    cmd = input("Command: ")
    if cmd == "LIST":
        print(read_dict(conn))
    elif cmd == "ADD":
        id = int(input("  Id: "))
        first_name = input("  First name: ")
        last_name = input("  Last name: ")
        title = input("  Title: ")
        organization = input("  Organization: ")
        add_word(conn, id, first_name, last_name, title, organization)
    elif cmd == "DELETE":
        first_name = input("  First name: ")
        delete_word(conn, first_name)
    elif cmd == "QUIT":
        save_dict(conn)
        exit()