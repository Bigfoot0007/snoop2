SCIM Cluster register.
cd /root/idaas/scripts
./cluster -u --id ca15346d-2621-48c0-937a-ee35e93979a8 --host 172.16.15.138:9080 --user wasadmin:root01 cbxb.cluster.properties
./cluster -l
./cluster -u --id 08d6fbfd-ec9c-4e53-b1b0-f383e9135942 --host 172.16.15.138:9080 --user wasadmin:root01 cbxb.cluster.properties


./cluster --add --host was1:9080 --user wasadmin:root01 cbxb.cluster.properties 



On pri_was run the following command. you can get a readable output.

curl -s -XGET --insecure --header 'Content-type: application/json' http://localhost:9080/ops/v1/rest/clusters --data-binary @request.json --user user:password | python -m json.tool


