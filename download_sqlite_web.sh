#!/bin/bash

# Create web directory if it doesn't exist
mkdir -p web

# Download SQLite worker files
curl -o web/sqlite3.js https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqlite3.js
curl -o web/sqflite_sw.js https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqflite_sw.js
curl -o web/sqlite3.wasm https://raw.githubusercontent.com/simolus3/sqlite3.dart/master/sqlite3/wasm/sqlite3.wasm 