import random 
from faker import Faker
fake = Faker()

inserts = ""
removes = ""
ids = []

for i in range(20):
    name = fake.name().split()
    insert = "insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values ("+ str(3000 + i) +",'" + name[1] + "','"+ name[0] +"','x5000','"+ name[0] + "."+ name[1] + "@pwr.edu.pl" +"','" + str(random.randint(1, 7))   + "',1102,'`TEST`');"
    inserts += insert + "\n"
    remove = "delete from employees where employeenumber = " + str(3000 + i) + ";"
    removes += remove + "\n"
    ids.append(str(3000 + i))


print(inserts)
print()
print(removes)
