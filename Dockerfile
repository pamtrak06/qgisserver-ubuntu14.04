FROM pamtrak06/ubuntu14.04-apache2 

# installation instructions from http://www.makina-corpus.org/blog/qgis-server-premiers-pas 

# update os and install utilities
RUN apt-get update 

# add qgis components
RUN echo "deb http://qgis.org/debian trusty main" >> /etc/apt/sources.list
RUN echo "deb-src http://qgis.org/debian trusty main" >> /etc/apt/sources.list

RUN apt-get install -y qgis-mapserver libapache2-mod-fcgid qgis
RUN chmod 755 /usr/lib/cgi-bin/qgis_mapserv.fcgi

# configure qgis server
# RUN vi /usr/lib/cgi-bin/wms_metadata.xml
# RUN mkdir /usr/lib.cgi-bin/<project name>
# RUN cp <project name>.qgs *.shp /var/www/data/

# RUN cd /usr/lib/cgi-bin/<project name>/
# RUN ln -s /var/www/data/<project name>.qgs .
# RUN ln -s ../qgis_mapserv.fcgi .
# RUN ln -s ../wms_metadata.xml .


# enable cgi in apache2
RUN a2enmod cgid

# restart apache2
RUN sudo service apache2 restart

# expose port 80 
EXPOSE 80

# run apache
CMD [apache2ctl start]


