# Create web directory if it doesn't exist
New-Item -ItemType Directory -Force -Path web

# Download SQLite worker files
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqlite3.js" -OutFile "web/sqlite3.js"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqflite_sw.js" -OutFile "web/sqflite_sw.js"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqlite3.wasm" -OutFile "web/sqlite3.wasm" 