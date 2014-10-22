bucket_name=''
# every monday also copy folder to week number
suffix=`date +%Yw%V`
s3cmd sync -r s3://$bucket_name/snapshots/today/ s3://$bucket_name/snapshots/weeks/$suffix/
# every monday also remove backups more than 4 weeks ago
last_month=`date --date="5 weeks ago" +%Yw%V`
s3cmd del -r s3://$bucket_name/snapshots/weeks/$last_month/
