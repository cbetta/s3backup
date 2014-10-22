bucket_name=''
# every 1st day of the month also copy to  month folde
suffix=`date +%Y%m`
s3cmd sync -r s3://$bucket_name/snapshots/today/ s3://$bucket_name/snapshots/months/$suffix/
