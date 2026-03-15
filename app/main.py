from fastapi import FastAPI
import sqlite3

app = FastAPI()

DB = "tasks.db"

def init_db():
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS tasks(id INTEGER PRIMARY KEY, name TEXT)")
    conn.commit()
    conn.close()

init_db()

@app.post("/tasks")
def create_task(task: dict):
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO tasks(name) VALUES(?)", (task["name"],))
    conn.commit()
    conn.close()
    return {"message": "task created"}

@app.get("/tasks")
def get_tasks():
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    tasks = cursor.execute("SELECT * FROM tasks").fetchall()
    conn.close()
    return {"tasks": tasks}
