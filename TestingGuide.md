#summary A Guide to Tests that come with the Camelbox distribution
#labels Phase-ImplementationPhase-QA

[CamelBox Home Page](http://code.google.com/p/camelbox)


# Guide to Testing in Camelbox #

## What should be tested ##
  * JSON package list loads and is valid?
  * GTK C Application runs, displays simple window
  * Gtk2-Perl Demos run
    * Gtk2::GladeXML
    * Gtk2::GnomeCanvas
    * Gtk2::GooCanvas
  * SQLite test script can run against a testing database; insert, select, update, delete row
    * [Getting started in SQLite](http://www.sqlite.org/sqlite.html)
  * MySQL test script can run against a testing database; insert, select, update, delete row
  * PostgreSQL test script can run against a testing database; insert, select, update, delete row
  * ODBC test script can run against a testing database; insert, select, update, delete row
  * XML file can be parsed with expat wrapper module; test data in XML file

## Testing Library/Network Issues ##

### Network debugging ###
  * Netcat for Windows (version 1.11)
    * [pintday.org](http://pintday.org/downloads/netcat/nc11nt.zip)
    * [joncraton.org](http://joncraton.org/files/nc111nt.zip)

### Windows Tools ###
#### Library/File Usage ####
  * Dependency Walker - You can use [Dependency Walker](http://www.dependencywalker.com/) to help figure out what extra libraries need to be a part of the PAR package (taken from this [Perl Monks article on shipping apps on Win32](http://perlmonks.org/index.pl?node_id=215299)).
  * [Windows SysInternals](http://technet.microsoft.com/en-us/sysinternals/default.aspx) - main site
    * [ListDLLs](http://technet.microsoft.com/en-us/sysinternals/bb896656.aspx) - Microsoft Technet
    * [ProcessExplorer](http://technet.microsoft.com/en-us/sysinternals/bb896653.aspx) - examine processes and files that they have open/loaded
  * Description of using [strace](http://yong321.freeshell.org/computer/orawintrace.html) to debug Oracle problems on Windows

#### ODBC ####
  * [ODBCView](http://www.sliksoftware.co.nz/products/odbcview/index.htm)

#### SQLServer ####
  * [SQL2005 Service Manager](http://www.sqldbatips.com/showarticle.asp?ID=46)

#### Misc ####
  * [Console](http://sourceforge.net/projects/console)

## Test Setup ##
There is a [Putty profile](http://camelbox.googlecode.com/svn/trunk/tests/test_db_server.reg) that forwards all of the network ports used for the database s below to a server that can be used for testing.

## Tests that start with 00 ##
Tests that exercise basic functionality

## Tests that start with 10 ##
Basic tests for modules

## Postgres ##
```
# become the DB admin user
sudo su - postgres
# create a user
postgres@calavera:~$ createuser <username>
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) y
Shall the new role be allowed to create more new roles? (y/n) n
CREATE ROLE
postgres@hostname:~$ psql
postgres=# alter role username with encrypted password 'l33tp@$$w0rd';
ALTER ROLE
postgres=# create database camelbox;
CREATE DATABASE
```

User `username` should now be able to log in with the password `l33tp@$$w0rd`.
If MD5 password hashing is turned on, the client will automagically hash the
password before sending it to the remote server.

```
postgres@calavera:~$ psql -U username -h 127.0.0.1 -p 15432 -d camelbox
```

### PostgreSQL Links ###
User Management
  * http://www.postgresql.org/docs/8.1/interactive/index.html
  * http://www.postgresql.org/docs/8.1/interactive/role-attributes.html
  * http://www.postgresql.org/docs/8.1/interactive/user-manag.html
  * http://www.postgresql.org/docs/8.1/interactive/tutorial-createdb.html
  * http://www.postgresql.org/docs/8.1/interactive/sql-alterrole.html
DDL
  * http://www.postgresql.org/docs/8.1/interactive/ddl.html
Windows ODBC Driver:
  * MSI: http://www.postgresql.org/ftp/odbc/versions/msi/
  * DLL zipfile: http://www.postgresql.org/ftp/odbc/versions/dll/

## MySQL ##

```
[hostname][user ~]$ mysql -u root -p -h 127.0.0.1 -P 13306
mysql> create user 'username'@'hostname' identified by 'l33tp@$$w0rd';
Query OK, 0 rows affected (0.00 sec)
mysql> create database camelbox;
Query OK, 1 row affected (0.00 sec)
mysql> grant all on camelbox.* to 'username'@'localhost' identified by 'l33tp@$$w0rd';
Query OK, 0 rows affected (0.00 sec)
mysql> \q

[hostname][user ~]$ mysql -u username -p -h 127.0.0.1 -P 13306
```

### MySQL Links ###
User Management
  * http://dev.mysql.com/doc/refman/5.0/en/index.html
  * http://dev.mysql.com/doc/refman/5.0/en/adding-users.html
  * http://dev.mysql.com/doc/refman/5.0/en/create-user.html
DDL
  * http://dev.mysql.com/doc/refman/5.0/en/data-types.html
  * http://dev.mysql.com/doc/refman/5.0/en/storage-requirements.html
  * http://dev.mysql.com/doc/refman/5.0/en/other-vendor-data-types.html
ODBC Driver for Windows:
  * http://dev.mysql.com/downloads/connector/odbc/5.1.html#win32
## SQLite ##

```
sqlite database_name.db
```

### SQLite Links ###
  * Usage example: http://www.sqlite.org/sqlite.html
  * DDL: http://www.sqlite.org/lang.html
  * Datatypes: http://www.sqlite.org/datatype3.html
  * ODBC Driver for Windows: http://www.ch-werner.de/sqliteodbc/

## ODBC ##

### ODBC Links ###
  * [Easysoft Linux/UNIX ODBC](http://www.easysoft.com/developer/interfaces/odbc/linux.html#odbc_apps_perl) - Links to using ODBC in Perl
  * [Easysoft DBI/DBD::ODBC Tutorial Part 1](http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_1.html)
  * [Easysoft DBI/DBD::ODBC Tutorial Part 2](http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html)
  * [Joe Casadonte's article in The Perl Journal on Win32::ODBC](http://www.foo.be/docs/tpj/issues/vol3_1/tpj0301-0008.html)
  * [SQL Data Types in Access](http://msdn.microsoft.com/en-us/library/bb208866(loband).aspx)

<a href='Hidden comment: 
vi: set filetype=googlecodewiki shiftwidth=2 tabstop=2 paste:
'></a>