# milkode-web

Milkode web application template for apache passenger

# What's this?

The [Milkode](http://milkode.ongaeshi.me/wiki/Main_Page) is a source code search engine to look up keywords from up to thousands of your codes instantly.
This package helps you to use Apache Passenger with Milkode.

# Quick Start

It's a quick start guide to install milkode under the `/var/www/html/`.  
And directory design is below.  

|Path|the contents of the directory|
|:---|:---|
|./milkode/data/|rroonga fulltext database files|
|./milkode/source/|raw source code to input database|
|./milkode/public/|DocumentRoot|
|./milkode/vendor/bundle/|bundle modules|


### Step1. Install Milkode from template


```
$ cd /var/www/html
$ git clone https://github.com/y-ken/milkode-web.git milkode
$ cd milkode
$ bundle install --path vendor/bundle
```

### Step2. Initialize Milkode Database

```
cd /var/www/html/milkode
$ bundle exec milk init data
```

### Step3. Adding contents to Milkode Database

This part is adding source code anything you like.  
You can put any source codes in `./milkode/data/`.  
This sample use `github.com/ongaeshi/milkode` for test.

```
$ cd /var/www/html/milkode/source
$ git clone https://github.com/ongaeshi/milkode.git
$ cd /var/www/html/milkode/data
$ bundle exec milk add ../source/milkode
package    : milkode
result     : 1 packages, 140 records, 140 add. (0.75sec)
*milkode*  : 1 packages, 140 records in /var/www/html/milkode/data/db/milkode.db.
```
**Note:** When you kick `milk add`, You have to jump database directory such as `/var/www/html/milkode/data`.

### Step4. Apache Configuration

put your configuration to `virtualhosts.conf` like this.

```
$ cat /etc/httpd/conf.d/virtualhost.conf
<VirtualHost *:80>
   ServerName milkode.example.com
   DocumentRoot /var/www/html/milkode/public
   PassengerHighPerformance on
   SetEnv MILKODE_DEFAULT_DIR /var/www/html/milkode/data
</VirtualHost>
```

and restart apache.

```
$ sudo /etc/init.d/httpd restart
```

### Step5. Check it on you browser

open url like `http://milkode.example.com/` which you specified.  
It works fine if you saw milk bottle icon.