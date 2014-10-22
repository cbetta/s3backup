password=''
bucket_name=''
# get the date
suffix=`date +%Y%m%d`
# create a DB dump
mysqldump -p$password mssgk > /root/backups/dbs/$suffix.dump
# sync DB dump to DBs folder on S3
s3cmd put /root/backups/dbs/$suffix.dump s3://$bucket_name/dbs/$suffix.dump
rm /root/backups/dbs/$suffix.dump
# sync WP folder to S3
s3cmd sync -r /var/www/ s3://$bucket_name/snapshots/today/
# create copy of today's S3 folder
s3cmd sync -r s3://$bucket_name/snapshots/today/ s3://$bucket_name/snapshots/$suffix/
# remove backup from 7 days ago
last_week=`date --date="8 days ago" +%Y%m%d`
s3cmd del -r s3://$bucket_name/snapshots/$last_week/
