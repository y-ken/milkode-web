# milkode-web

It is a bundler template of Milkode web application for apache passenger.

## What's this?

The [Milkode](http://milkode.ongaeshi.me/wiki/Main_Page) is a fulltext source code search engine to look up keywords from up to thousands of your codes instantly.  
This package helps you to use Apache Passenger with Milkode.

## Quick Start (Japanese)
日本語記事はこちらです。  
[groonga(rroonga)を利用したソースコード全文検索エンジン"Milkode"をApache Passengerで軽快に動かす方法](http://y-ken.hatenablog.com/entry/how-to-install-milkode-with-passenger)  
http://y-ken.hatenablog.com/entry/how-to-install-milkode-with-passenger

## Quick Start

It's a quick start guide to install milkode under the `/var/www/html/`.  
And directory design is below.  

|Path|the contents of the directory|
|:---|:---|
|./milkode/data/|rroonga fulltext database files|
|./milkode/source/|raw source code to input database|
|./milkode/public/|DocumentRoot|
|./milkode/vendor/bundle/|bundler modules|


### Step1. Install Milkode from template

```
$ cd /var/www/html
$ git clone https://github.com/y-ken/milkode-web.git milkode
$ cd /var/www/html/milkode
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

**Note:** When you kick `milk add`, You have to jump database directory such as `/var/www/html/milkode/data`.

```
# put source codes into source directory.
$ cd /var/www/html/milkode/source
$ git clone https://github.com/twitter/bootstrap.git
$ git clone https://github.com/twitter/typeahead.js.git
$ cd /var/www/html/milkode/data

# load data to milkode.db
$ bundle exec milk add ../source/bootstrap/
package    : bootstrap
result     : 1 packages, 146 records, 146 add. (1.25sec)
*milkode*  : 1 packages, 146 records in /var/www/html/milkode/data/db/milkode.db.
$ bundle exec milk add ../source/typeahead.js
package    : typeahead.js
result     : 1 packages, 41 records, 41 add. (0.39sec)
*milkode*  : 2 packages, 187 records in /var/www/html/milkode/data/db/milkode.db.

# confirm package list
$ bundle exec milk list
bootstrap
typeahead.js
*milkode*  : 2 packages, 187 records in /var/www/html/milkode/data/db/milkode.db.
```


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

![MilkodeWebApplication](http://cdn-ak.f.st-hatena.com/images/fotolife/y/yoshi-ken/20130501/20130501132045.png)

Thant's all. finished.

## Copyright
Copyright © 2013- @yoshi_ken

## License
Apache License, Version 2.0
