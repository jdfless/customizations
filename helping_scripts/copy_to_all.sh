#!/bin/bash

nodes=('dev' 'kube-jenkins' 'kube-minion1' 'kube-minion2' 'kube-minion3' 'kube-master1' 'kube-master2' 'app0' 'app1' 'kube-etcd1' 'kube-etcd2' 'kube-etcd3' 'kube-mysql')

file_to_copy=$1
# set location to second param and default to /highland
location="${2:-$HIGHLAND_ROOT}"
just_file=$(basename $file_to_copy)

echo "Are you sure you want to copy $file_to_copy to $location/$just_file on the following hosts?"
for n in "${nodes[@]}"; do
  echo -n "$n; "
done

echo ""
echo -n "NO/yes: "
read response
if [ "$response" == "yes" ]; then
  for n in "${nodes[@]}"; do
    echo "Copying to $n... "
    echo "ssh $n mkdir -p $location"
    ssh $n mkdir -p $location
    echo "scp $file_to_copy highland@$n:$location/"
    scp $file_to_copy highland@$n:$location/
  done
else
  echo "Exiting and not copying."
  exit 0
fi
