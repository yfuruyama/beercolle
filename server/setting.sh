## Add what you think useful for us freely :D

# General
export PATH=$HOME/beercolle/local/bin:$PATH

# MySQL
mysql_basedir=$HOME/local/mysql-5.6
mysql_datadir=$HOME/beercolle/mysql/data
mysql_my_cnf=$HOME/beercolle/mysql/conf/my.cnf
alias mysql="$mysql_basedir/bin/mysql --defaults-file=$mysql_my_cnf"
alias mysqld="$mysql_basedir/bin/mysqld --defaults-file=$mysql_my_cnf"
