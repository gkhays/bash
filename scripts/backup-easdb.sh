#!/bin/sh

export PATH=/opt/gkh/postgresql/bin:$PATH
export PGDATA=/opt/gkh/postgresql/data
export PGDATABASE=postgres
export PGUSER=postgres
export PGPORT=5432
export PGLOCALEDIR=/opt/gkh/postgresql/share/locale
export PGPASSFILE=pgpass

export LD_LIBRARY_PATH=/opt/gkh/postgresql/lib/
export LOGFILENAME=backup-log.txt
export BACKUPFILENAME=postgres-backup.sql
export BACKUPFILE=./$BACKUPFILENAME

echo "Starting backup `date`" > $LOGFILENAME

# Dump the database
echo "`date` -- Dump the database" > $LOGFILENAME
pg_dump --username=postgres MYDB > $BACKUPFILE

# Mount the VMware backup share
#mount /mnt/esxdatastore
#export BACKUPDIR=/mnt/esxdatastore/postgresbackups/vm001

rm -f $BACKUPFILE.gz
gzip $BACKUPFILE
#cp -f $BACKUPFILE.gz $BACKUPDIR

i=7
while [ $i -gt 1 ] ; do
   j=`expr $i - 1`
   if [ -r "$BACKUPFILE.gz-$j" ]; then
      mv "$BACKUPFILE.gz-$j" "$BACKUPFILE.gz-$i"
      if [ "$BACKUPDIR" != "" ]; then
         if [ -r "$BACKUPDIR/$BACKUPFILENAME.gz-$j" ]; then
            mv "$BACKUPDIR/$BACKUPFILENAME.gz-$j" "$BACKUPDIR/$BACKUPFILENAME.gz-$i"
         fi
      fi
   fi
   i=`expr $i - 1`
done

if [ -r $BACKUPFILE.gz ]; then
   mv $BACKUPFILE.gz $BACKUPFILE.gz-1
   if [ "$BACKUPDIR" != "" ]; then
      if [ -r "$BACKUPDIR/$BACKUPFILENAME.gz" ]; then
         mv $BACKUPDIR/$BACKUPFILENAME.gz $BACKUPDIR/$BACKUPFILENAME.gz-1
      fi
   fi
fi

