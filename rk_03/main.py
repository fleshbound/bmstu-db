from peewee import *
import datetime as dt

# connection, (peewee)model -> basemodel -> tables + local meta (table_name)
db = PostgresqlDatabase(
    'rk_03',
    user='postgres',
    host='127.0.0.1',
    password='postgres'
)

class BaseModel(Model):
    class Meta:
        database = db

class Employees(BaseModel):
    id = IntegerField(column_name='id')
    name = TextField(column_name='name')
    birthday = DateTimeField(column_name='birthday')
    department = TextField(column_name='department')

    class Meta:
        table_name = 'Employees'

class InOuts(BaseModel):
    id = IntegerField(column_name='id')
    emp_id = IntegerField(column_name='emp_id')
    sysdate = DateTimeField(column_name='sysdate')
    systime = DateTimeField(column_name='systime')
    type = IntegerField(column_name='type')

    class Meta:
        table_name = 'InOuts'

# найти самого старшего работника бухгалтерии
def task1():
    # sql
    res_query = db.execute_sql("""
        select *
        from Employees
        where department = 'Бухгалтерия'
        order by birthday
        limit 1
    """)
    for r in res_query:
        print(r)

    # orm
    res_query = Employees.select().where(department == 'Бухгалтерия').order_by(birthday)
    print(res_query[0])

# найти сотрудников, выходивших более 3-х раз с рабочего места
def task2():
    # sql
    res_query =  db.execute_sql("""
        select *
        from Employees
        where id in (
            select IO.emp_id
            from Employees e join InOuts IO on e.id = IO.emp_id
            where io.type = 1
            group by IO.emp_id
            having count(*) >= 4
        )
    """)
    for r in res_query:
        print(r)

    # orm
    res_query = (Employees
                 .select(Employees)
                 .join(InOuts)
                 .where(InOuts.type == 1)
                 .group_by(InOuts.emp_id)
                 .having(fn.Count(InOuts.id) >= 4)
    for r in res_query:
        print(r)

# найти сотрудников, опоздавших сегодня меньше, чем на 10 минут
def task3():
    # sql
    res_query =  db.execute_sql("""
            select *
            from Employees
            where id in (
                select
                from Employees e join InOuts IO on e.id = IO.emp_id
                where
                limit 1
            )
        """)
    for r in res_query:
        print(r)

    # orm
    res_query = (Employees
                .select(Employees)
                .join(InOuts)
                .where(InOuts.systime - '09:00:00' > '00:10:00')
                .where(InOuts.type == 1))
    for r in res_query:
        print(r)

def main():
    task1()
    task2()
    task3()

if __name__ == '__main__':
    main()