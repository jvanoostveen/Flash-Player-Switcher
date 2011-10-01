CREATE TABLE IF NOT EXISTS flashplayers 
(
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	name TEXT, 
	version TEXT, 
	debugger BOOLEAN, 
	hash TEXT
)
