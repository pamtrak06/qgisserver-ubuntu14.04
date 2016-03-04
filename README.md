# What is qgis server ?

[A Free and Open Source Geographic Information System.](http://www.qgis.org/) under [GPL licence](http://docs.qgis.org/2.6/fr/docs/user_manual/appendices/appendices.html#gnu-general-public-license).

# Install qgis

Installation procedure are comming from several sites :
 - http://www.makina-corpus.org/blog/qgis-server-premiers-pas
 - http://hub.qgis.org/projects/quantum-gis/wiki/QGIS_Server_tutorial
 - http://www.digital-geography.com/install-qgis-2-0-on-ubuntu/
 - https://www.qgis.org/fr/site/forusers/alldownloads.html
 

#How to use this image

##Build qgis server docker image

This image is built under ubuntu 14.04.

```
docker build -t pamtrak06/qgisserver-ubuntu14.04 https://github.com/pamtrak06/qgisserver-ubuntu14.04.git
```

## Run qgis server docker container

Run container
```
$ docker run -d -p 80:80 -p 22:22 pamtrak06/qgisserver-ubuntu14.04 https://raw.githubusercontent.com/pamtrak06/qgisserver-ubuntu14.04/master/Dockerfile
```

Open a terminal session on a running container
```
$ docker ps
$ docker exec -i -t pamtrak06/qgisserver-ubuntu14.04 /bin/bash
```

Exit container without stop it
```
CTRL+P  &  CTRL+Q
```

Get docker vm ip : 
```
$ boot2Docker ip => 192.168.59.103
```

# Configure qgis server

Edit the /usr/lib/cgi-bin/wms_metadata.xml file and edit the metadata (not mandatory).
Create a subdirectory in /usr/lib.cgi-bin/ with the name of your project.
Copy your project on the server (in /var/www/data/<project name>.qgs, with data (SHP, or if there is data in database, it must be accessible). Then run the following commands:

```
$ cd /usr/lib/cgi-bin/<project name>/
$ ln -s /var/www/data/<project name>.qgs .
$ ln -s ../qgis_mapserv.fcgi .
$ ln -s ../wms_metadata.xml .
```

# Test qgis services

Server is ready, test following url :
http://{docker ip}/cgi-bin/<project name>/qgis_mapserv.fcgi?SERVICE=WMS&REQUEST=GetCapabilities

This request must return an XML description of available layers.
The service can be called according to the WMS protocol from any client.
The layers are available that you set in your QGis project.

For more information about configuration, see http://www.makina-corpus.org/blog/qgis-server-premiers-pas

# Licence

http://docs.qgis.org/2.6/fr/docs/user_manual/appendices/appendices.html#gnu-general-public-license

