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
$ docker run -d -p 80:80 -p 22:22 pamtrak06/rok4-ubuntu14.04
```

Open a terminal session on a running container
```
$ docker ps
$ docker exec -i -t pamtrak06/rok4-ubuntu14.04 /bin/bash
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

Editez le fichier /usr/lib/cgi-bin/wms_metadata.xml, et modifiez les metadonnées (non obligatoire).
Créez un sous-répertoire dans /usr/lib.cgi-bin/ du nom de votre projet (ex: world/).
Copier votre projet .qgs sur le serveur (dans /var/www/data/world.qgs par exemple), acoompagné des données (SHP, ou s'il s'agit de données en BDD, il faut biensur avoir la base accessible).
Exécutez ensuite les commandes suivantes :

```
$ cd /usr/lib/cgi-bin/world/
$ ln -s /var/www/data/world.qgs .
$ ln -s ../qgis_mapserv.fcgi .
$ ln -s ../wms_metadata.xml .
```

# Test qgis services

Le serveur est prêt. Pour s'en assurer, tapez l'url suivante dans un navigateur :

http://{docker ip}/cgi-bin/world/qgis_mapserv.fcgi?SERVICE=WMS&REQUEST=GetCapabilities
Cette requête doit vous retourner un XML de description des couches disponibles.
Le service peut alors être appelé suivant le protocole WMS depuis n'importe quel client.
Les couches disponibles sont celle que vous avez défini dans votre projet QGis.

For more information about configuration, see http://www.makina-corpus.org/blog/qgis-server-premiers-pas

# Licence

http://docs.qgis.org/2.6/fr/docs/user_manual/appendices/appendices.html#gnu-general-public-license
